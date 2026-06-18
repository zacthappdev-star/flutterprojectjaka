import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class KartuProgresPersen extends StatelessWidget {
  final String title;
  final double progress;
  final Color accentColor;
  final Color badgeBg;
  final String icon;

  const KartuProgresPersen({
    super.key,
    required this.title,
    required this.progress,
    required this.accentColor,
    required this.badgeBg,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: AppDecorations.cardDecorationOf(context),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: badgeBg, shape: BoxShape.circle),
            child: Center(
              child: Text(
                icon,
                style: TextStyle(
                  fontSize: 22,
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
              fontWeight: FontWeight.w800,
              color: accentColor,
            ),
          ),
          SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: colors.progressTrack,
                  valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${(progress * 46).round()}/46 karakter',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
