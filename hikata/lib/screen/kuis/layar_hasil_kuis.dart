import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';
import 'package:ppkd_b6/screen/kuis/layar_kuis.dart';
import 'package:ppkd_b6/screen/tata_utama.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:provider/provider.dart';

class QuizResultScreen extends StatefulWidget {
  final int score;
  final int total;
  final String mode;
  final int? levelIndex;
  final bool isListening;
  final int durationSeconds;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.mode,
    this.levelIndex,
    this.isListening = false,
    this.durationSeconds = 0,
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
    // High scores are derived from the quiz_history table (see getQuizStats),
    // so there's no separate SharedPreferences copy to maintain here.
    final unlockedNew = await ProgressService.handleQuizSubmission(
      mode: widget.mode,
      levelIndex: widget.levelIndex,
      score: widget.score,
      total: widget.total,
    );

    if (mounted) {
      // Refresh XP and Level globally
      try {
        final profileProv = context.read<ProfileProvider>();
        await profileProv.refresh();
      } catch (_) {}

      if (!mounted) return;

      if (unlockedNew) {
        _showLevelUnlockedDialog(context);
      }
    }
  }

  void _showLevelUnlockedDialog(BuildContext context) {
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.heavyImpact();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogPrimaryColor =
        isDark ? Color(0xFF81C784) : AppColors.primaryGreen;
    final dialogSecondaryColor =
        isDark ? Color(0xFFA5D6A7) : AppColors.secondaryGreen;

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
                  ? const Color(0xFF1E2D24)
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
                        colors: [dialogPrimaryColor, dialogSecondaryColor],
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
      return context.t.quiz.resultFeedbackExcellent;
    } else if (_percentage >= 50) {
      return context.t.quiz.resultFeedbackGood;
    } else {
      return context.t.quiz.resultFeedbackRetry;
    }
  }

  String _getFeedbackEmoji() {
    if (_percentage >= 80) return "🏆";
    if (_percentage >= 50) return "👍";
    return "😅";
  }

  String _formatDuration() {
    final m = widget.durationSeconds ~/ 60;
    final s = widget.durationSeconds % 60;
    return '${m}m ${s.toString().padLeft(2, '0')}s';
  }

  int get _earnedXp => 20 + (_percentage >= 80 ? 10 : 0);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.hiKata;

    return Scaffold(
      backgroundColor: colors.cardBackground,
      body: Column(
        children: [
          _buildHeroHasil(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildStatistikCard(context, isDark, colors),
                  const SizedBox(height: 32),
                  _buildTombolAksi(context),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Center(
                      child: Text(
                        context.t.quiz.resultBackToHome,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? colors.textMuted
                              : Colors.grey.shade600,
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
    final profile = context.read<ProfileProvider>();
    final streak = profile.currentStreak;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 32,
        bottom: 40,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2E9E5B), Color(0xFF1B5E20)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2E9E5B),
            blurRadius: 20,
            spreadRadius: -5,
            offset: Offset(0, 10),
          )
        ]
      ),
      child: Column(
        children: [
          Text(_getFeedbackEmoji(), style: const TextStyle(fontSize: 80)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      context.t.quiz.resultXpEarned(xp: _earnedXp),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 6),
                    Text(
                      '$streak Streak',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildStatistikCard(
    BuildContext context,
    bool isDark,
    HiKataColors colors,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? colors.cardBackground : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isDark ? Border.all(color: colors.divider) : null,
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        children: [
          _buildStatRow(
            context.t.quiz.resultCorrect,
            '${widget.score}',
            isDark ? const Color(0xFF81C784) : const Color(0xFF2E9E5B),
            isDark,
            colors,
          ),
          Divider(color: colors.divider, height: 24, thickness: 1),
          _buildStatRow(
            context.t.quiz.resultWrong,
            '${widget.total - widget.score}',
            isDark ? const Color(0xFFEF5350) : Colors.red,
            isDark,
            colors,
          ),
          Divider(color: colors.divider, height: 24, thickness: 1),
          _buildStatRow(
            context.t.quiz.resultTime,
            _formatDuration(),
            isDark ? colors.textPrimary : const Color(0xFF1A1A1A),
            isDark,
            colors,
            isBoldValue: false,
          ),
          Divider(color: colors.divider, height: 24, thickness: 1),
          _buildStatRow(
            context.t.quiz.resultAccuracy,
            '${_percentage.toInt()}%',
            isDark ? colors.textPrimary : const Color(0xFF1A1A1A),
            isDark,
            colors,
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    String value,
    Color valueColor,
    bool isDark,
    HiKataColors colors, {
    bool isBoldValue = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? colors.textPrimary : const Color(0xFF1A1A1A),
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
              child: Center(
                child: Text(
                  context.t.quiz.resultTryAgain,
                  style: const TextStyle(
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
              Navigator.of(context).popUntil((route) => route.isFirst);
              // Both level quizzes and the independent "Latihan Cepat" quiz are
              // launched from DasborBelajar (tab 0). There is no separate quiz
              // tab anymore, so always return there.
              TataUtama.of(context)?.setTab(0);
            },
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF2E9E5B),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  widget.levelIndex != null 
                      ? context.t.quiz.continueLearning 
                      : context.t.quiz.resultOtherQuiz,
                  style: const TextStyle(
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
