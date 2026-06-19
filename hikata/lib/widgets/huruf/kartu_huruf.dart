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
    final cardBg = widget.isLearned
        ? const Color(0xFFf0f9f1)
        : (isDark
              ? Color.lerp(widget.backgroundColor, Colors.black, 0.06)!
              : widget.backgroundColor);

    final borderColor = widget.isLearned
        ? const Color(0xFF1f7a35)
        : widget.borderColor;

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

    return Opacity(
      opacity: widget.isLearned ? 1.0 : 0.45,
      child: ScaleTransition(
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
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 1.5),
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
                if (widget.isLearned)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFF1f7a35),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                const Positioned(
                  bottom: 6,
                  right: 8,
                  child: Text(
                    '+2 XP',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1f7a35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
