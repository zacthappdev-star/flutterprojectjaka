// lib/screen/layar_progres.dart
//
// Layar progres belajar — streak, persentase, statistik, dan pengingat.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/models/model_progres.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';
import 'package:ppkd_b6/services/layanan_notifikasi.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/progres/baris_statistik_progres.dart';
import 'package:ppkd_b6/widgets/progres/kartu_pengingat_belajar.dart';
import 'package:ppkd_b6/widgets/progres/kartu_progres_persen.dart';
import 'package:ppkd_b6/widgets/progres/kartu_streak_progres.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayarProgres extends StatefulWidget {
  const LayarProgres({super.key});

  @override
  State<LayarProgres> createState() => _LayarProgresState();
}

class _LayarProgresState extends State<LayarProgres> {
  // ─── State Data ────────────────────────────────────────────────────────────
  bool _isLoading = true;
  bool _hasError = false;
  late AppProgressModel _progress;
  bool _reminderEnabled = false;
  int _reminderHour = 20;
  int _reminderMinute = 0;
  String _nextReminderText = '';
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    try {
      final prog = await ProgressService.getProgress();
      final prefs = await SharedPreferences.getInstance();

      if (mounted) {
        setState(() {
          _progress = prog;
          _reminderEnabled = prefs.getBool('reminder_enabled') ?? false;
          _reminderHour = prefs.getInt('reminder_hour') ?? 20;
          _reminderMinute = prefs.getInt('reminder_minute') ?? 0;
          _isLoading = false;
        });
        if (_reminderEnabled) {
          _refreshCountdown();
          _startCountdownTimer();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  // ─── Aksi Pengingat ────────────────────────────────────────────────────────
  Future<void> _toggleReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('reminder_enabled', value);
    setState(() => _reminderEnabled = value);

    if (value) {
      await NotificationService.requestPermissions();
      await NotificationService.scheduleDailyReminder(
        hour: _reminderHour,
        minute: _reminderMinute,
      );
      _refreshCountdown();
      _startCountdownTimer();
      if (!mounted) return;
      _showSnackbar(
        context.t.progress.reminderActive(
          time: _formatTime(_reminderHour, _reminderMinute),
        ),
      );
    } else {
      await NotificationService.cancelAll();
      _countdownTimer?.cancel();
      _countdownTimer = null;
      setState(() => _nextReminderText = '');
      if (!mounted) return;
      _showSnackbar(context.t.progress.reminderDisabled);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _reminderHour, minute: _reminderMinute),
    );

    if (picked != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('reminder_hour', picked.hour);
      await prefs.setInt('reminder_minute', picked.minute);
      setState(() {
        _reminderHour = picked.hour;
        _reminderMinute = picked.minute;
      });

      if (_reminderEnabled) {
        await NotificationService.scheduleDailyReminder(
          hour: picked.hour,
          minute: picked.minute,
        );
        _refreshCountdown();
        _startCountdownTimer();
        if (!context.mounted) return;
        _showSnackbar(
          context.t.progress.reminderUpdated(
            time: _formatTime(picked.hour, picked.minute),
          ),
        );
      }
    }
  }

  String _formatTime(int hour, int minute) {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  void _refreshCountdown() {
    if (!_reminderEnabled) {
      setState(() => _nextReminderText = '');
      return;
    }

    final now = DateTime.now();
    DateTime nextReminder = DateTime(
      now.year,
      now.month,
      now.day,
      _reminderHour,
      _reminderMinute,
    );

    if (!nextReminder.isAfter(now)) {
      nextReminder = nextReminder.add(Duration(days: 1));
    }

    final difference = nextReminder.difference(now);
    final totalMinutes = difference.inMinutes;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    final nextText = context.t.progress.reminderLeft(
      hours: hours.toString(),
      minutes: minutes.toString(),
    );

    if (mounted) {
      setState(() => _nextReminderText = nextText);
    }
  }

  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _refreshCountdown();
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _showSnackbar(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: AppColors.primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // ─── UI Utama ──────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryGreen),
        ),
      );
    }

    if (_hasError) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: Colors.red.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  context.t.errors.loadFailed,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: context.hiKata.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _loadData,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(context.t.errors.retry),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontFamily: 'Poppins'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final totalUnlocked =
        _progress.unlockedHiraganaLevels + _progress.unlockedKatakanaLevels;
    final colors = context.hiKata;

    return Scaffold(
      backgroundColor: context.hiKata.cardBackground,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  KartuStreakProgres(dailyStreak: _progress.dailyStreak),
                  Row(
                    children: [
                      Expanded(
                        child: KartuProgresPersen(
                          title: 'Hiragana',
                          progress: _progress.progressHiragana,
                          accentColor: const Color(0xFF2E9E5B),
                          badgeBg: colors.lightBackground,
                          icon: 'あ',
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: KartuProgresPersen(
                          title: 'Katakana',
                          progress: _progress.progressKatakana,
                          accentColor: const Color(0xFF2E9E5B),
                          badgeBg: colors.tableCardBgKatakana,
                          icon: 'ア',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildKartuStatistik(totalUnlocked),
                  SizedBox(height: 20),
                  Text(
                    context.t.progress.studyReminders,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? colors.textPrimary
                          : const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 10),
                  KartuPengingatBelajar(
                    reminderEnabled: _reminderEnabled,
                    reminderHour: _reminderHour,
                    reminderMinute: _reminderMinute,
                    nextReminderText: _nextReminderText,
                    onToggle: _toggleReminder,
                    onPilihWaktu: () => _selectTime(context),
                    formatWaktu: _formatTime,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Komponen Layar ────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF2E9E5B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Text(
          context.t.progress.learningProgress,
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

  Widget _buildKartuStatistik(int totalUnlocked) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: AppDecorations.cardDecorationOf(context),
      child: Column(
        children: [
          BarisStatistikProgres(
            icon: Icons.lock_open_rounded,
            iconColor: AppColors.primaryGreen,
            label: context.t.progress.totalUnlockedLevels,
            value: '$totalUnlocked',
          ),
          const Divider(height: 24, thickness: 1.2),
          BarisStatistikProgres(
            icon: Icons.quiz_outlined,
            iconColor: const Color(0xFFE65100),
            label: context.t.progress.totalQuizzesCompleted,
            value: '${_progress.totalQuizCompleted}',
          ),
          const Divider(height: 24, thickness: 1.2),
          BarisStatistikProgres(
            icon: Icons.emoji_events_rounded,
            iconColor: const Color(0xFFFFB300),
            label: 'Total XP',
            value: '${context.watch<ProfileProvider>().totalXP}',
          ),
        ],
      ),
    );
  }
}
