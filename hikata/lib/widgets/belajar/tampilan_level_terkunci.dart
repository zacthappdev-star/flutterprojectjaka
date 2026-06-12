import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class TampilanLevelTerkunci extends StatelessWidget {
  final bool isID;
  final Color? titleColor;

  const TampilanLevelTerkunci({super.key, required this.isID, this.titleColor});

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.fieldFill,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.lock_rounded, color: colors.textMuted, size: 64),
          ),
          SizedBox(height: 20),
          Text(
            isID ? 'Level Terkunci' : 'Level Locked',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: titleColor ?? colors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              isID
                  ? 'Selesaikan kuis level sebelumnya dengan akurasi minimal 80% untuk membuka level ini.'
                  : 'Complete the previous level quiz with at least 80% accuracy to unlock this level.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: colors.textOnCardSubtitle,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
