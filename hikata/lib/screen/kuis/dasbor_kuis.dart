import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/kuis/kartu_opsi_kuis.dart';

import '../kuis/layar_kuis.dart';
import 'package:ppkd_b6/gen/strings.g.dart';

class DasborKuis extends StatefulWidget {
  const DasborKuis({super.key});

  @override
  State<DasborKuis> createState() => _DasborKuisState();
}

class _DasborKuisState extends State<DasborKuis> {

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KartuOpsiKuis(
                    title: context.t.quiz.quizHiragana,
                    subtitle: context.t.quiz.descQuizHiragana,
                    badge: 'あ',
                    accentColor: AppColors.primaryGreen,
                    badgeBg: colors.lightBackground,
                    questionCount: context.t.quiz.countQuestions(count: 10),
                    estimatedTime: context.t.quiz.estTime(time: 5),
                    difficulty: 'Sedang',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(mode: 'hiragana'),
                      ),
                    ),
                  ),
                  KartuOpsiKuis(
                    title: context.t.quiz.quizKatakana,
                    subtitle: context.t.quiz.descQuizKatakana,
                    badge: 'ア',
                    accentColor: const Color(0xFFFFB300),
                    badgeBg: colors.tableCardBgKatakana,
                    questionCount: context.t.quiz.countQuestions(count: 10),
                    estimatedTime: context.t.quiz.estTime(time: 5),
                    difficulty: 'Sedang',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(mode: 'Katakana'),
                      ),
                    ),
                  ),
                  KartuOpsiKuis(
                    title: 'Boss Level 🔥',
                    subtitle: context.t.quiz.descQuizMixed,
                    badge: '🌐',
                    accentColor: Colors.purple,
                    badgeBg: Colors.purple.shade50,
                    difficulty: 'Boss Level 🔥',
                    questionCount: context.t.quiz.countQuestions(count: 20),
                    estimatedTime: context.t.quiz.estTime(time: 10),
                    isLocked: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(mode: 'mixed'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.black12, thickness: 1.5),
                  const SizedBox(height: 16),
                  Text(
                    context.t.quiz.listeningQuizzes,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  KartuOpsiKuis(
                    title: context.t.quiz.listeningQuizHiragana,
                    subtitle: context.t.quiz.descListeningHiragana,
                    badge: '🔊',
                    accentColor: AppColors.primaryGreen,
                    badgeBg: colors.lightBackground,
                    questionCount: context.t.quiz.countQuestions(count: 10),
                    estimatedTime: context.t.quiz.estTime(time: 5),
                    difficulty: 'Sulit',
                    isAudio: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            QuizScreen(mode: 'hiragana', isListening: true),
                      ),
                    ),
                  ),
                  KartuOpsiKuis(
                    title: context.t.quiz.listeningQuizKatakana,
                    subtitle: context.t.quiz.descListeningKatakana,
                    badge: '🔊',
                    accentColor: const Color(0xFFFFB300),
                    badgeBg: colors.tableCardBgKatakana,
                    questionCount: context.t.quiz.countQuestions(count: 10),
                    estimatedTime: context.t.quiz.estTime(time: 5),
                    difficulty: 'Sulit',
                    isAudio: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            QuizScreen(mode: 'katakana', isListening: true),
                      ),
                    ),
                  ),
                  KartuOpsiKuis(
                    title: 'Boss Level 🔥',
                    subtitle: context.t.quiz.descListeningMixed,
                    badge: '🔊',
                    accentColor: Colors.purple,
                    badgeBg: Colors.purple.shade50,
                    questionCount: context.t.quiz.countQuestions(count: 20),
                    estimatedTime: context.t.quiz.estTime(time: 10),
                    difficulty: 'Boss Level 🔥',
                    isAudio: true,
                    isLocked: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            QuizScreen(mode: 'mixed', isListening: true),
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

  // ─── Header Layar ──────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF2E9E5B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Text(
          context.t.quiz.evaluationQuiz,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
