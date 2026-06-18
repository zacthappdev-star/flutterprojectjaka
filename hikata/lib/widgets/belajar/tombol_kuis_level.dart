import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class TombolKuisLevel extends StatelessWidget {
  final bool isUnlocked;
  final BoxDecoration? unlockedDecoration;
  final VoidCallback? onTap;

  const TombolKuisLevel({
    super.key,
    required this.isUnlocked,
    this.unlockedDecoration,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: GestureDetector(
        onTap: isUnlocked ? onTap : null,
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: isUnlocked
              ? (unlockedDecoration ??
                    AppDecorations.gradientButton.copyWith(
                      borderRadius: BorderRadius.circular(16),
                    ))
              : BoxDecoration(
                  color: colors.progressTrack,
                  borderRadius: BorderRadius.circular(16),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isUnlocked
                    ? Translations.of(context).common.startLevelQuiz
                    : Translations.of(context).hiragana.locked,
                style: AppTextStyles.buttonText.copyWith(
                  fontSize: 15,
                  color: isUnlocked ? Colors.white : colors.textMuted,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                isUnlocked
                    ? Icons.play_arrow_rounded
                    : Icons.lock_outline_rounded,
                color: isUnlocked ? Colors.white : colors.textMuted,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
