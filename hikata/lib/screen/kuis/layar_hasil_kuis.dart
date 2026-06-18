import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppkd_b6/screen/kuis/layar_kuis.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizResultScreen extends StatefulWidget {
  final int score;
  final int total;
  final String mode;
  final int? levelIndex;
  final bool isListening;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.mode,
    this.levelIndex,
    this.isListening = false,
  });

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  @override
  void initState() {
    super.initState();
    _saveHighScore();
  }

  Future<void> _saveHighScore() async {
    final prefs = await SharedPreferences.getInstance();

    if (widget.levelIndex == null) {
      final key =
          'high_score_${widget.mode}${widget.isListening ? "_listening" : ""}';
      final currentHigh = prefs.getInt(key) ?? 0;
      if (widget.score > currentHigh) {
        await prefs.setInt(key, widget.score);
      }
    } else {
      if (widget.isListening) {
        final unlockedNew = await ProgressService.handleQuizSubmission(
          mode: widget.mode,
          levelIndex: widget.levelIndex!,
          score: widget.score,
          total: widget.total,
        );

        if (unlockedNew && mounted) {
          _showLevelUnlockedDialog(context);
        }
      }
    }
  }

  void _showLevelUnlockedDialog(BuildContext context) {
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.heavyImpact();

    final isKatakana = widget.mode.toLowerCase() == 'katakana';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogPrimaryColor = isKatakana
        ? (isDark ? const Color(0xFFFFD54F) : const Color(0xFFFFB300))
        : (isDark ? const Color(0xFF81C784) : AppColors.primaryGreen);
    final dialogSecondaryColor = isKatakana
        ? (isDark ? const Color(0xFFFFE082) : const Color(0xFFFFC107))
        : (isDark ? const Color(0xFFA5D6A7) : AppColors.secondaryGreen);

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Level Unlocked',
      barrierColor: Colors.black.withValues(alpha: 0.65),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        final scale = 1.0 + (1.0 - anim1.value) * -0.15;
        final opacity = anim1.value;
        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: AlertDialog(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? (isKatakana ? const Color(0xFF211D0A) : const Color(0xFF1E2D24))
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(
                  color: dialogPrimaryColor.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              title: Text(
                context.t.quiz.levelUnlockedTitle,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: dialogPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.t.quiz.levelUnlockedDesc,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    context.t.quiz.levelUnlockedSub,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          dialogPrimaryColor,
                          dialogSecondaryColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: dialogPrimaryColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        context.t.quiz.continueLearning,
                        style: AppTextStyles.buttonText.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  double get _percentage => (widget.score / widget.total) * 100;



  String _getFeedbackDesc(BuildContext context) {
    if (_percentage >= 80) {
      return "Luar Biasa! よくできました！";
    } else if (_percentage >= 50) {
      return "Bagus! いいね！";
    } else {
      return "Coba Lagi! がんばって！";
    }
  }

  String _getFeedbackEmoji() {
    if (_percentage >= 80) return "🏆";
    if (_percentage >= 50) return "👍";
    return "😅";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Column(
        children: [
          _buildHeroHasil(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildStatistikCard(context),
                  const SizedBox(height: 32),
                  _buildTombolAksi(context),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Center(
                      child: Text(
                        "Kembali ke Beranda",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHasil(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 32,
        bottom: 40,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF2E9E5B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Text(
            _getFeedbackEmoji(),
            style: const TextStyle(fontSize: 80),
          ),
          const SizedBox(height: 16),
          Text(
            '${widget.score}/${widget.total}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getFeedbackDesc(context),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "✨ +${widget.score * 10} XP didapat!",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistikCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildStatRow("✅ Jawaban Benar", '${widget.score}', const Color(0xFF2E9E5B)),
          Divider(color: Colors.grey.shade200, height: 24, thickness: 1),
          _buildStatRow("❌ Jawaban Salah", '${widget.total - widget.score}', Colors.red),
          Divider(color: Colors.grey.shade200, height: 24, thickness: 1),
          _buildStatRow("⏱ Waktu Selesai", "1m 15s", const Color(0xFF1A1A1A), isBoldValue: false),
          Divider(color: Colors.grey.shade200, height: 24, thickness: 1),
          _buildStatRow("🎯 Akurasi", '${_percentage.toInt()}%', const Color(0xFF1A1A1A)),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color valueColor, {bool isBoldValue = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: isBoldValue ? FontWeight.w800 : FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTombolAksi(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizScreen(
                    mode: widget.mode,
                    levelIndex: widget.levelIndex,
                    isListening: widget.isListening,
                  ),
                ),
              );
            },
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF2E9E5B), width: 2),
              ),
              child: const Center(
                child: Text(
                  "Coba Lagi",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E9E5B),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF2E9E5B),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  "Quiz Lain",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


}
