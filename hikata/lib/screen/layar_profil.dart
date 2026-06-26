import 'package:flutter/material.dart';
import 'package:ppkd_b6/database/database_helper.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';
import 'package:ppkd_b6/screen/about/about_app_screen.dart';
import 'package:ppkd_b6/screen/layar_pengalaman.dart';
import 'package:ppkd_b6/screen/masuk.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/profil/hero_profil.dart';
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

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final colors = context.hiKata;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (profileProvider.isLoading) {
      return Scaffold(
        backgroundColor: colors.cardBackground,
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.primaryGreen),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors.cardBackground,
      body: Column(
        children: [
          HeroProfil(avatars: _avatars),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── TEMA ───
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: AppColors.primaryGreen.withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                      ],
                    ),
                    child: const PemilihModeTema(),
                  ),
                  const SizedBox(height: 32),

                  // ─── INFO & FEEDBACK ───
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: AppColors.primaryGreen.withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // ─── BAHASA ───
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                            onTap: _showLanguageSheet,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.language_rounded,
                                    color: AppColors.primaryGreen,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      context.t.settings.language,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: colors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    LocaleSettings.currentLocale.languageCode == 'en'
                                        ? context.t.language.english
                                        : context.t.language.indonesian,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: colors.textMuted,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    color: colors.textMuted,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: colors.divider,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ExperienceScreen()),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.feedback_outlined,
                                    color: AppColors.primaryGreen,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    context.t.profile.feedback,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: colors.divider,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AboutAppScreen()),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: AppColors.primaryGreen,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    context.t.profile.aboutApp,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ─── HAPUS AKUN ───
                  Text(
                    context.t.profile.deleteAccount,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: isDark ? colors.textMuted : Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => _showDeleteAccountDialog(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF3B1A1A) : const Color(0xFFFFF5F5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isDark ? Colors.red.shade900 : Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.t.profile.deleteAccount,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
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

                  const SizedBox(height: 24),

                  // ─── KELUAR ───
                  TombolKeluarAkun(onTap: () => _showLogoutDialog(context)),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Dialog & Sheet ──────────────────────────────────────────────────────────

  void _showLanguageSheet() {
    final colors = context.hiKata;
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        final current = LocaleSettings.currentLocale.languageCode;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colors.divider,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.t.settings.language,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                _LanguageOption(
                  flag: '🇮🇩',
                  name: context.t.language.indonesian,
                  selected: current == 'id',
                  onTap: () => _changeLanguage('id'),
                ),
                const SizedBox(height: 10),
                _LanguageOption(
                  flag: '🇬🇧',
                  name: context.t.language.english,
                  selected: current == 'en',
                  onTap: () => _changeLanguage('en'),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _changeLanguage(String langCode) async {
    Navigator.pop(context);
    if (LocaleSettings.currentLocale.languageCode == langCode) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', langCode);
    LocaleSettings.setLocaleRaw(langCode);
    if (mounted) setState(() {});
  }

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
              final navigator = Navigator.of(context, rootNavigator: true);
              final profileProv = context.read<ProfileProvider>();
              Navigator.pop(context);
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              profileProv.clear();
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
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
            const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                context.t.profile.deleteAccountTitle,
                style: const TextStyle(
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
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context, rootNavigator: true);
              final profileProv = context.read<ProfileProvider>();
              Navigator.pop(context);
              final userId = await ProgressService.getActiveUserId();
              if (userId != null) {
                final success = await DatabaseHelper.instance.deleteUser(userId);
                if (success) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  profileProv.clear();
                  navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                }
              }
            },
            child: Text(
              context.t.profile.deleteAccount,
              style: const TextStyle(
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

class _LanguageOption extends StatelessWidget {
  final String flag;
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.flag,
    required this.name,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primaryGreen.withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.primaryGreen : colors.divider,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 26)),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primaryGreen,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
