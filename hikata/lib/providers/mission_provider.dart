import 'package:flutter/material.dart';
import 'package:ppkd_b6/database/database_helper.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';

class Mission {
  final String id;
  final String title;
  final int xp;
  final double progress;
  final IconData icon;
  final bool isCompleted;
  final bool isClaimed;

  Mission({
    required this.id,
    required this.title,
    required this.xp,
    required this.progress,
    required this.icon,
    required this.isCompleted,
    required this.isClaimed,
  });

  Mission copyWith({
    String? id,
    String? title,
    int? xp,
    double? progress,
    IconData? icon,
    bool? isCompleted,
    bool? isClaimed,
  }) {
    return Mission(
      id: id ?? this.id,
      title: title ?? this.title,
      xp: xp ?? this.xp,
      progress: progress ?? this.progress,
      icon: icon ?? this.icon,
      isCompleted: isCompleted ?? this.isCompleted,
      isClaimed: isClaimed ?? this.isClaimed,
    );
  }
}

class MissionProvider with ChangeNotifier {
  List<Mission> missions = [];
  bool isLoading = true;

  Future<void> loadMissions() async {
    isLoading = true;
    notifyListeners();

    final userId = await ProgressService.getActiveUserId();
    if (userId == null) {
      isLoading = false;
      notifyListeners();
      return;
    }

    final dbHelper = DatabaseHelper.instance;
    final now = DateTime.now();
    final todayStr =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final claimedMissions = await dbHelper.getClaimedMissions(userId, todayStr);

    // Check progress
    final streak = await dbHelper.getStreak(userId);

    // Mission 1: Lesson done = learned at least one new character today.
    // (Don't rely on progress.updated_at — that field is bumped by quizzes,
    //  XP gains, and even just viewing the progress screen.)
    final bool isLessonDone =
        await dbHelper.hasLearnedCharacterOn(userId, todayStr);

    // Mission 2: Mixed quiz
    // Note: getQuizStats gives overall total. For a real app, we might want to query today's quizzes explicitly.
    // For now, if they played any quiz, we can mock it or assume if total completed > 0 they played something.
    // Let's assume if total_completed > 0 we give them credit (or better: fetch quiz history for today).
    // Selesai = main kuis "mixed" hari ini DAN lulus (skor >= 80%).
    final history = await dbHelper.getQuizHistory(userId);
    bool isQuizDone = history.any((q) {
      if (!((q['created_at'] as String?) ?? '').startsWith(todayStr)) {
        return false;
      }
      if (q['quiz_type'] != 'mixed') return false;
      final score = (q['score'] as int?) ?? 0;
      final total = (q['total'] as int?) ?? 0;
      return total > 0 && score / total >= 0.80;
    });

    // Mission 3: Streak
    int currentStreak = (streak?['current_streak'] as int?) ?? 0;
    bool isStreakDone = currentStreak >= 3;

    final tr = LocaleSettings.currentLocale.translations;
    missions = [
      Mission(
        id: 'lesson',
        title: tr.missions.lesson,
        xp: 50,
        progress: isLessonDone ? 1.0 : 0.0,
        icon: Icons.menu_book_rounded,
        isCompleted: isLessonDone,
        isClaimed: claimedMissions.contains('lesson'),
      ),
      Mission(
        id: 'quiz_mixed',
        title: tr.missions.quizMixed,
        xp: 30,
        progress: isQuizDone ? 1.0 : 0.0,
        icon: Icons.quiz_rounded,
        isCompleted: isQuizDone,
        isClaimed: claimedMissions.contains('quiz_mixed'),
      ),
      Mission(
        id: 'streak',
        title: tr.missions.streak,
        xp: 20,
        progress: (currentStreak / 3.0).clamp(0.0, 1.0),
        icon: Icons.local_fire_department_rounded,
        isCompleted: isStreakDone,
        isClaimed: claimedMissions.contains('streak'),
      ),
    ];

    isLoading = false;
    notifyListeners();
  }

  Future<void> claimMission(String missionId) async {
    final userId = await ProgressService.getActiveUserId();
    if (userId == null) return;

    final index = missions.indexWhere((m) => m.id == missionId);
    if (index == -1) return;

    final mission = missions[index];
    if (!mission.isCompleted || mission.isClaimed) return;

    final now = DateTime.now();
    final todayStr =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final result = await DatabaseHelper.instance.claimMission(
      userId,
      todayStr,
      missionId,
      mission.xp,
    );
    if (result > 0) {
      missions[index] = mission.copyWith(isClaimed: true);
      notifyListeners();
    }
  }
}
