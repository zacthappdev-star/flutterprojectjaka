import 'package:flutter/material.dart';
import 'package:ppkd_b6/database/database_helper.dart';
import 'package:ppkd_b6/screen/about/about_app_screen.dart';
import 'package:ppkd_b6/screen/layar_pengalaman.dart';
import 'package:ppkd_b6/screen/masuk.dart';
import 'package:ppkd_b6/screen/pengenalan/pilih_bahasa.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/profil/grid_statistik_profil.dart';
import 'package:ppkd_b6/widgets/profil/judul_bagian_profil.dart';
import 'package:ppkd_b6/widgets/profil/sheet_pemilih_avatar.dart';
import 'package:ppkd_b6/widgets/profil/tombol_keluar_akun.dart';
import 'package:ppkd_b6/widgets/tema/pemilih_mode_tema.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayarProfil extends StatefulWidget {
  const LayarProfil({super.key});

  @override
  State<LayarProfil> createState() => _LayarProfilState();
}

class _LayarProfilState extends State<LayarProfil> {
  // ─── State Data ────────────────────────────────────────────────────────────
  String _avatar = '🐼';
  int _hiraganaHigh = 0;
  int _katakanaHigh = 0;
  int _mixedHigh = 0;
  bool _isLoading = true;
  String _userName = 'Pelajar HI KATA';
  String _userEmail = '';
  int _currentStreak = 0;
  int _bestStreak = 0;
  int _totalQuizzes = 0;
  int _overallHigh = 0;
  double _progressHiragana = 0.0;
  double _progressKatakana = 0.0;
  final List<String> _avatars = ['🐼', '🍣', '🍡', '🦊', '🐱'];
  bool get _isID => AppLanguage.current == 'id';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final userId = await ProgressService.getActiveUserId();
    if (userId == null) return;

    final dbHelper = DatabaseHelper.instance;
    final user = await dbHelper.getUser(userId);
    final streak = await dbHelper.getStreak(userId);
    final stats = await dbHelper.getQuizStats(userId);
    final progress = await dbHelper.getProgress(userId);

    setState(() {
      _avatar = user?['avatar'] ?? '🐼';
      _userName = user?['nama'] ?? 'Pelajar HI KATA';
      _userEmail = user?['email'] ?? '';
      _currentStreak = streak?['current_streak'] ?? 0;
      _bestStreak = streak?['best_streak'] ?? 0;
      _totalQuizzes = stats['total_completed'] ?? 0;
      _overallHigh = stats['overall_high'] ?? 0;
      _hiraganaHigh = stats['hiragana_high'] ?? 0;
      _katakanaHigh = stats['katakana_high'] ?? 0;
      _mixedHigh = stats['mixed_high'] ?? 0;
      _progressHiragana = progress?['hiragana_percent'] ?? 0.0;
      _progressKatakana = progress?['katakana_percent'] ?? 0.0;
      _isLoading = false;
    });
  }

  Future<void> _updateAvatar(String newAvatar) async {
    final userId = await ProgressService.getActiveUserId();
    if (userId != null) {
      await DatabaseHelper.instance.updateAvatar(userId, newAvatar);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_avatar', newAvatar);
      setState(() => _avatar = newAvatar);
    }
  }

  // ─── UI Utama ──────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryGreen),
        ),
      );
    }

    final colors = context.hiKata;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: colors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                _buildJudulLayar(),
                SizedBox(height: 16),
                _buildKartuProfil(colors),
                SizedBox(height: 12),
                _buildBagianStatistik(colors),
                SizedBox(height: 12),
                _buildBagianSkor(),
                SizedBox(height: 12),
                _buildBagianTampilan(),
                SizedBox(height: 12),
                _buildBagianLainnya(),
                SizedBox(height: 16),
                TombolKeluarAkun(
                  isID: _isID,
                  onTap: () => _showLogoutDialog(context),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Komponen Layar ────────────────────────────────────────────────────────
  Widget _buildJudulLayar() {
    return Center(
      child: Text(
        _isID ? 'Profil Saya' : 'My Profile',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildKartuProfil(HiKataColors colors) {
    return Container(
      width: double.infinity,
      height: 96,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: colors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGreen.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _showAvatarPicker,
            child: Stack(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: colors.lightBackground,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryGreen.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(_avatar, style: TextStyle(fontSize: 34)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 9,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (_userEmail.isNotEmpty) ...[
                  SizedBox(height: 2),
                  Text(
                    _userEmail,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: colors.textOnCardSubtitle,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBagianStatistik(HiKataColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JudulBagianProfil(
          title: _isID ? 'Statistik Belajar' : 'Study Statistics',
        ),
        SizedBox(height: 10),
        GridStatistikProfil(
          currentStreak: _currentStreak,
          bestStreak: _bestStreak,
          totalQuizzes: _totalQuizzes,
          overallHigh: _overallHigh,
          progressHiragana: _progressHiragana,
          progressKatakana: _progressKatakana,
          isID: _isID,
        ),
      ],
    );
  }

  Widget _buildBagianTampilan() {
    final colors = context.hiKata;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JudulBagianProfil(title: _isID ? 'Pengaturan Tampilan' : 'Appearance'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGreen.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: PemilihModeTema(isID: _isID),
        ),
      ],
    );
  }

  Widget _buildBagianLainnya() {
    final colors = context.hiKata;
    return Column(
      children: [
        JudulBagianProfil(title: _isID ? 'Lainnya' : 'More'),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: AppDecorations.cardDecorationOf(context),
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ExperienceScreen()),
                  ),
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: Icon(
                      Icons.feedback_outlined,
                      color: AppColors.primaryGreen,
                      size: 20,
                    ),
                    title: Text(
                      _isID ? 'Beri Masukan' : 'Feedback',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(height: 1, thickness: 0.8, indent: 16, endIndent: 16),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AboutAppScreen()),
                  ),
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.primaryGreen,
                      size: 20,
                    ),
                    title: Text(
                      _isID ? 'Tentang Aplikasi' : 'About App',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(height: 1, thickness: 0.8, indent: 16, endIndent: 16),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showDeleteAccountDialog(),
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                      size: 20,
                    ),
                    title: Text(
                      _isID ? 'Hapus Akun' : 'Delete Account',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBagianSkor() {
    final colors = context.hiKata;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JudulBagianProfil(
          title: _isID ? 'Pencapaian Quiz' : 'Quiz Achievements',
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGreen.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildCompactScoreRow(
                title: 'Hiragana Quiz',
                score: _hiraganaHigh,
                iconColor: AppColors.primaryGreen,
                isID: _isID,
              ),
              Divider(height: 8, thickness: 0.5),
              _buildCompactScoreRow(
                title: 'Katakana Quiz',
                score: _katakanaHigh,
                iconColor: isDark
                    ? Color(0xFFC5CAE9)
                    : Color.fromARGB(223, 158, 175, 0),
                isID: _isID,
                isKatakana: true,
              ),
              Divider(height: 8, thickness: 0.5),
              _buildCompactScoreRow(
                title: _isID ? 'Quiz Campuran' : 'Mixed Quiz',
                score: _mixedHigh,
                iconColor: Color(0xFFE65100),
                isID: _isID,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactScoreRow({
    required String title,
    required int score,
    required Color iconColor,
    required bool isID,
    bool isKatakana = false,
  }) {
    final colors = context.hiKata;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.stars_rounded, color: iconColor, size: 16),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isKatakana && isDark ? iconColor : colors.textPrimary,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isKatakana && isDark
                  ? iconColor.withValues(alpha: 0.15)
                  : colors.lightBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$score/10',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: isKatakana && isDark ? iconColor : colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Dialog & Sheet ──────────────────────────────────────────────────────────
  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => SheetPemilihAvatar(
        isID: _isID,
        avatarSaatIni: _avatar,
        daftarAvatar: _avatars,
        onPilih: (av) {
          _updateAvatar(av);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          _isID ? 'Keluar Akun?' : 'Log Out?',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        content: Text(
          _isID
              ? 'Apakah kamu yakin ingin keluar dan kembali ke halaman login?'
              : 'Are you sure you want to log out and return to the login screen?',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              _isID ? 'Batal' : 'Cancel',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.primaryGreen,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final navigator = Navigator.of(context, rootNavigator: true);
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false,
              );
            },
            child: Text(
              _isID ? 'Keluar' : 'Log Out',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    final colors = context.hiKata;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                _isID ? 'Hapus Akun Permanen?' : 'Delete Account Permanently?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          _isID
              ? 'Tindakan ini tidak dapat dibatalkan. Seluruh data progres belajar, riwayat kuis, streak, dan karakter terpelajar akan dihapus secara permanen dari sistem.'
              : 'This action cannot be undone. All your study progress, quiz history, streak, and learned characters will be permanently deleted from the system.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: colors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              _isID ? 'Batal' : 'Cancel',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Tutup dialog konfirmasi
              final userId = await ProgressService.getActiveUserId();
              if (userId != null) {
                final success = await DatabaseHelper.instance.deleteUser(
                  userId,
                );
                if (success) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  if (!mounted) return;
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
                  );
                }
              }
            },
            child: Text(
              _isID ? 'Hapus Akun' : 'Delete Account',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
