import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/providers/mission_provider.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/utils/animasi_rute.dart';
import 'package:ppkd_b6/widgets/belajar/kartu_panduan_huruf.dart';
import 'package:ppkd_b6/widgets/dasbor/header_dasbor.dart';
import 'package:ppkd_b6/widgets/dasbor/latihan_cepat_card.dart';
import 'package:ppkd_b6/widgets/dasbor/misi_hari_ini_card.dart';
import 'package:provider/provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<MissionProvider>().loadMissions();
    });
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
    final profileProvider = context.watch<ProfileProvider>();

    if (_isLoading || profileProvider.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryGreen),
        ),
      );
    }

    final colors = context.hiKata;

    return Scaffold(
      backgroundColor: colors.cardBackground,
      body: Column(
        children: [
          HeaderDasbor(profile: profileProvider),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (profileProvider.learnedCharacters.isNotEmpty) ...[
                    LatihanCepatCard(learnedChars: profileProvider.learnedCharacters),
                    SizedBox(height: 20),
                  ],
                  MisiHariIniWidget(
                    onMissionProgressChanged: () async {
                      await _loadProgress();
                      if (!context.mounted) return;
                      context.read<MissionProvider>().loadMissions();
                    },
                  ),
                  SizedBox(height: 20),

                  KartuPanduanHuruf(
                    onTap: () => Navigator.push(
                      context,
                      RuteAnimasiBawah(page: LayarPanduanAksara()),
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
            ).then((_) async {
              await _loadProgress();
              if (!context.mounted) return;
              context.read<MissionProvider>().loadMissions();
            });
          },
        ),
        _buildGridItem(
          title: 'Katakana',
          badgeText: 'ア',
          progressPercent: _katakanaProgress,
          accentColor: AppColors.primaryGreen,
          isLocked: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LayarKatakana()),
            ).then((_) async {
              await _loadProgress();
              if (!context.mounted) return;
              context.read<MissionProvider>().loadMissions();
            });
          },
        ),
        _buildGridItem(
          title: context.t.home.kanji,
          badgeText: '漢',
          progressPercent: 0,
          accentColor: Colors.grey,
          isLocked: true,
          onTap: () {},
        ),
        _buildGridItem(
          title: context.t.home.conversation,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.hiKata;

    return GestureDetector(
      onTap: isLocked ? () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Fitur ini akan segera hadir!'),
            backgroundColor: Colors.grey.shade800,
            duration: const Duration(seconds: 2),
          ),
        );
      } : onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? (isLocked ? colors.progressTrack : colors.cardBackground)
              : (isLocked ? Colors.grey.shade100 : Colors.white),
          borderRadius: BorderRadius.circular(20),
          border: isLocked
              ? Border.all(color: isDark ? colors.divider : Colors.transparent)
              : Border.all(
                  color: isDark
                      ? accentColor.withValues(alpha: 0.4)
                      : accentColor.withValues(alpha: 0.15),
                  width: 1.5,
                ),
          boxShadow: [
            if (!isLocked)
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
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
                    ? (isDark ? colors.divider : Colors.grey.shade200)
                    : accentColor.withValues(alpha: isDark ? 0.3 : 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isLocked
                    ? Icon(
                        Icons.lock_rounded,
                        color: isDark ? colors.textMuted : Colors.grey,
                        size: 24,
                      )
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
                color: isLocked
                    ? (isDark ? colors.textMuted : Colors.grey)
                    : (isDark ? colors.textPrimary : AppColors.textPrimary),
              ),
            ),
            if (!isLocked) ...[
              SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progressPercent,
                  backgroundColor: isDark
                      ? colors.progressTrack
                      : Colors.grey.shade200,
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
