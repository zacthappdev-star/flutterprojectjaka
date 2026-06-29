import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/widgets/common/tombol_lanjut.dart';
import 'package:ppkd_b6/screen/alasan_beranda.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ppkd_b6/screen/masuk.dart';

class AppLanguage {
  static String get current => LocaleSettings.currentLocale.languageCode;
  static set current(String value) => LocaleSettings.setLocaleRaw(value);
}

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen>
    with SingleTickerProviderStateMixin {
  String _selectedLang = 'id';
  late AnimationController _anim;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fade = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Stack(
          children: [
            // Decorative background characters
            Positioned(
              top: 80,
              left: -40,
              child: Text(
                'あ',
                style: TextStyle(
                  fontSize: 180,
                  color: Colors.white.withValues(alpha: 0.05),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: -30,
              child: Text(
                'ア',
                style: TextStyle(
                  fontSize: 160,
                  color: Colors.white.withValues(alpha: 0.04),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    const Spacer(flex: 1),
                    FadeTransition(
                      opacity: _fade,
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.15),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.4),
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: Text('🌏', style: TextStyle(fontSize: 34)),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            context.t.language.title,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Choose Language',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    SlideTransition(
                      position: _slide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: Column(
                          children: [
                            _LanguageCard(
                              flag: '🇮🇩',
                              name: context.t.language.indonesian,
                              subtitle: context.t.language.indonesianDesc,
                              langCode: 'id',
                              isSelected: _selectedLang == 'id',
                              onTap: () => setState(() => _selectedLang = 'id'),
                            ),
                            const SizedBox(height: 16),
                            _LanguageCard(
                              flag: '🇬🇧',
                              name: context.t.language.english,
                              subtitle: context.t.language.englishDesc,
                              langCode: 'en',
                              isSelected: _selectedLang == 'en',
                              onTap: () => setState(() => _selectedLang = 'en'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                    FadeTransition(
                      opacity: _fade,
                      child: TombolLanjut(
                        label: context.t.common.continueText,
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('selected_language', _selectedLang);
                          await prefs.setBool('language_selected', true);
                          AppLanguage.current = _selectedLang;
                          if (!mounted) return;
                          navigator.push(
                            MaterialPageRoute(
                              builder: (_) => const HomeReasonScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    FadeTransition(
                      opacity: _fade,
                      child: Text(
                        _selectedLang == 'id'
                            ? context.t.language.changeAnytime
                            : context.t.language.changeAnytimeEn,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.white60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeTransition(
                      opacity: _fade,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sudah punya akun? Masuk",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String flag;
  final String name;
  final String subtitle;
  final String langCode;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.flag,
    required this.name,
    required this.subtitle,
    required this.langCode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : Colors.white.withValues(alpha: 0.3),
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColors.textPrimary : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.5,
                      color: isSelected ? Colors.grey.shade500 : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primaryGreen : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primaryGreen : Colors.white54,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

