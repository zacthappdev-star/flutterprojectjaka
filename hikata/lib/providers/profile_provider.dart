import 'package:flutter/material.dart';
import 'package:ppkd_b6/database/database_helper.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';

class ProfileProvider with ChangeNotifier {
  String avatar = '🐼';
  String userName = 'Pelajar HI KATA';
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

  bool isLoading = true;

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
    userName = user?['nama'] ?? 'Pelajar HI KATA';
    userEmail = user?['email'] ?? '';
    
    final createdAt = user?['created_at'] as String?;
    if (createdAt != null && createdAt.isNotEmpty) {
      try {
        final date = DateTime.parse(createdAt);
        final months = [
          'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
          'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
        ];
        joinDate = '${months[date.month - 1]} ${date.year}';
      } catch (_) {
        joinDate = 'Jan 2026';
      }
    } else {
      joinDate = 'Jan 2026';
    }

    currentStreak = streak?['current_streak'] ?? 0;
    bestStreak = streak?['best_streak'] ?? 0;
    
    totalQuizzes = stats['total_completed'] ?? 0;
    overallHigh = stats['overall_high'] ?? 0;
    hiraganaHigh = stats['hiragana_high'] ?? 0;
    katakanaHigh = stats['katakana_high'] ?? 0;
    mixedHigh = stats['mixed_high'] ?? 0;
    
    progressHiragana = progress?['hiragana_percent'] ?? 0.0;
    progressKatakana = progress?['katakana_percent'] ?? 0.0;

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
}
