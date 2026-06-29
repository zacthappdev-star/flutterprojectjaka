import 'package:flutter/material.dart';
import 'package:ppkd_b6/database/database_helper.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';

import 'package:ppkd_b6/gen/strings.g.dart';

class ProfileProvider with ChangeNotifier {
  String avatar = '🐼';
  String userName = 'HI KATA Learner';
  String userEmail = '';
  String joinDate = 'Jan 2024';

  int currentStreak = 0;
  int bestStreak = 0;
  int totalQuizzes = 0;
  int overallHigh = 0;
  int hiraganaHigh = 0;
  int katakanaHigh = 0;
  int mixedHigh = 0;

  double progressHiragana = 0.0;
  double progressKatakana = 0.0;

  int scriptGuideLevel = 1;
  int missionXP = 0;
  List<String> learnedCharacters = [];


  int xp = 0;
  int level = 1;

  bool isLoading = true;

  int get totalXP {
    return xp;
  }

  /// Returns a locale-aware rank name.
  /// Pass the current [AppLocale] from your widget using
  /// `LocaleSettings.currentLocale` or from context.
  String rankNameForLocale(AppLocale locale) {
    final tr = locale.translations;
    if (level < 3) {
      return 'Lv. $level ${tr.home.rankBeginner}';
    } else if (level < 5) {
      return 'Lv. $level ${tr.home.rankIntermediate}';
    } else {
      return 'Lv. $level ${tr.home.rankAdvanced}';
    }
  }

  /// Convenience getter using the currently active locale.
  String get rankName => rankNameForLocale(LocaleSettings.currentLocale);

  String get rankIcon {
    if (level < 3) return '🌱';
    if (level < 5) return '🌿';
    return '🌳';
  }

  Future<void> loadProfileData() async {
    isLoading = true;
    notifyListeners();

    final userId = await ProgressService.getActiveUserId();
    if (userId == null) {
      isLoading = false;
      notifyListeners();
      return;
    }

    final dbHelper = DatabaseHelper.instance;
    final user = await dbHelper.getUser(userId);
    final streak = await dbHelper.getStreak(userId);
    final stats = await dbHelper.getQuizStats(userId);
    final progress = await dbHelper.getProgress(userId);

    avatar = user?['avatar'] ?? '🐼';
    userName = user?['nama'] ?? LocaleSettings.currentLocale.translations.common.student;
    userEmail = user?['email'] ?? '';

    final createdAt = user?['created_at'] as String?;
    if (createdAt != null && createdAt.isNotEmpty) {
      try {
        final date = DateTime.parse(createdAt);
        final isEn = LocaleSettings.currentLocale == AppLocale.en;
        final months = isEn 
            ? ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
            : ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
        joinDate = '${months[date.month - 1]} ${date.year}';
      } catch (_) {
        joinDate = 'Jan 2026';
      }
    } else {
      joinDate = 'Jan 2026';
    }

    currentStreak = (streak?['current_streak'] as int?) ?? 0;
    bestStreak = (streak?['best_streak'] as int?) ?? 0;

    totalQuizzes = stats['total_completed'] ?? 0;
    overallHigh = stats['overall_high'] ?? 0;
    hiraganaHigh = stats['hiragana_high'] ?? 0;
    katakanaHigh = stats['katakana_high'] ?? 0;
    mixedHigh = stats['mixed_high'] ?? 0;

    progressHiragana = (progress?['hiragana_percent'] as num?)?.toDouble() ?? 0.0;
    progressKatakana = (progress?['katakana_percent'] as num?)?.toDouble() ?? 0.0;
    scriptGuideLevel = (progress?['script_guide_level'] as int?) ?? 1;
    xp = (progress?['xp'] as int?) ?? 0;
    level = (progress?['level'] as int?) ?? 1;

    missionXP = await dbHelper.getTotalMissionXP(userId);
    learnedCharacters = await dbHelper.getLearnedCharacters(userId);


    isLoading = false;
    notifyListeners();
  }

  Future<void> updateAvatar(String newAvatar) async {
    final userId = await ProgressService.getActiveUserId();
    if (userId != null) {
      await DatabaseHelper.instance.updateAvatar(userId, newAvatar);
      avatar = newAvatar;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadProfileData();
  }

  Future<void> markCharacterLearned(String char) async {
    if (learnedCharacters.contains(char)) return;
    // Delegate to ProgressService so this path matches the flashcard/group path:
    // it inserts the char AND recalculates hiragana/katakana percent AND awards
    // +5 XP (only on a genuinely new character). Previously this wrote straight
    // to the DB and skipped both, so progress differed depending on which screen
    // marked the character.
    await ProgressService.markCharacterAsLearned(char);
    learnedCharacters.add(char);
    notifyListeners();
  }


  Future<void> completeScriptGuide(int index) async {
    // index is 0-based. So index 0 corresponds to level 1.
    if (index != scriptGuideLevel - 1) return;

    final userId = await ProgressService.getActiveUserId();
    if (userId == null) return;

    // Only advance in-memory state after we know the user is valid, so a null
    // userId can't leave scriptGuideLevel permanently ahead of the DB.
    final nextLevel = scriptGuideLevel + 1;
    await DatabaseHelper.instance.updateScriptGuideLevel(userId, nextLevel);
    await DatabaseHelper.instance.addXp(userId, 20);
    // loadProfileData() reloads scriptGuideLevel/xp/level from DB and notifies.
    await loadProfileData();
  }

  /// Resets all in-memory profile state to defaults. Call on logout / account
  /// deletion so the next user never sees the previous user's data.
  void clear() {
    avatar = '🐼';
    userName = 'HI KATA Learner';
    userEmail = '';
    learnedCharacters = [];

    joinDate = 'Jan 2026';
    currentStreak = 0;
    bestStreak = 0;
    totalQuizzes = 0;
    overallHigh = 0;
    hiraganaHigh = 0;
    katakanaHigh = 0;
    mixedHigh = 0;
    progressHiragana = 0.0;
    progressKatakana = 0.0;
    scriptGuideLevel = 1;
    missionXP = 0;
    xp = 0;
    level = 1;
    isLoading = false;
    notifyListeners();
  }
}
