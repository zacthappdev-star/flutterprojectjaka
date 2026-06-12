// lib/models/progress_model.dart

class AppProgressModel {
  final double progressHiragana; // e.g. 0.35 (35%)
  final double progressKatakana; // e.g. 0.10 (10%)
  final int unlockedHiraganaLevels;
  final int unlockedKatakanaLevels;
  final int totalQuizCompleted;
  final int dailyStreak;

  const AppProgressModel({
    required this.progressHiragana,
    required this.progressKatakana,
    required this.unlockedHiraganaLevels,
    required this.unlockedKatakanaLevels,
    required this.totalQuizCompleted,
    required this.dailyStreak,
  });
}
