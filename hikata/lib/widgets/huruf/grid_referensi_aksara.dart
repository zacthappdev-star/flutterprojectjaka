import 'package:flutter/material.dart';
import 'package:ppkd_b6/models/model_karakter.dart';
import 'package:ppkd_b6/services/layanan_pelafalan.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class GridReferensiAksara extends StatelessWidget {
  final List<JapaneseCharacter> characters;
  final bool isHiragana;
  final bool isID;
  final int crossAxisCount;
  final EdgeInsets padding;

  const GridReferensiAksara({
    super.key,
    required this.characters,
    required this.isHiragana,
    required this.isID,
    this.crossAxisCount = 5,
    this.padding = const EdgeInsets.all(14),
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gridColor = isHiragana
        ? (isDark ? Color(0xFF81C784) : AppColors.primaryGreen)
        : (isDark ? Color(0xFF9FA8DA) : const Color(0xFF1A237E));
    final cardBgColor = isHiragana
        ? colors.tableCardBgHiragana
        : colors.tableCardBgKatakana;

    return GridView.builder(
      padding: padding,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.88,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: characters.length,
      itemBuilder: (ctx, i) {
        final c = characters[i];
        return GestureDetector(
          onTap: () => PronunciationService.speak(c.character),
          child: Container(
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: gridColor.withValues(alpha: 0.18),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: gridColor.withValues(alpha: 0.06),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  c.character,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: gridColor,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  c.romaji,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: gridColor.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
