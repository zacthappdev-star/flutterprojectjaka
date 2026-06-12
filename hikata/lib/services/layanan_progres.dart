import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_hiragana.dart';
import '../data/data_katakana.dart';
import '../database/database_helper.dart';
import '../models/model_progres.dart';

class ProgressService {
  static Future<int?> getActiveUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('active_user_id');
  }

  static Future<AppProgressModel> getProgress() async {
    final userId = await getActiveUserId();
    if (userId == null) {
      return const AppProgressModel(
        progressHiragana: 0.0,
        progressKatakana: 0.0,
        unlockedHiraganaLevels: 1,
        unlockedKatakanaLevels: 1,
        totalQuizCompleted: 0,
        dailyStreak: 0,
      );
    }
    final dbHelper = DatabaseHelper.instance;
    final progressMap = await dbHelper.getProgress(userId);
    final stats = await dbHelper.getQuizStats(userId);
    final streak = await getAndUpdateStreak();
    final unlockedHiragana = progressMap?['hiragana_level'] ?? 1;
    final unlockedKatakana = progressMap?['katakana_level'] ?? 1;
    final totalHiraganaLevels = HiraganaData.groups.length;
    final totalKatakanaLevels = KatakanaData.groups.length;
    final hiraganaPct = ((unlockedHiragana - 1) / totalHiraganaLevels).clamp(
      0.0,
      1.0,
    );
    final katakanaPct = ((unlockedKatakana - 1) / totalKatakanaLevels).clamp(
      0.0,
      1.0,
    );
    await dbHelper.updateProgress(
      userId,
      hiraganaPct,
      katakanaPct,
      unlockedHiragana,
      unlockedKatakana,
    );
    return AppProgressModel(
      progressHiragana: hiraganaPct,
      progressKatakana: katakanaPct,
      unlockedHiraganaLevels: unlockedHiragana,
      unlockedKatakanaLevels: unlockedKatakana,
      totalQuizCompleted: stats['total_completed'] ?? 0,
      dailyStreak: streak,
    );
  }

  static Future<bool> isLevelUnlocked(String mode, int levelIndex) async {
    if (levelIndex == 0) return true;
    final userId = await getActiveUserId();
    if (userId == null) return false;
    final progressMap = await DatabaseHelper.instance.getProgress(userId);
    if (mode == 'hiragana') {
      final unlocked = progressMap?['hiragana_level'] ?? 1;
      return levelIndex < unlocked;
    } else {
      final unlocked = progressMap?['katakana_level'] ?? 1;
      return levelIndex < unlocked;
    }
  }

  static Future<bool> handleQuizSubmission({
    required String mode,
    required int levelIndex,
    required int score,
    required int total,
  }) async {
    final userId = await getActiveUserId();
    if (userId == null) return false;
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.insertQuizHistory(userId, mode, score, total);
    await getAndUpdateStreak(forceActivity: true);
    final double pct = total > 0 ? (score / total) : 0.0;
    final bool passed = pct >= 0.80;

    if (passed) {
      final progressMap = await dbHelper.getProgress(userId);
      final int currentUnlocked = mode == 'hiragana'
          ? (progressMap?['hiragana_level'] ?? 1)
          : (progressMap?['katakana_level'] ?? 1);

      if (levelIndex + 1 == currentUnlocked) {
        await dbHelper.unlockLevel(userId, mode, currentUnlocked + 1);
        return true;
      }
    }
    return false;
  }

  static Future<int> getAndUpdateStreak({bool forceActivity = false}) async {
    final userId = await getActiveUserId();
    if (userId == null) return 0;
    final dbHelper = DatabaseHelper.instance;
    final today = DateTime.now();
    final todayStr = "${today.year}-${today.month.pad}-${today.day.pad}";
    final streakData = await dbHelper.getStreak(userId);
    final lastActiveStr = streakData?['last_study_date'] ?? '';
    int currentStreak = streakData?['current_streak'] ?? 0;
    int bestStreak = streakData?['best_streak'] ?? 0;

    if (lastActiveStr.isEmpty) {
      if (forceActivity) {
        currentStreak = 1;
        bestStreak = bestStreak < 1 ? 1 : bestStreak;
        await dbHelper.updateStreak(
          userId,
          todayStr,
          currentStreak,
          bestStreak,
        );
      }
      return currentStreak;
    }
    if (lastActiveStr == todayStr) {
      return currentStreak; // Already active today
    }

    final yesterday = today.subtract(const Duration(days: 1));
    final yesterdayStr =
        "${yesterday.year}-${yesterday.month.pad}-${yesterday.day.pad}";
    if (lastActiveStr == yesterdayStr) {
      if (forceActivity) {
        currentStreak += 1;
        bestStreak = bestStreak < currentStreak ? currentStreak : bestStreak;
        await dbHelper.updateStreak(
          userId,
          todayStr,
          currentStreak,
          bestStreak,
        );
      }
    } else {
      if (forceActivity) {
        currentStreak = 1;
        bestStreak = bestStreak < 1 ? 1 : bestStreak;
        await dbHelper.updateStreak(
          userId,
          todayStr,
          currentStreak,
          bestStreak,
        );
      } else {
        currentStreak = 0;
        await dbHelper.updateStreak(
          userId,
          lastActiveStr,
          currentStreak,
          bestStreak,
        );
      }
    }
    return currentStreak;
  }

  static Future<void> markCharacterAsLearned(String character) async {
    final userId = await getActiveUserId();
    if (userId != null) {
      await DatabaseHelper.instance.markCharacterAsLearned(userId, character);
    }
  }

  static Future<List<String>> getLearnedCharacters() async {
    final userId = await getActiveUserId();
    if (userId != null) {
      return await DatabaseHelper.instance.getLearnedCharacters(userId);
    }
    return [];
  }

  static Future<bool> isCharacterLearned(String character) async {
    final userId = await getActiveUserId();
    if (userId != null) {
      return await DatabaseHelper.instance.isCharacterLearned(
        userId,
        character,
      );
    }
    return false;
  }
}

extension _IntPad on int {
  String get pad => toString().padLeft(2, '0');
}
