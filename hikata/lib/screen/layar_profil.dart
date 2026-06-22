import 'package:flutter/material.dart';
import 'package:ppkd_b6/database/database_helper.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';
import 'package:ppkd_b6/screen/about/about_app_screen.dart';
import 'package:ppkd_b6/screen/layar_pengalaman.dart';
import 'package:ppkd_b6/screen/masuk.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/profil/bagian_skor.dart';
import 'package:ppkd_b6/widgets/profil/grid_statistik_profil.dart';
import 'package:ppkd_b6/widgets/profil/hero_profil.dart';
import 'package:ppkd_b6/widgets/profil/judul_bagian_profil.dart';
import 'package:ppkd_b6/widgets/profil/tombol_keluar_akun.dart';
import 'package:ppkd_b6/widgets/tema/pemilih_mode_tema.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayarProfil extends StatefulWidget {
  const LayarProfil({super.key});

  @override
  State<LayarProfil> createState() => _LayarProfilState();
}

class _LayarProfilState extends State<LayarProfil> {
  final List<String> _avatars = ['🐼', '🍣', '🍡', '🦊', '🐱'];

  // ─── UI Utama ──────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();

    if (profileProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryGreen),
        ),
      );
    }

    return Scaffold(
      backgroundColor: context.hiKata.cardBackground,
      body: Column(
        children: [
          HeroProfil(avatars: _avatars),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBagianStatistik(profileProvider),
                  SizedBox(height: 24),
                  _buildBagianBadge(profileProvider),
                  SizedBox(height: 24),
                  BagianSkor(),
                  SizedBox(height: 24),
                  _buildBagianTampilan(),
                  SizedBox(height: 24),
                  _buildBagianLainnya(),
                  SizedBox(height: 24),
                  _buildHapusAkun(),
                  SizedBox(height: 24),
                  TombolKeluarAkun(onTap: () => _showLogoutDialog(context)),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Komponen Layar ────────────────────────────────────────────────────────
  Widget _buildBagianStatistik(ProfileProvider profileProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JudulBagianProfil(title: context.t.profile.studyStatistics),
        SizedBox(height: 10),
        GridStatistikProfil(
          currentStreak: profileProvider.currentStreak,
          bestStreak: profileProvider.bestStreak,
          totalQuizzes: profileProvider.totalQuizzes,
          overallHigh: profileProvider.overallHigh,
          progressHiragana: profileProvider.progressHiragana,
          progressKatakana: profileProvider.progressKatakana,
        ),
      ],
    );
  }

  Widget _buildBagianBadge(ProfileProvider profile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.hiKata;

    final badges = [
      {'icon': profile.rankIcon, 'name': profile.rankName, 'unlocked': true},
      {'icon': '🔥', 'name': context.t.home.days(count: profile.bestStreak), 'unlocked': profile.bestStreak >= 7},
      {'icon': 'あ', 'name': 'Hiragana', 'unlocked': profile.progressHiragana > 0.0},
      {'icon': 'ア', 'name': 'Katakana', 'unlocked': profile.progressKatakana > 0.0},
      {'icon': '👑', 'name': 'Master', 'unlocked': profile.totalXP > 1500},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JudulBagianProfil(title: context.t.profile.badgesEarned),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: badges.map((badge) {
              final isUnlocked = badge['unlocked'] as bool;
              return Opacity(
                opacity: isUnlocked ? 1.0 : 0.3,
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? colors.cardBackground : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isDark ? colors.divider : Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        badge['icon'] as String,
                        style: const TextStyle(fontSize: 28),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        badge['name'] as String,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBagianTampilan() {
    final colors = context.hiKata;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JudulBagianProfil(title: context.t.profile.appearance),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGreen.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const PemilihModeTema(),
        ),
      ],
    );
  }

  Widget _buildBagianLainnya() {
    final colors = context.hiKata;
    return Column(
      children: [
        JudulBagianProfil(title: context.t.profile.more),
        const SizedBox(height: 10),
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
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: const Icon(
                      Icons.feedback_outlined,
                      color: AppColors.primaryGreen,
                      size: 20,
                    ),
                    title: Text(
                      context.t.profile.feedback,
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
              const Divider(
                height: 1,
                thickness: 0.8,
                indent: 16,
                endIndent: 16,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AboutAppScreen()),
                  ),
                  child: ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: const Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.primaryGreen,
                      size: 20,
                    ),
                    title: Text(
                      context.t.profile.aboutApp,
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHapusAkun() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JudulBagianProfil(title: context.t.profile.deleteAccount),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => _showDeleteAccountDialog(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF3B1A1A) : const Color(0xFFFFF5F5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? Colors.red.shade900 : Colors.red.shade200),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.t.profile.deleteAccount,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        context.t.profile.deleteDataWarning,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: Colors.red.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─── Dialog & Sheet ──────────────────────────────────────────────────────────

  void _showLogoutDialog(BuildContext context) {
    final colors = context.hiKata;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: colors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          context.t.profile.logoutTitle,
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: colors.textPrimary),
        ),
        content: Text(
          context.t.profile.logoutConfirmText,
          style: TextStyle(fontFamily: 'Poppins', color: colors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.t.profile.cancel,
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
              context.t.profile.logout,
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
        backgroundColor: colors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                context.t.profile.deleteAccountTitle,
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
          context.t.profile.deleteAccountConfirmText,
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
              context.t.profile.cancel,
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
              context.t.profile.deleteAccount,
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
