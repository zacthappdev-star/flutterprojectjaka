import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/providers/mission_provider.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';
import 'package:ppkd_b6/screen/kuis/layar_kuis.dart';
import 'package:ppkd_b6/screen/pembelajaran/layar_hiragana.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:provider/provider.dart';

class MisiHariIniWidget extends StatelessWidget {
  final VoidCallback onMissionProgressChanged;

  const MisiHariIniWidget({
    super.key,
    required this.onMissionProgressChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.hiKata;
    final missionProvider = context.watch<MissionProvider>();

    if (missionProvider.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
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
        const SizedBox(height: 12),
        Column(
          children: missions
              .map(
                (m) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MisiCard(
                    mission: m,
                    onMissionProgressChanged: onMissionProgressChanged,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class MisiCard extends StatelessWidget {
  final Mission mission;
  final VoidCallback onMissionProgressChanged;

  const MisiCard({
    super.key,
    required this.mission,
    required this.onMissionProgressChanged,
  });

  @override
  Widget build(BuildContext context) {
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
          final claimMsg = context.t.home.claimedXP(xp: xp.toString());

          // Show floating XP animation
          final overlay = Overlay.of(context);
          final renderBox = context.findRenderObject() as RenderBox?;
          if (renderBox != null) {
            final offset = renderBox.localToGlobal(Offset.zero);
            late OverlayEntry entry;
            entry = OverlayEntry(
              builder: (ctx) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOutCubic,
                  onEnd: () {
                    if (entry.mounted) entry.remove();
                  },
                  builder: (ctx, val, child) {
                    return Positioned(
                      top: offset.dy - (val * 100),
                      left: offset.dx + (renderBox.size.width / 2) - 20,
                      child: Opacity(
                        opacity: 1.0 - val,
                        child: Text(
                          '+$xp XP',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.amber,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
            overlay.insert(entry);
          }

          await missionProv.claimMission(mission.id);
          await profileProv.refresh();

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(claimMsg),
                backgroundColor: AppColors.primaryGreen,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        } else if (!isCompleted) {
          if (mission.id == 'lesson') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LayarHiragana()),
            ).then((_) {
              onMissionProgressChanged();
            });
          } else if (mission.id == 'quiz_mixed') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const QuizScreen(mode: 'mixed'),
              ),
            ).then((_) {
              onMissionProgressChanged();
            });
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? colors.cardBackground : AppColors.fieldFill,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark
                ? colors.divider
                : AppColors.primaryGreen.withValues(alpha: 0.3),
            width: 1.5,
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
                    : (isDark
                          ? colors.divider
                          : AppColors.primaryGreen.withValues(alpha: 0.1)),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: isCompleted
                    ? const Color(0xFF2E9E5B)
                    : (isDark
                          ? colors.textMuted
                          : AppColors.primaryGreen.withValues(alpha: 0.6)),
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
                                      : AppColors.textPrimary.withValues(
                                          alpha: 0.8,
                                        )),
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
                              ? (isDark
                                    ? colors.divider
                                    : AppColors.primaryGreen.withValues(
                                        alpha: 0.1,
                                      ))
                              : isCompleted
                              ? (isDark
                                    ? const Color(0xFF4A3E1B)
                                    : const Color(
                                        0xFFE9A825,
                                      ).withValues(alpha: 0.15))
                              : (isDark
                                    ? colors.divider
                                    : AppColors.primaryGreen.withValues(
                                        alpha: 0.1,
                                      )),
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
                                    : (isDark
                                          ? Colors.grey.shade500
                                          : AppColors.primaryGreen.withValues(
                                              alpha: 0.6,
                                            )),
                              ),
                            if (!isClaimed) const SizedBox(width: 4),
                            Text(
                              isClaimed ? context.t.home.claimed : '+$xp XP',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: isClaimed
                                    ? (isDark
                                          ? Colors.grey.shade500
                                          : AppColors.primaryGreen.withValues(
                                              alpha: 0.5,
                                            ))
                                    : (isCompleted
                                          ? const Color(0xFFE9A825)
                                          : (isDark
                                                ? Colors.grey.shade600
                                                : AppColors.primaryGreen)),
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
                          child: Text(
                            context.t.home.claim,
                            style: const TextStyle(
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
}
