import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppkd_b6/data/data_kuis.dart';
import 'package:ppkd_b6/screen/kuis/layar_hasil_kuis.dart';
import 'package:ppkd_b6/screen/pengenalan/pilih_bahasa.dart';
import 'package:ppkd_b6/services/layanan_audio.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class QuizScreen extends StatefulWidget {
  final String mode; // 'hiragana', 'katakana', 'mixed'
  final int? levelIndex;
  final bool isListening;
  const QuizScreen({
    super.key,
    this.mode = 'mixed',
    this.levelIndex,
    this.isListening = false,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  late List<QuizQuestion> _questions;
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _answered = false;

  late AnimationController _cardAnim;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;

  late AnimationController _pulseAnim;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    if (widget.levelIndex != null) {
      _questions = QuizData.generateLevelQuiz(
        type: widget.mode,
        levelIndex: widget.levelIndex!,
      );
    } else {
      switch (widget.mode) {
        case 'hiragana':
          _questions = QuizData.generateHiraganaQuiz(count: 10);
          break;
        case 'katakana':
          _questions = QuizData.generateKatakanaQuiz(count: 10);
          break;
        default:
          _questions = QuizData.generateMixedQuiz(count: 10);
      }
    }

    _cardAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _cardFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _cardAnim, curve: Curves.easeOut));
    _cardSlide = Tween<Offset>(
      begin: Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _cardAnim, curve: Curves.easeOut));

    _pulseAnim = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);
    _pulse = _pulseAnim.drive(Tween<double>(begin: 0.95, end: 1.05));

    _cardAnim.forward();
    if (widget.isListening) {
      Future.delayed(Duration(milliseconds: 200), () {
        if (mounted) {
          AudioService.playAudio(
            AudioService.getAudioPathForChar(
              _questions[_currentIndex].questionChar,
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _cardAnim.dispose();
    _pulseAnim.dispose();
    super.dispose();
  }

  bool get _isID => AppLanguage.current == 'id';
  QuizQuestion get _current => _questions[_currentIndex];

  void _selectOption(int index) {
    if (_answered) return;
    final isCorrect = index == _current.correctIndex;

    if (isCorrect) {
      HapticFeedback.lightImpact();
      SystemSound.play(SystemSoundType.click);
    } else {
      HapticFeedback.mediumImpact();
    }

    setState(() {
      _selectedOption = index;
      _answered = true;
      if (isCorrect) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex + 1 >= _questions.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            score: _score,
            total: _questions.length,
            mode: widget.mode,
            levelIndex: widget.levelIndex,
            isListening: widget.isListening,
          ),
        ),
      );
      return;
    }

    _cardAnim.reset();
    setState(() {
      _currentIndex++;
      _selectedOption = null;
      _answered = false;
    });
    _cardAnim.forward();
    if (widget.isListening) {
      AudioService.playAudio(
        AudioService.getAudioPathForChar(
          _questions[_currentIndex].questionChar,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentIndex + 1) / _questions.length;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final isKatakana = widget.mode.toLowerCase() == 'katakana';
    final gradientColors = isKatakana
        ? (isDark
              ? [
                  const Color(0xFF211D0A),
                  const Color(0xFF332A0F),
                  const Color(0xFF453915),
                ]
              : [
                  const Color(0xFFFFB300),
                  const Color(0xFFFFC107),
                  const Color(0xFFFFD54F),
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
          child: Column(
            children: [
              _buildHeader(context, progress),
              Expanded(
                child: SlideTransition(
                  position: _cardSlide,
                  child: FadeTransition(
                    opacity: _cardFade,
                    child: _buildQuizBody(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double progress) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => _showQuitDialog(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        minHeight: 8,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _isID
                          ? '${_currentIndex + 1} dari ${_questions.length} soal'
                          : '${_currentIndex + 1} of ${_questions.length} questions',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text('⭐', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 4),
                    Text(
                      '$_score',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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

  Widget _buildQuizBody() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          children: [
            SizedBox(height: 12),

            // Question prompt
            Text(
              widget.isListening
                  ? (_isID
                        ? 'Dengarkan pelafalan huruf berikut:'
                        : 'Listen to the following pronunciation:')
                  : _current.question,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Character display with Voice button and tap support
            ScaleTransition(
              scale: _answered ? _pulse : AlwaysStoppedAnimation(1.0),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.isListening) {
                        AudioService.playAudioWithFeedback(
                          context,
                          AudioService.getAudioPathForChar(
                            _current.questionChar,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: _answered
                              ? (_selectedOption == _current.correctIndex
                                    ? Colors.greenAccent
                                    : Colors.redAccent)
                              : Colors.white30,
                          width: _answered ? 3 : 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Center(
                        child: widget.isListening
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.volume_up_rounded,
                                    color: Colors.white,
                                    size: 64,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    _isID
                                        ? 'Dengarkan Audio'
                                        : 'Listen to Audio',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                _current.questionChar,
                                style: TextStyle(
                                  fontSize: 90,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  if (widget.isListening)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          Icons.volume_up_rounded,
                          color: Colors.white70,
                          size: 24,
                        ),
                        onPressed: () {
                          AudioService.playAudioWithFeedback(
                            context,
                            AudioService.getAudioPathForChar(
                              _current.questionChar,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 28),

            // Answer options
            ...List.generate(4, (i) {
              final isSelected = _selectedOption == i;
              final isCorrect = i == _current.correctIndex;
              final isWrong = _answered && isSelected && !isCorrect;
              final showCorrect = _answered && isCorrect;

              Color textColor = AppColors.textPrimary;
              Widget? trailingIcon;

              if (showCorrect) {
                textColor = const Color(0xFF1B5E20);
                trailingIcon = const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 22,
                );
              } else if (isWrong) {
                textColor = const Color(0xFFB71C1C);
                trailingIcon = const Icon(
                  Icons.cancel_rounded,
                  color: Colors.red,
                  size: 22,
                );
              }

              return QuizOptionCard(
                label: const ['A', 'B', 'C', 'D'][i],
                text: _current.options[i],
                answered: _answered,
                isSelected: isSelected,
                isCorrect: isCorrect,
                isWrong: isWrong,
                showCorrect: showCorrect,
                onTap: () => _selectOption(i),
                textColor: textColor,
                trailingIcon: trailingIcon,
              );
            }),

            if (_answered) ...[
              const SizedBox(height: 8),
              // Feedback message
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _selectedOption == _current.correctIndex
                      ? Color(0xFFE8F5E9)
                      : Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      _selectedOption == _current.correctIndex ? '🎉' : '😅',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _selectedOption == _current.correctIndex
                            ? (_isID
                                  ? 'Benar! Jawaban: ${_current.options[_current.correctIndex]}'
                                  : 'Correct! Answer: ${_current.options[_current.correctIndex]}')
                            : (_isID
                                  ? 'Salah! Jawaban yang benar: ${_current.options[_current.correctIndex]}'
                                  : 'Wrong! Correct answer: ${_current.options[_current.correctIndex]}'),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _selectedOption == _current.correctIndex
                              ? Color(0xFF1B5E20)
                              : Color(0xFFB71C1C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Next button
              GestureDetector(
                onTap: _nextQuestion,
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.mode.toLowerCase() == 'katakana'
                          ? (isDark
                                ? [const Color(0xFFFFB300), const Color(0xFFFFC107)]
                                : [const Color(0xFFFFB300), const Color(0xFFFFC107)])
                          : [AppColors.primaryGreen, AppColors.secondaryGreen],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (widget.mode.toLowerCase() == 'katakana'
                                    ? const Color(0xFFFFB300)
                                    : AppColors.primaryGreen)
                                .withValues(alpha: 0.4),
                        blurRadius: 15,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _currentIndex + 1 >= _questions.length
                          ? (_isID ? 'LIHAT HASIL' : 'SEE RESULT')
                          : (_isID ? 'SOAL BERIKUTNYA' : 'NEXT QUESTION'),
                      style: AppTextStyles.buttonText.copyWith(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showQuitDialog(BuildContext context) {
    final isKatakana = widget.mode.toLowerCase() == 'katakana';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          _isID ? 'Keluar Kuis?' : 'Quit Quiz?',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        content: Text(
          _isID
              ? 'Progresmu akan hilang jika keluar sekarang.'
              : 'Your progress will be lost if you quit now.',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              _isID ? 'Lanjut' : 'Continue',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: isKatakana ? const Color(0xFFFFB300) : AppColors.primaryGreen,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              _isID ? 'Keluar' : 'Quit',
              style: const TextStyle(fontFamily: 'Poppins', color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizOptionCard extends StatefulWidget {
  final String label;
  final String text;
  final bool answered;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final bool showCorrect;
  final VoidCallback onTap;
  final Color textColor;
  final Widget? trailingIcon;

  const QuizOptionCard({
    super.key,
    required this.label,
    required this.text,
    required this.answered,
    required this.isSelected,
    required this.isCorrect,
    required this.isWrong,
    required this.showCorrect,
    required this.onTap,
    required this.textColor,
    this.trailingIcon,
  });

  @override
  State<QuizOptionCard> createState() => _QuizOptionCardState();
}

class _QuizOptionCardState extends State<QuizOptionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QuizOptionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.answered && !oldWidget.answered) {
      if (widget.isSelected) {
        _controller.forward(from: 0.0);
      }
    } else if (!widget.answered && oldWidget.answered) {
      _controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white;
    Color borderColor = Colors.transparent;

    if (!widget.answered) {
      bgColor = Colors.white;
    } else if (widget.showCorrect) {
      bgColor = const Color(0xFFE8F5E9);
      borderColor = Colors.green;
    } else if (widget.isWrong) {
      bgColor = const Color(0xFFFFEBEE);
      borderColor = Colors.red;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double dx = 0.0;
        double scale = 1.0;

        if (widget.answered && widget.isSelected) {
          if (widget.isCorrect) {
            final val = _controller.value;
            scale = 1.0 + 0.08 * (1.0 - (val - 0.5).abs() * 2);
          } else if (widget.isWrong) {
            dx = 12.0 * math.sin(_controller.value * 6 * math.pi);
          }
        }

        return Transform.translate(
          offset: Offset(dx, 0.0),
          child: Transform.scale(scale: scale, child: child),
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: widget.answered ? 2 : 0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.answered && widget.isCorrect
                      ? Colors.green.withValues(alpha: 0.15)
                      : widget.answered && widget.isWrong
                      ? Colors.red.withValues(alpha: 0.15)
                      : AppColors.lightBackground,
                ),
                child: Center(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: widget.answered && widget.isCorrect
                          ? Colors.green
                          : widget.answered && widget.isWrong
                          ? Colors.red
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: widget.textColor,
                  ),
                ),
              ),
              if (widget.trailingIcon != null) widget.trailingIcon!,
            ],
          ),
        ),
      ),
    );
  }
}
