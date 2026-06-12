import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/kuis/kartu_opsi_kuis.dart';

import '../kuis/layar_kuis.dart';
import '../pengenalan/pilih_bahasa.dart';

class DasborKuis extends StatefulWidget {
  const DasborKuis({super.key});

  @override
  State<DasborKuis> createState() => _DasborKuisState();
}

class _DasborKuisState extends State<DasborKuis> {
  bool get _isID => AppLanguage.current == 'id';

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: colors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 24),
                KartuOpsiKuis(
                  title: 'Quiz Hiragana',
                  subtitle: _isID
                      ? 'Quiz campuran dari 46 karakter dasar Hiragana'
                      : 'Mixed quiz covering basic 46 Hiragana characters',
                  badge: 'あ',
                  accentColor: AppColors.primaryGreen,
                  badgeBg: colors.lightBackground,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(mode: 'hiragana'),
                    ),
                  ),
                ),
                KartuOpsiKuis(
                  title: 'Quiz Katakana',
                  subtitle: _isID
                      ? 'Quiz campuran dari 46 karakter dasar Katakana'
                      : 'Mixed quiz covering basic 46 Katakana characters',
                  badge: 'ア',
                  accentColor: const Color(0xFFFFB300),
                  badgeBg: colors.tableCardBgKatakana,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(mode: 'Katakana'),
                    ),
                  ),
                ),
                KartuOpsiKuis(
                  title: _isID ? 'Quiz Campuran' : 'Mixed Quiz',
                  subtitle: _isID
                      ? 'Tantangan quiz kombinasi Hiragana & Katakana'
                      : 'Combination challenge of Hiragana & Katakana',
                  badge: '🌐',
                  accentColor: Color(0xFFE65100),
                  badgeBg: Color(0xFFFFF3E0),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(mode: 'mixed'),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Divider(color: Colors.white24, thickness: 1.5),
                SizedBox(height: 16),
                Text(
                  _isID ? 'Quiz Pendengaran' : 'Listening Quizzes',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                KartuOpsiKuis(
                  title: _isID
                      ? 'Quiz Pendengaran Hiragana'
                      : 'Hiragana Listening Quiz',
                  subtitle: _isID
                      ? 'Quiz pendengaran dari 46 karakter dasar Hiragana'
                      : 'Listening quiz covering basic 46 Hiragana characters',
                  badge: '🔊',
                  accentColor: AppColors.primaryGreen,
                  badgeBg: colors.lightBackground,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          QuizScreen(mode: 'hiragana', isListening: true),
                    ),
                  ),
                ),
                KartuOpsiKuis(
                  title: _isID
                      ? 'Quiz Pendengaran Katakana'
                      : 'Katakana Listening Quiz',
                  subtitle: _isID
                      ? 'Quiz pendengaran dari 46 karakter dasar Katakana'
                      : 'Listening quiz covering basic 46 Katakana characters',
                  badge: '🔊',
                  accentColor: const Color(0xFFFFB300),
                  badgeBg: colors.tableCardBgKatakana,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          QuizScreen(mode: 'katakana', isListening: true),
                    ),
                  ),
                ),
                KartuOpsiKuis(
                  title: _isID
                      ? 'Quiz Pendengaran Campuran'
                      : 'Mixed Listening Quiz',
                  subtitle: _isID
                      ? 'Tantangan Quiz pendengaran Hiragana & Katakana'
                      : 'Listening challenge of Hiragana & Katakana',
                  badge: '🔊',
                  accentColor: Color(0xFFE65100),
                  badgeBg: Color(0xFFFFF3E0),
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
      ),
    );
  }

  // ─── Header Layar ──────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Center(
      child: Text(
        _isID ? 'Quiz Evaluasi' : 'Evaluation Quiz',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}
