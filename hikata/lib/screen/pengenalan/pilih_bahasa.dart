import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/screen/alasan_beranda.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _slide = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
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
            Positioned(
              top: 60,
              left: -20,
              child: Text(
                'あ',
                style: TextStyle(
                  fontSize: 120,
                  color: Colors.white.withValues(alpha: 0.05),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              right: -20,
              child: Text(
                'ア',
                style: TextStyle(
                  fontSize: 120,
                  color: Colors.white.withValues(alpha: 0.05),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    Spacer(flex: 1),
                    FadeTransition(
                      opacity: _fade,
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.15),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.4),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text('🌏', style: TextStyle(fontSize: 38)),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Pilih Bahasa',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
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
                    Spacer(flex: 2),
                    SlideTransition(
                      position: _slide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: Column(
                          children: [
                            _LanguageCard(
                              flag: '🇮🇩',
                              name: 'Bahasa Indonesia',
                              subtitle: 'Panduan dalam Bahasa Indonesia',
                              langCode: 'id',
                              isSelected: _selectedLang == 'id',
                              onTap: () => setState(() => _selectedLang = 'id'),
                            ),
                            SizedBox(height: 16),
                            _LanguageCard(
                              flag: '🇬🇧',
                              name: 'English',
                              subtitle: 'Guide in English Language',
                              langCode: 'en',
                              isSelected: _selectedLang == 'en',
                              onTap: () => setState(() => _selectedLang = 'en'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(flex: 3),
                    FadeTransition(
                      opacity: _fade,
                      child: _ContinueButton(
                        label: _selectedLang == 'id' ? 'LANJUTKAN' : 'CONTINUE',
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                            'selected_language',
                            _selectedLang,
                          );
                          await prefs.setBool('language_selected', true);
                          AppLanguage.current = _selectedLang;
                          if (!mounted) return;
                          navigator.push(
                            MaterialPageRoute(
                              builder: (_) => HomeReasonScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    FadeTransition(
                      opacity: _fade,
                      child: Text(
                        _selectedLang == 'id'
                            ? 'Kamu bisa mengubah bahasa kapan saja'
                            : 'You can change language anytime',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.white60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 8),
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
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.secondaryGreen
                : Colors.white.withValues(alpha: 0.3),
            width: 2.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryGreen.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 36)),
            SizedBox(width: 16),
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
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: isSelected ? AppColors.textMuted : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 250),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primaryGreen : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primaryGreen : Colors.white54,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinueButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  const _ContinueButton({required this.label, required this.onPressed});

  @override
  State<_ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<_ContinueButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 120),
    );
    _scale = Tween<double>(
      begin: 1,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          widget.onPressed();
        },
        onTapCancel: () => _ctrl.reverse(),
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: AppDecorations.gradientButton.copyWith(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: AppTextStyles.buttonText.copyWith(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
