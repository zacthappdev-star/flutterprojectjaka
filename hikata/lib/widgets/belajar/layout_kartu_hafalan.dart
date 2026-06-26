import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/models/model_karakter.dart';
import 'package:ppkd_b6/services/layanan_audio.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:provider/provider.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';

class LayoutKartuHafalan extends StatefulWidget {
  final CharacterGroup group;
  final Color accentColor;
  final Color cardBgColor;
  const LayoutKartuHafalan({
    super.key,
    required this.group,
    required this.accentColor,
    required this.cardBgColor,
  });

  @override
  State<LayoutKartuHafalan> createState() => _LayoutKartuHafalanState();
}

class _LayoutKartuHafalanState extends State<LayoutKartuHafalan> {
  int _cardIndex = 0;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    // Do NOT mark on initState — only mark when user actually flips/navigates past the card
  }

  void _markCurrentAsLearned() {
    final c = widget.group.characters[_cardIndex];
    context.read<ProfileProvider>().markCharacterLearned(c.character);
  }


  @override
  Widget build(BuildContext context) {
    final c = widget.group.characters[_cardIndex];
    final mnemonic = c.mnemonic;
    final colors = context.hiKata;

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _isFlipped = !_isFlipped);
                AudioService.playAudio(c.effectiveAudioPath);
                // Mark as learned only when user flips (views the answer side)
                if (!_isFlipped) _markCurrentAsLearned();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isFlipped
                        ? [colors.cardBackground, widget.cardBgColor]
                        : [
                            widget.accentColor,
                            widget.accentColor.withValues(alpha: 0.75),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _isFlipped
                        ? widget.accentColor.withValues(alpha: 0.2)
                        : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.accentColor.withValues(alpha: 0.15),
                      blurRadius: 15,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.volume_up_rounded,
                          color: _isFlipped
                              ? widget.accentColor
                              : Colors.white70,
                          size: 28,
                        ),
                        onPressed: () => AudioService.playAudioWithFeedback(
                          context,
                          c.effectiveAudioPath,
                        ),
                      ),
                    ),
                    Spacer(),
                    if (!_isFlipped) ...[
                      Text(
                        c.character,
                        style: TextStyle(
                          fontSize: 90,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        Translations.of(context).flashcard.flip,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ] else ...[
                      Text(
                        c.romaji.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                          color: widget.accentColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      if (mnemonic != null) ...[
                        Text(
                          Translations.of(context).common.tip,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: colors.textOnCardSubtitle,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          mnemonic,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: widget.accentColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: widget.accentColor,
                ),
                onPressed: _cardIndex > 0
                    ? () {
                        _markCurrentAsLearned();
                        setState(() {
                          _cardIndex--;
                          _isFlipped = false;
                          AudioService.playAudio(
                            widget
                                .group
                                .characters[_cardIndex]
                                .effectiveAudioPath,
                          );
                        });
                      }
                    : null,
              ),
              Text(
                '${_cardIndex + 1} / ${widget.group.characters.length}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: widget.accentColor,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: widget.accentColor,
                ),
                onPressed: _cardIndex < widget.group.characters.length - 1
                    ? () {
                        _markCurrentAsLearned();
                        setState(() {
                          _cardIndex++;
                          _isFlipped = false;
                          AudioService.playAudio(
                            widget
                                .group
                                .characters[_cardIndex]
                                .effectiveAudioPath,
                          );
                        });
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
