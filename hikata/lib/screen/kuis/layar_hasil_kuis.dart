import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppkd_b6/screen/kuis/layar_kuis.dart';
import 'package:ppkd_b6/screen/pengenalan/pilih_bahasa.dart';
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
                '🎉 Selamat!',
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
                    'Level berikutnya berhasil dibuka.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Teruskan belajar untuk membuka level lainnya dan meningkatkan kemampuan membaca huruf Jepang.',
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
                        'Lanjut Belajar',
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

  bool get _isID => AppLanguage.current == 'id';

  double get _percentage => (widget.score / widget.total) * 100;

  int get _stars {
    if (_percentage >= 90) return 3;
    if (_percentage >= 60) return 2;
    if (_percentage >= 30) return 1;
    return 0;
  }

  String _getFeedbackTitle() {
    if (_percentage >= 90) {
      return _isID ? '🌟 Luar Biasa!' : '🌟 Outstanding!';
    } else if (_percentage >= 80) {
      return _isID ? '🎉 Hebat!' : '🎉 Great!';
    } else if (_percentage >= 60) {
      return _isID ? '👍 Lumayan!' : '👍 Not Bad!';
    } else {
      return _isID ? '📖 Ayo Belajar Lagi!' : '📖 Let\'s Study Again!';
    }
  }

  String _getFeedbackDesc() {
    if (_percentage >= 90) {
      return _isID
          ? 'Kamu menguasai materi ini dengan sempurna! Pertahankan prestasimu.'
          : 'You mastered this material perfectly! Keep up the great work.';
    } else if (_percentage >= 70) {
      return _isID
          ? 'Pemahamanmu sudah sangat baik. Sedikit latihan lagi untuk nilai sempurna!'
          : 'Your understanding is very good. Just a little more practice for a perfect score!';
    } else if (_percentage >= 40) {
      return _isID
          ? 'Kamu sudah mulai paham. Mari belajar lagi agar lebih lancar.'
          : 'You are starting to understand. Let\'s study more to improve fluency.';
    } else {
      return _isID
          ? 'Jangan menyerah! Coba ulangi pengenalan huruf dan kuis untuk hasil lebih baik.'
          : 'Don\'t give up! Try reviewing the characters and quiz again for a better score.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isKatakana = widget.mode.toLowerCase() == 'katakana';

    final primaryColor = isKatakana
        ? (isDark ? Color(0xFFFFD54F) : Color(0xFFFFB300))
        : (isDark ? Color(0xFF81C784) : AppColors.primaryGreen);
    final secondaryColor = isKatakana
        ? (isDark ? Color(0xFFFFE082) : Color(0xFFFFC107))
        : (isDark ? Color(0xFFA5D6A7) : AppColors.secondaryGreen);

    final gradientColors = isKatakana
        ? (isDark
              ? [
                  const Color(0xFF080D21),
                  const Color(0xFF10173D),
                  const Color(0xFF1B235A),
                ]
              : [
                  const Color(0xFF1A237E),
                  const Color(0xFF283593),
                  const Color(0xFF3949AB),
                ])
        : (isDark
              ? [
                  const Color(0xFF0D1510),
                  const Color(0xFF162820),
                  const Color(0xFF1F3528),
                ]
              : [
                  const Color(0xFF1B5E20),
                  const Color(0xFF2E7D32),
                  const Color(0xFF43A047),
                ]);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                Spacer(flex: 2),

                // Stars rating widget
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final isFilled = index < _stars;
                    return Icon(
                      isFilled ? Icons.star_rounded : Icons.star_border_rounded,
                      color: isFilled ? Colors.amberAccent : Colors.white30,
                      size: 56,
                    );
                  }),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  decoration: AppDecorations.cardDecoration,
                  child: Column(
                    children: [
                      Text(
                        _getFeedbackTitle(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        _getFeedbackDesc(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: 0.0,
                          end: _percentage / 100,
                        ),
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: value,
                                  backgroundColor: Colors.grey.shade100,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    primaryColor,
                                  ),
                                  minHeight: 10,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '${(value * 100).toInt()}% ${_isID ? "Akurasi" : "Accuracy"}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 18),
                      Divider(color: Colors.grey.shade200, thickness: 1.2),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem(
                            label: _isID ? 'Benar' : 'Correct',
                            value: '${widget.score}',
                            primaryColor: Colors.green,
                            icon: Icons.check_circle_outline_rounded,
                          ),
                          _buildStatItem(
                            label: _isID ? 'Salah' : 'Wrong',
                            value: '${widget.total - widget.score}',
                            primaryColor: Colors.red,
                            icon: Icons.highlight_off_rounded,
                          ),
                          _buildStatItem(
                            label: _isID ? 'Total Soal' : 'Total',
                            value: '${widget.total}',
                            primaryColor: primaryColor,
                            icon: Icons.quiz_outlined,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 3),
                GestureDetector(
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
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.4),
                          blurRadius: 15,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _isID ? 'COBA LAGI' : 'TRY AGAIN',
                        style: AppTextStyles.buttonText.copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                if (!widget.isListening && widget.levelIndex != null) ...[
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuizScreen(
                            mode: widget.mode,
                            levelIndex: widget.levelIndex,
                            isListening: true,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.amber.shade700,
                            Colors.orange.shade800,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withValues(alpha: 0.4),
                            blurRadius: 15,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _isID
                              ? 'MULAI KUIS PENDENGARAN'
                              : 'START LISTENING QUIZ',
                          style: AppTextStyles.buttonText.copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _isID ? 'KEMBALI KE BERANDA' : 'BACK TO HOME',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required Color primaryColor,
    IconData? icon,
  }) {
    return Column(
      children: [
        if (icon != null) ...[
          Icon(icon, color: primaryColor, size: 22),
          SizedBox(height: 4),
        ],
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
