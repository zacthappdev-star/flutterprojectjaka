import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppkd_b6/data/data_kuis.dart';
import 'package:ppkd_b6/screen/kuis/layar_hasil_kuis.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: SafeArea(
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
    );
  }

  Widget _buildHeader(BuildContext context, double progress) {
    String quizTitle = 'Quiz ';
    if (widget.mode.toLowerCase() == 'hiragana') {
      quizTitle += 'Hiragana';
    } else if (widget.mode.toLowerCase() == 'katakana') {
      quizTitle += 'Katakana';
    } else {
      quizTitle += 'Campuran';
    }

    return Container(
      color: const Color(0xFF2E9E5B),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _showQuitDialog(context),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 24),
              ),
              Text(
                quizTitle,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                '${_currentIndex + 1}/${_questions.length}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: 0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          children: [
            SizedBox(height: 12),

            // Question prompt
            if (widget.isListening)
              Text(
                context.t.quiz.listenPrompt,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Color(0xFF1A1A1A),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),

            // Character display card
            ScaleTransition(
              scale: _answered ? _pulse : const AlwaysStoppedAnimation(1.0),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: widget.isListening
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.volume_up_rounded,
                                  color: Color(0xFF2E9E5B),
                                  size: 80,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  context.t.quiz.listenAudio,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Color(0xFF2E9E5B),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              _current.questionChar,
                              style: const TextStyle(
                                fontSize: 90,
                                color: Color(0xFF2E9E5B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: IconButton(
                      icon: const Icon(
                        Icons.volume_up_rounded,
                        color: Color(0xFF2E9E5B),
                        size: 28,
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
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      _selectedOption == _current.correctIndex ? '🎉' : '😅',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _selectedOption == _current.correctIndex
                            ? context.t.quiz.feedbackCorrect(answer: _current.options[_current.correctIndex])
                            : context.t.quiz.feedbackWrong(answer: _current.options[_current.correctIndex]),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _selectedOption == _current.correctIndex
                              ? const Color(0xFF1B5E20)
                              : const Color(0xFFB71C1C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),
            // Next/Jawab button always visible
            GestureDetector(
              onTap: _answered ? _nextQuestion : null,
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: _answered ? const Color(0xFF2E9E5B) : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    _answered
                        ? (_currentIndex + 1 >= _questions.length
                            ? context.t.quiz.seeResult
                            : context.t.quiz.nextQuestion)
                        : 'Jawab',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
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
          context.t.quiz.quitQuiz,
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        content: Text(
          context.t.quiz.quitWarning,
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.t.quiz.continueQuiz,
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
              context.t.quiz.quit,
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
    Color borderColor = Colors.grey.shade300;
    Color textColor = const Color(0xFF1A1A1A);

    if (widget.answered) {
      if (widget.showCorrect) {
        bgColor = const Color(0xFFE8F5E9);
        borderColor = const Color(0xFF2E9E5B);
        textColor = const Color(0xFF2E9E5B);
      } else if (widget.isWrong) {
        bgColor = const Color(0xFFFDE8E8);
        borderColor = Colors.red;
        textColor = Colors.red;
      }
    } else if (widget.isSelected) {
      bgColor = const Color(0xFFF0FAF5);
      borderColor = const Color(0xFF2E9E5B);
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
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: 1.5,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              if (widget.trailingIcon != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: widget.trailingIcon!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
