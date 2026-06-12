// lib/models/quiz_model.dart

class QuizResult {
  final int levelIndex;
  final String mode; // 'Hiragana' ATAU 'Katakana'
  final int score;
  final int total;
  final double percentage;
  final bool isPassed;

  const QuizResult({
    required this.levelIndex,
    required this.mode,
    required this.score,
    required this.total,
    required this.percentage,
    required this.isPassed,
  });
}
