import 'package:flutter/material.dart';
import 'package:ppkd_b6/models/model_karakter.dart';
import 'package:ppkd_b6/services/layanan_audio.dart';

class KartuHuruf extends StatefulWidget {
  final JapaneseCharacter character;
  final Color accentColor;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;
  final bool isLearned;

  const KartuHuruf({
    super.key,
    required this.character,
    required this.accentColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.onTap,
    this.isLearned = false,
  });

  @override
  State<KartuHuruf> createState() => _KartuHurufState();
}

class _KartuHurufState extends State<KartuHuruf>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _scale = Tween<double>(
      begin: 1,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark
        ? Color.lerp(widget.backgroundColor, Colors.black, 0.06)!
        : widget.backgroundColor;

    final charColor = isDark
        ? widget.accentColor.withValues(alpha: 0.95)
        : widget.accentColor;

    final romajiColor = isDark
        ? widget.accentColor.withValues(alpha: 0.9)
        : widget.accentColor.withValues(alpha: 0.75);

    final audioBg = isDark
        ? widget.accentColor.withValues(alpha: 0.12)
        : widget.accentColor.withValues(alpha: 0.08);

    final audioIconColor = isDark
        ? widget.accentColor.withValues(alpha: 0.95)
        : widget.accentColor.withValues(alpha: 0.7);

    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          widget.onTap();
        },
        onTapCancel: () => _ctrl.reverse(),
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: widget.borderColor, width: 1.5),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () {
                    AudioService.playAudioWithFeedback(
                      context,
                      widget.character.effectiveAudioPath,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: audioBg,
                    ),
                    child: Icon(
                      Icons.volume_up_rounded,
                      size: 14,
                      color: audioIconColor,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.character.character,
                      style: TextStyle(
                        fontSize: 30,
                        color: charColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.character.romaji,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: romajiColor,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 6,
                left: 8,
                child: Text(
                  widget.isLearned ? '✓' : '✗',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: widget.isLearned
                        ? Color(0xFF4CAF50)
                        : Colors.red.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
