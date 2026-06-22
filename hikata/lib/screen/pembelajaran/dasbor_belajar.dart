import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/providers/mission_provider.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/belajar/kartu_panduan_huruf.dart';
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
          _buildHeader(profileProvider),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMisiHariIni(context),
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

  Widget _buildHeader(ProfileProvider profile) {
    final hour = DateTime.now().hour;
    final t = context.t.home;
    String greeting = t.morning;
    if (hour >= 11 && hour < 15) {
      greeting = t.afternoon;
    } else if (hour >= 15 || hour < 4) {
      greeting = t.night;
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
              Text(profile.avatar, style: TextStyle(fontSize: 44)),
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
                      profile.userName,
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
              _buildStatPill('🔥', t.days(count: profile.currentStreak)),
              _buildStatPill('✨', t.xp(count: profile.totalXP)),
              _buildStatPill(profile.rankIcon, profile.rankName),
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
  Widget _buildMisiHariIni(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.hiKata;
    final missionProvider = context.watch<MissionProvider>();

    if (missionProvider.isLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CircularProgressIndicator(color: AppColors.primaryGreen),
        ),
      );
    }

    final missions = missionProvider.missions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t.home.dailyMission,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? colors.textPrimary : AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12),
        Column(
          children: missions
              .map(
                (m) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildMisiCard(context, m),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildMisiCard(BuildContext context, Mission mission) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.hiKata;

    final bool isCompleted = mission.isCompleted;
    final bool isClaimed = mission.isClaimed;
    final double progress = mission.progress;
    final String title = mission.title;
    final int xp = mission.xp;
    final IconData icon = mission.icon;

    return GestureDetector(
      onTap: () async {
        if (isCompleted && !isClaimed) {
          final missionProv = context.read<MissionProvider>();
          final profileProv = context.read<ProfileProvider>();
          final scaffoldMessenger = ScaffoldMessenger.of(context);

          await missionProv.claimMission(mission.id);
          await profileProv.refresh();

          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text('Berhasil klaim $xp XP!'),
              backgroundColor: AppColors.primaryGreen,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? colors.cardBackground : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(
              color: isCompleted
                  ? const Color(0xFF2E9E5B)
                  : (isDark ? colors.divider : Colors.grey.shade300),
              width: 6,
            ),
            top: BorderSide(
              color: isDark ? colors.divider : Colors.grey.shade100,
            ),
            right: BorderSide(
              color: isDark ? colors.divider : Colors.grey.shade100,
            ),
            bottom: BorderSide(
              color: isDark ? colors.divider : Colors.grey.shade100,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isCompleted
                    ? const Color(0xFF2E9E5B).withValues(alpha: 0.15)
                    : (isDark ? colors.divider : Colors.grey.shade100),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: isCompleted
                    ? const Color(0xFF2E9E5B)
                    : (isDark ? colors.textMuted : Colors.grey.shade500),
              ),
            ),
            const SizedBox(width: 14),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isCompleted
                                ? (isDark
                                      ? colors.textPrimary
                                      : AppColors.textPrimary)
                                : (isDark
                                      ? colors.textMuted
                                      : Colors.grey.shade600),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isClaimed
                              ? (isDark ? colors.divider : Colors.grey.shade200)
                              : isCompleted
                              ? (isDark
                                    ? const Color(0xFF4A3E1B)
                                    : const Color(
                                        0xFFE9A825,
                                      ).withValues(alpha: 0.15))
                              : (isDark
                                    ? colors.divider
                                    : Colors.grey.shade100),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!isClaimed)
                              Icon(
                                Icons.star_rounded,
                                size: 12,
                                color: isCompleted
                                    ? const Color(0xFFE9A825)
                                    : Colors.grey.shade500,
                              ),
                            if (!isClaimed) const SizedBox(width: 4),
                            Text(
                              isClaimed ? 'Diklaim' : '+$xp XP',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: isClaimed
                                    ? Colors.grey.shade500
                                    : (isCompleted
                                          ? const Color(0xFFE9A825)
                                          : Colors.grey.shade600),
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: isDark
                                ? colors.progressTrack
                                : Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isCompleted
                                  ? const Color(0xFF2E9E5B)
                                  : Colors.blue.shade400,
                            ),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      if (isCompleted && !isClaimed) ...[
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E9E5B),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'KLAIM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ] else if (isClaimed) ...[
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFF2E9E5B),
                          size: 16,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
      onTap: isLocked ? null : onTap,
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
