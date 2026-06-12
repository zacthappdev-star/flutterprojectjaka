import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class KartuPanduanHuruf extends StatelessWidget {
  final bool isID;
  final VoidCallback onTap;

  const KartuPanduanHuruf({super.key, required this.isID, required this.onTap});

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
                color: Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.lightbulb_outline_rounded,
                color: Color(0xFFE65100),
                size: 24,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isID ? ' Huruf Jepang' : 'Japanese Script Guide',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    isID
                        ? 'Hiragana, Katakana, Dakuten, Youon & lainnya'
                        : 'Hiragana, Katakana, Dakuten, Yōon & more',
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
