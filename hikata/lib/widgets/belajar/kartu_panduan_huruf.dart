import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class KartuPanduanHuruf extends StatelessWidget {
  final VoidCallback onTap;

  const KartuPanduanHuruf({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(18),
        decoration: AppDecorations.cardDecorationOf(context),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                '字',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E9E5B),
                ),
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translations.of(context).common.japaneseScriptGuide,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    Translations.of(context).common.scriptGuideDesc,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: colors.textOnCardSubtitle,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colors.textMuted,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
