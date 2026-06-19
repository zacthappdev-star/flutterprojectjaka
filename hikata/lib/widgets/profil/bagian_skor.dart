import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/profil/judul_bagian_profil.dart';
import 'package:provider/provider.dart';

class BagianSkor extends StatelessWidget {
  const BagianSkor({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final colors = context.hiKata;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JudulBagianProfil(title: context.t.profile.achievements),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGreen.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildCompactScoreRow(
                title: context.t.profile.hiraganaQuiz,
                score: profileProvider.hiraganaHigh,
                iconColor: AppColors.primaryGreen,
                colors: colors,
              ),
              Divider(height: 8, thickness: 0.5),
              _buildCompactScoreRow(
                title: context.t.profile.katakanaQuiz,
                score: profileProvider.katakanaHigh,
                iconColor: isDark
                    ? const Color(0xFFC5CAE9)
                    : const Color.fromARGB(223, 158, 175, 0),
                colors: colors,
                isKatakana: true,
              ),
              Divider(height: 8, thickness: 0.5),
              _buildCompactScoreRow(
                title: context.t.profile.mixedQuiz,
                score: profileProvider.mixedHigh,
                iconColor: const Color(0xFFE65100),
                colors: colors,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactScoreRow({
    required String title,
    required int score,
    required Color iconColor,
    required HiKataColors colors,
    bool isKatakana = false,
  }) {
    final scoreColor = score >= 8 ? AppColors.primaryGreen : Colors.orange;
    final progressVal = score / 10.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressVal,
                minHeight: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
              ),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 40,
            child: Text(
              '$score/10',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: scoreColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
