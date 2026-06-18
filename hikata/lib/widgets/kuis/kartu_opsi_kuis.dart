import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class KartuOpsiKuis extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badge;
  final Color accentColor;
  final Color badgeBg;
  final VoidCallback onTap;
  final String questionCount;
  final String estimatedTime;
  final String difficulty;
  final bool isAudio;
  final bool isLocked;

  const KartuOpsiKuis({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.accentColor,
    required this.badgeBg,
    required this.onTap,
    this.questionCount = '10 soal',
    this.estimatedTime = '±5 menit',
    this.difficulty = 'Sedang',
    this.isAudio = false,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Opacity(
        opacity: isLocked ? 0.5 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: AppDecorations.cardDecorationOf(context),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.15),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    badge,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isLocked ? "Selesaikan quiz sebelumnya dulu" : subtitle,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: colors.textOnCardSubtitle,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (isLocked)
                          _buildBadge(
                            text: "🔒 Terkunci",
                            bgColor: Colors.grey.shade200,
                            textColor: Colors.grey.shade700,
                          ),
                        if (!isLocked) ...[
                          _buildBadge(
                            text: questionCount,
                            bgColor: Colors.grey.shade100,
                            textColor: Colors.grey.shade700,
                          ),
                          _buildBadge(
                            text: estimatedTime,
                            bgColor: Colors.grey.shade100,
                            textColor: Colors.grey.shade700,
                          ),
                          _buildDifficultyBadge(difficulty),
                          if (isAudio)
                            _buildBadge(
                              text: "Audio",
                              bgColor: Colors.blue.shade50,
                              textColor: Colors.blue.shade700,
                            ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: isLocked ? Colors.grey : accentColor,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge({
    required String text,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildDifficultyBadge(String diff) {
    Color bg;
    Color text;
    if (diff == 'Sedang') {
      bg = Color(0xFFFFF9E6);
      text = Color(0xFF8D6E63);
    } else if (diff == 'Sulit') {
      bg = Color(0xFFFFEBEE);
      text = Color(0xFFD32F2F);
    } else if (diff == 'Boss Level 🔥') {
      bg = Color(0xFFD32F2F);
      text = Colors.white;
    } else {
      bg = Colors.grey.shade100;
      text = Colors.grey.shade700;
    }
    return _buildBadge(text: diff, bgColor: bg, textColor: text);
  }
}
