import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class GridStatistikProfil extends StatelessWidget {
  final int currentStreak;
  final int bestStreak;
  final int totalQuizzes;
  final int overallHigh;
  final double progressHiragana;
  final double progressKatakana;
  final bool isID;

  const GridStatistikProfil({
    super.key,
    required this.currentStreak,
    required this.bestStreak,
    required this.totalQuizzes,
    required this.overallHigh,
    required this.progressHiragana,
    required this.progressKatakana,
    required this.isID,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 2.1,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        // Streak Saat Ini
        _buildStatisticCard(
          context,
          icon: '🔥',
          label: isID ? 'Streak Saat Ini' : 'Current Streak',
          value: '$currentStreak',
          subValue: isID ? 'Hari' : 'Days',
          backgroundColor: Colors.orange.withValues(alpha: 0.1),
          accentColor: Colors.orange,
        ),
        // Streak Terbaik
        _buildStatisticCard(
          context,
          icon: '🏆',
          label: isID ? 'Streak Terbaik' : 'Best Streak',
          value: '$bestStreak',
          subValue: isID ? 'Hari' : 'Days',
          backgroundColor: Colors.amber.withValues(alpha: 0.1),
          accentColor: Colors.amber,
        ),
        // Total Quiz Dikerjakan
        _buildStatisticCard(
          context,
          icon: '📝',
          label: isID ? 'Total Quiz' : 'Total Quiz',
          value: '$totalQuizzes',
          subValue: isID ? 'Dikerjakan' : 'Completed',
          backgroundColor: Colors.blue.withValues(alpha: 0.1),
          accentColor: Colors.blue,
        ),
        // Skor Tertinggi
        _buildStatisticCard(
          context,
          icon: '⭐',
          label: isID ? 'Skor Tertinggi' : 'High Score',
          value: '$overallHigh',
          subValue: '/100',
          backgroundColor: Colors.amber.withValues(alpha: 0.12),
          accentColor: Colors.amber,
        ),
        // Progres Hiragana
        _buildStatisticCard(
          context,
          icon: 'あ',
          label: isID ? 'Hiragana' : 'Hiragana',
          value: '${(progressHiragana * 100).toInt()}%',
          subValue: isID ? 'Progres' : 'Progress',
          backgroundColor: AppColors.primaryGreen.withValues(alpha: 0.1),
          accentColor: AppColors.primaryGreen,
        ),
        // Progres Katakana
        _buildStatisticCard(
          context,
          icon: 'ア',
          label: isID ? 'Katakana' : 'Katakana',
          value: '${(progressKatakana * 100).toInt()}%',
          subValue: isID ? 'Progres' : 'Progress',
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
    final colors = context.hiKata;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isKatakana && isDark
              ? accentColor.withValues(alpha: 0.4)
              : colors.divider.withValues(alpha: 0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  icon,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isKatakana && isDark ? accentColor : null,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: value,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: isKatakana && isDark
                            ? accentColor
                            : colors.textPrimary,
                      ),
                      children: [
                        TextSpan(
                          text: ' $subValue',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: isKatakana && isDark
                          ? accentColor
                          : colors.textMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
