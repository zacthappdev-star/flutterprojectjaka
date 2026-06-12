import 'package:flutter/material.dart';
import 'package:ppkd_b6/models/model_karakter.dart';
import 'package:ppkd_b6/services/layanan_audio.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class SheetDetailHuruf extends StatelessWidget {
  final JapaneseCharacter character;
  final bool isID;
  final Color accentColor;
  final Color cardBgColor;
  final Color cardBorderColor;

  const SheetDetailHuruf({
    super.key,
    required this.character,
    required this.isID,
    required this.accentColor,
    required this.cardBgColor,
    required this.cardBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final mnemonic = isID ? character.mnemonicID : character.mnemonicEN;
    final colors = context.hiKata;

    return Padding(
      padding: EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colors.divider,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [accentColor, accentColor.withValues(alpha: 0.75)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    character.character,
                    style: TextStyle(
                      fontSize: 64,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              IconButton(
                icon: Icon(
                  Icons.volume_up_rounded,
                  color: accentColor,
                  size: 36,
                ),
                onPressed: () => AudioService.playAudioWithFeedback(
                  context,
                  character.effectiveAudioPath,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            character.romaji.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: accentColor,
              letterSpacing: 4,
            ),
          ),
          SizedBox(height: 4),
          Text(
            isID ? 'Cara baca' : 'Reading',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: colors.textMuted,
            ),
          ),
          if (mnemonic != null) ...[
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cardBorderColor, width: 1.5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('💡', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 8),
                      Text(
                        isID ? 'Tips Hafalan' : 'Memory Tip',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: accentColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    mnemonic,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: accentColor,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
