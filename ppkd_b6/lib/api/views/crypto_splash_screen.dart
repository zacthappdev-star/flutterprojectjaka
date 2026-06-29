import 'package:flutter/material.dart';
import 'package:ppkd_b6/api/views/crypto_navigator.dart';

class CryptoSplashScreen extends StatefulWidget {
  static const String routeName = '/crypto_splash';
  const CryptoSplashScreen({super.key});

  @override
  State<CryptoSplashScreen> createState() => _CryptoSplashScreenState();
}

class _CryptoSplashScreenState extends State<CryptoSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup Animasi
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
    _checkLoginStatus();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkLoginStatus() async {
    // Wait for 3 seconds to show splash
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    // Langsung arahkan ke halaman utama Crypto (abaikan login)
    Navigator.pushReplacementNamed(context, CryptoNavigator.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0F1A), Color(0xFF131829), Color(0xFF0D0F14)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            // Logo Kripto Beranimasi (Membesar)
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF38D782).withValues(alpha: 0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF38D782).withValues(alpha: 0.25),
                      blurRadius: 60,
                      spreadRadius: 20,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.currency_bitcoin_rounded,
                  color: Color(0xFF38D782),
                  size: 80,
                ),
              ),
            ),
            SizedBox(height: 40),
            // Teks Beranimasi (Muncul Perlahan)
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Text(
                    'Zacth Crypto',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.5,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Masa Depan Aset Digital',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            // Indikator Loading
            FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: CircularProgressIndicator(
                  color: Color(0xFF38D782),
                  strokeWidth: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
