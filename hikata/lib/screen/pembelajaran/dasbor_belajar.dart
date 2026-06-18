import 'package:flutter/material.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/belajar/kartu_panduan_huruf.dart';

import 'layar_hiragana.dart';
import 'layar_katakana.dart';
import 'layar_panduan_aksara.dart';

class DasborBelajar extends StatefulWidget {
  const DasborBelajar({super.key});

  @override
  State<DasborBelajar> createState() => _DasborBelajarState();
}

class _DasborBelajarState extends State<DasborBelajar> {
  // ─── State Data ────────────────────────────────────────────────────────────
  double _hiraganaProgress = 0.0;
  double _katakanaProgress = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prog = await ProgressService.getProgress();
    if (mounted) {
      setState(() {
        _hiraganaProgress = prog.progressHiragana;
        _katakanaProgress = prog.progressKatakana;
        _isLoading = false;
      });
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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMisiHariIni(),
                  SizedBox(height: 20),
                  KartuPanduanHuruf(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LayarPanduanAksara()),
                    ),
                  ),
                  SizedBox(height: 4),
                  _buildGridModul(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final hour = DateTime.now().hour;
    String greeting = 'Ohayou / Selamat Pagi';
    if (hour >= 11 && hour < 15) {
      greeting = 'Konnichiwa / Selamat Siang';
    } else if (hour >= 15 || hour < 4) {
      greeting = 'Konbanwa / Selamat Malam';
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF2E9E5B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('🐱', style: TextStyle(fontSize: 44)),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    Text(
                      'zacth',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatPill('🔥', '2 Hari'),
              _buildStatPill('✨', '150 XP'),
              _buildStatPill('🏅', 'Pemula'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(String emoji, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Misi Hari Ini ─────────────────────────────────────────────────────────
  Widget _buildMisiHariIni() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Misi Hari Ini',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border(
              left: BorderSide(color: Color(0xFF2E9E5B), width: 6),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Selesaikan 1 Pelajaran',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFE9A825).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '+50 XP',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFFE9A825),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E9E5B)),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Grid Modul 2x2 ────────────────────────────────────────────────────────
  Widget _buildGridModul(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.9,
      children: [
        _buildGridItem(
          title: 'Hiragana',
          badgeText: 'あ',
          progressPercent: _hiraganaProgress,
          accentColor: AppColors.primaryGreen,
          isLocked: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LayarHiragana()),
            ).then((_) => _loadProgress());
          },
        ),
        _buildGridItem(
          title: 'Katakana',
          badgeText: 'ア',
          progressPercent: _katakanaProgress,
          accentColor: const Color(0xFFE9A825),
          isLocked: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LayarKatakana()),
            ).then((_) => _loadProgress());
          },
        ),
        _buildGridItem(
          title: 'Kanji',
          badgeText: '漢',
          progressPercent: 0,
          accentColor: Colors.grey,
          isLocked: true,
          onTap: () {},
        ),
        _buildGridItem(
          title: 'Percakapan',
          badgeText: '話',
          progressPercent: 0,
          accentColor: Colors.grey,
          isLocked: true,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildGridItem({
    required String title,
    required String badgeText,
    required double progressPercent,
    required Color accentColor,
    required bool isLocked,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isLocked ? Colors.grey.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isLocked
              ? null
              : Border.all(
                  color: accentColor.withValues(alpha: 0.15),
                  width: 1.5,
                ),
          boxShadow: [
            if (!isLocked)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isLocked
                    ? Colors.grey.shade200
                    : accentColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isLocked
                    ? Icon(Icons.lock_rounded, color: Colors.grey, size: 24)
                    : Text(
                        badgeText,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isLocked ? Colors.grey : AppColors.textPrimary,
              ),
            ),
            if (!isLocked) ...[
              SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progressPercent,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                  minHeight: 6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
