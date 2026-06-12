import 'package:flutter/material.dart';
import 'package:ppkd_b6/models/model_karakter.dart';
import 'package:ppkd_b6/services/layanan_audio.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class TabelAksaraLengkap extends StatelessWidget {
  final List<CharacterGroup> groups;
  final bool isHiragana;
  final bool isID;

  const TabelAksaraLengkap({
    super.key,
    required this.groups,
    required this.isHiragana,
    required this.isID,
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
              return GestureDetector(
                onTap: () => AudioService.playAudioWithFeedback(
                  context,
                  c.effectiveAudioPath,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.18),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withValues(alpha: 0.06),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Icon(
                          Icons.volume_up_rounded,
                          size: 10,
                          color: accentColor.withValues(alpha: 0.6),
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
                                color: accentColor,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              c.romaji,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: accentColor.withValues(alpha: 0.7),
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
