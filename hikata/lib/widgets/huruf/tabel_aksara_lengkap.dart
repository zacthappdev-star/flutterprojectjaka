import 'package:flutter/material.dart';
import 'package:ppkd_b6/models/model_karakter.dart';
import 'package:ppkd_b6/services/layanan_audio.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

const List<String> _masteredRomajis = [
  'a',
  'i',
  'u',
  'e',
  'o',
  'ka',
  'ki',
  'ku',
  'ke',
  'ko',
  'sa',
  'shi',
  'su',
  'se',
  'so',
];

class TabelAksaraLengkap extends StatelessWidget {
  final List<CharacterGroup> groups;
  final bool isHiragana;

  const TabelAksaraLengkap({
    super.key,
    required this.groups,
    required this.isHiragana,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isHiragana
        ? (isDark ? Color(0xFF81C784) : AppColors.primaryGreen)
        : (isDark ? Color(0xFF9FA8DA) : AppColors.katakanaBlue);
    final cardBgColor = isHiragana
        ? colors.tableCardBgHiragana
        : colors.tableCardBgKatakana;

    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(12, 10, 12, 16),
      children: groups
          .map(
            (g) => _BagianTabel(
              group: g,
              accentColor: accentColor,
              cardBgColor: cardBgColor,
            ),
          )
          .toList(),
    );
  }
}

class _BagianTabel extends StatelessWidget {
  final CharacterGroup group;
  final Color accentColor;
  final Color cardBgColor;

  const _BagianTabel({
    required this.group,
    required this.accentColor,
    required this.cardBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              group.groupName,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: accentColor,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 0.88,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            itemCount: group.characters.length,
            itemBuilder: (ctx, i) {
              final c = group.characters[i];
              final isMastered = _masteredRomajis.contains(
                c.romaji.toLowerCase(),
              );

              final isDark = Theme.of(context).brightness == Brightness.dark;
              final colors = context.hiKata;

              final cellBgColor = isMastered
                  ? (isDark
                        ? Color(0xFF1B5E20).withValues(alpha: 0.3)
                        : Color(0xFFF0FAF5))
                  : (isDark ? colors.cardBackground : Colors.white);
              final cellBorderColor = isMastered
                  ? (isDark ? Color(0xFF81C784) : Color(0xFF2E9E5B))
                  : (isDark ? colors.divider : Colors.grey.shade300);

              final textPrimaryColor = isMastered
                  ? (isDark ? Color(0xFF81C784) : Color(0xFF2E9E5B))
                  : colors.textPrimary;
              final textRomajiColor = isMastered
                  ? (isDark
                        ? Color(0xFF81C784).withValues(alpha: 0.8)
                        : Color(0xFF2E9E5B).withValues(alpha: 0.8))
                  : colors.textMuted;

              return GestureDetector(
                onTap: () => AudioService.playAudioWithFeedback(
                  context,
                  c.effectiveAudioPath,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: cellBgColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cellBorderColor, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.2 : 0.02,
                        ),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 6,
                        right: 6,
                        child: isMastered
                            ? Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Color(0xFF81C784)
                                      : Color(0xFF2E9E5B),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 10,
                                  color: isDark ? Colors.black87 : Colors.white,
                                ),
                              )
                            : Icon(
                                Icons.volume_up_rounded,
                                size: 14,
                                color: isDark
                                    ? Colors.white30
                                    : Colors.grey.shade400,
                              ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              c.character,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textPrimaryColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              c.romaji,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: textRomajiColor,
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
            },
          ),
        ],
      ),
    );
  }
}
