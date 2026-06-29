import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ppkd_b6/screen/tata_utama.dart';
import 'package:ppkd_b6/theme/aset_aplikasi.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'masuk.dart';
import 'package:ppkd_b6/screen/pengenalan/pilih_bahasa.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();

    _navTimer = Timer(Duration(seconds: 4), () async {
      if (mounted) {
        final prefs = await SharedPreferences.getInstance();
        final userId = prefs.getInt('active_user_id');
        final bool onboardingDone = prefs.getBool('has_completed_onboarding') ?? false;
        
        Widget nextScreen;
        if (userId != null) {
          nextScreen = TataUtama();
        } else if (onboardingDone) {
          nextScreen = LoginScreen();
        } else {
          nextScreen = LanguageSelectScreen();
        }

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: Duration(seconds: 1),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradient = context.hiKata.backgroundGradient;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(24),
                          child: Image.asset(
                            AppAssets.hikatalogotext,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        color: Colors.white.withValues(alpha: 0.8),
                        strokeWidth: 2.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
