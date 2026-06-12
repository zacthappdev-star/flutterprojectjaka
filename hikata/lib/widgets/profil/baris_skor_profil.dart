import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class BarisSkorProfil extends StatelessWidget {
  final String title;
  final int score;
  final Color iconColor;
  final bool isID;

  const BarisSkorProfil({
    super.key,
    required this.title,
    required this.score,
    required this.iconColor,
    required this.isID,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.stars_rounded, color: iconColor, size: 20),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: iconColor,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              isID ? 'Skor Tertinggi' : 'High Score',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: colors.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2),
            Text(
              '$score/10',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
