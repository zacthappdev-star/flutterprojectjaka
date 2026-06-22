import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class GridStatistikProfil extends StatelessWidget {
  final int currentStreak;
  final int bestStreak;
  final int totalQuizzes;
  final int overallHigh;
  final double progressHiragana;
  final double progressKatakana;

  const GridStatistikProfil({
    super.key,
    required this.currentStreak,
    required this.bestStreak,
    required this.totalQuizzes,
    required this.overallHigh,
    required this.progressHiragana,
    required this.progressKatakana,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.hiKata;
    final t = Translations.of(context);

    if (totalQuizzes == 0) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
          color: isDark ? colors.cardBackground : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? colors.divider : Colors.grey.shade200,
          ),
        ),
        child: Column(
          children: [
            Text('📭', style: TextStyle(fontSize: 48)),
            SizedBox(height: 16),
            Text(
              t.profile.statistics.noQuizHistory,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isDark ? colors.textPrimary : Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8),
            Text(
              t.profile.statistics.startFirstQuiz,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: isDark ? colors.textMuted : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1.1,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        // Streak Saat Ini
        _buildStatisticCard(
          context,
          icon: '🔥',
          label: t.profile.statistics.currentStreak,
          value: '$currentStreak',
          subValue: t.profile.statistics.days,
          backgroundColor: Colors.orange.withValues(alpha: 0.1),
          accentColor: Colors.orange,
        ),
        // Streak Terbaik
        _buildStatisticCard(
          context,
          icon: '🏆',
          label: t.profile.statistics.bestStreak,
          value: '$bestStreak',
          subValue: t.profile.statistics.days,
          backgroundColor: Colors.amber.withValues(alpha: 0.1),
          accentColor: Colors.amber,
        ),
        // Total Quiz Dikerjakan
        _buildStatisticCard(
          context,
          icon: '📝',
          label: t.profile.statistics.totalQuiz,
          value: '$totalQuizzes',
          subValue: t.profile.statistics.completed,
          backgroundColor: Colors.blue.withValues(alpha: 0.1),
          accentColor: Colors.blue,
        ),
        // Skor Tertinggi
        _buildStatisticCard(
          context,
          icon: '⭐',
          label: t.profile.statistics.highScore,
          value: '$overallHigh',
          subValue: '/100',
          backgroundColor: Colors.amber.withValues(alpha: 0.12),
          accentColor: Colors.amber,
        ),
        // Progres Hiragana
        _buildStatisticCard(
          context,
          icon: 'あ',
          label: t.profile.statistics.hiragana,
          value: '${(progressHiragana * 100).toInt()}%',
          subValue: t.profile.statistics.progress,
          backgroundColor: AppColors.primaryGreen.withValues(alpha: 0.1),
          accentColor: AppColors.primaryGreen,
        ),
        // Progres Katakana
        _buildStatisticCard(
          context,
          icon: 'ア',
          label: t.profile.statistics.katakana,
          value: '${(progressKatakana * 100).toInt()}%',
          subValue: t.profile.statistics.progress,
          backgroundColor: isDark
              ? Color(0xFFC5CAE9).withValues(alpha: 0.15)
              : Color(0xFF3949AB).withValues(alpha: 0.1),
          accentColor: isDark ? Color(0xFFC5CAE9) : Color(0xFF3949AB),
          isKatakana: true,
        ),
      ],
    );
  }

  Widget _buildStatisticCard(
    BuildContext context, {
    required String icon,
    required String label,
    required String value,
    required String subValue,
    required Color backgroundColor,
    required Color accentColor,
    bool isKatakana = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.hiKata;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? colors.cardBackground : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? colors.divider : Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: TextStyle(fontSize: 32)),
            SizedBox(height: 8),
            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: value,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: isDark ? colors.textPrimary : Color(0xFF1A1A1A),
                ),
                children: [
                  TextSpan(
                    text: ' $subValue',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isDark ? colors.textMuted : Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? colors.textMuted : Colors.grey.shade500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
