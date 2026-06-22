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

  static Future<bool> isModuleUnlocked(String module) async {
    final userId = await getActiveUserId();
    if (userId == null) return false;
    final progressMap = await DatabaseHelper.instance.getProgress(userId);
    final double hPct = progressMap?['hiragana_percent'] ?? 0.0;
    final double kPct = progressMap?['katakana_percent'] ?? 0.0;
    
    // Asumsikan Gojuon adalah gabungan dasar.
    // Jika module spesifik ada nilai persentase di table, kita bisa pakai.
    // Sementara kita gunakan persentase hiragana & katakana dasar sebagai patokan.
    
    switch (module.toLowerCase()) {
      case 'hiragana':
        return true; // Hiragana selalu terbuka
      case 'katakana':
        return hPct >= 0.50; // Minimal 50% Hiragana
      case 'gojuon':
        return hPct >= 1.0; // Hiragana selesai 100%
      case 'dakuten':
        return hPct >= 1.0 && kPct >= 0.50; // Hiragana 100% + Katakana 50%
      case 'handakuten':
        return hPct >= 1.0 && kPct >= 1.0; // Hiragana + Katakana selesai
      case 'yoon':
        return hPct >= 1.0 && kPct >= 1.0; // Sama dengan Handakuten untuk saat ini
      default:
        return true;
    }
  }

  static Future<bool> handleQuizSubmission({
    required String mode,
    int? levelIndex,
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

    int xpToAdd = 20;
    if (passed) {
      xpToAdd += 10;
    }
    await DatabaseHelper.instance.addXp(userId, xpToAdd);

    if (passed && levelIndex != null) {
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
      final result = await DatabaseHelper.instance.markCharacterAsLearned(userId, character);
      if (result > 0) {
        // Recalculate percent and update
        final learnedChars = await DatabaseHelper.instance.getLearnedCharacters(userId);
        
        // Count hiragana
        final allHiragana = HiraganaData.allTableChars.map((e) => e.character).toSet();
        int hCount = learnedChars.where((c) => allHiragana.contains(c)).length;
        double hPct = (hCount / allHiragana.length).clamp(0.0, 1.0);
        
        // Count katakana
        final allKatakana = KatakanaData.allTableChars.map((e) => e.character).toSet();
        int kCount = learnedChars.where((c) => allKatakana.contains(c)).length;
        double kPct = (kCount / allKatakana.length).clamp(0.0, 1.0);
        
        final progress = await DatabaseHelper.instance.getProgress(userId);
        final hLevel = progress?['hiragana_level'] ?? 1;
        final kLevel = progress?['katakana_level'] ?? 1;
        
        await DatabaseHelper.instance.updateProgress(userId, hPct, kPct, hLevel, kLevel);
        await DatabaseHelper.instance.addXp(userId, 5); // +5 per char? Flashcard complete is handled elsewhere
      }
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
