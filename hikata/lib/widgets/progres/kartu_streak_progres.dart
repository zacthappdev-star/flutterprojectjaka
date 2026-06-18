import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class KartuStreakProgres extends StatelessWidget {
  final int dailyStreak;

  const KartuStreakProgres({
    super.key,
    required this.dailyStreak,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(left: BorderSide(color: Color(0xFFFF8F00), width: 6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('🔥', style: TextStyle(fontSize: 32)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translations.of(context).progress.studyStreak,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: colors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  Translations.of(context).progress.daysInARow(days: dailyStreak.toString()),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE65100),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Pertahankan terus semangat belajarmu!",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
