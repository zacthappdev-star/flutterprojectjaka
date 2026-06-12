import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class KartuStreakProgres extends StatelessWidget {
  final bool isID;
  final int dailyStreak;

  const KartuStreakProgres({
    super.key,
    required this.isID,
    required this.dailyStreak,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: AppDecorations.cardDecorationOf(context),
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
                  isID ? 'Streak Belajar' : 'Study Streak',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: colors.textMuted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  isID
                      ? '$dailyStreak Hari Berturut-turut!'
                      : '$dailyStreak Days in a Row!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE65100),
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
