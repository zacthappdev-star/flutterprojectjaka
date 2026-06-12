// lib/screen/layar_progres.dart
//
// Layar progres belajar — streak, persentase, statistik, dan pengingat.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ppkd_b6/models/model_progres.dart';
import 'package:ppkd_b6/services/layanan_notifikasi.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/progres/baris_statistik_progres.dart';
import 'package:ppkd_b6/widgets/progres/kartu_pengingat_belajar.dart';
import 'package:ppkd_b6/widgets/progres/kartu_progres_persen.dart';
import 'package:ppkd_b6/widgets/progres/kartu_streak_progres.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pengenalan/pilih_bahasa.dart';

class LayarProgres extends StatefulWidget {
  const LayarProgres({super.key});

  @override
  State<LayarProgres> createState() => _LayarProgresState();
}

class _LayarProgresState extends State<LayarProgres> {
  // ─── State Data ────────────────────────────────────────────────────────────
  bool _isLoading = true;
  late AppProgressModel _progress;
  bool _reminderEnabled = false;
  int _reminderHour = 20;
  int _reminderMinute = 0;
  String _nextReminderText = '';
  Timer? _countdownTimer;

  bool get _isID => AppLanguage.current == 'id';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
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
      _showSnackbar(
        _isID
            ? 'Pengingat belajar aktif harian pada ${_formatTime(_reminderHour, _reminderMinute)} 🔔'
            : 'Daily study reminder scheduled at ${_formatTime(_reminderHour, _reminderMinute)} 🔔',
      );
    } else {
      await NotificationService.cancelAll();
      _countdownTimer?.cancel();
      _countdownTimer = null;
      setState(() => _nextReminderText = '');
      _showSnackbar(
        _isID
            ? 'Pengingat belajar dinonaktifkan 🔕'
            : 'Study reminder disabled 🔕',
      );
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
        _showSnackbar(
          _isID
              ? 'Jam pengingat diubah ke ${_formatTime(picked.hour, picked.minute)} ⏰'
              : 'Reminder time updated to ${_formatTime(picked.hour, picked.minute)} ⏰',
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
    final nextText = _isID
        ? '⏰ $hours jam $minutes menit lagi'
        : '⏰ $hours hours $minutes minutes left';

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
        content: Text(msg, style: const TextStyle(fontFamily: 'Poppins')),
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

    final totalUnlocked =
        _progress.unlockedHiraganaLevels + _progress.unlockedKatakanaLevels;
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
                SizedBox(height: 20),
                KartuStreakProgres(
                  isID: _isID,
                  dailyStreak: _progress.dailyStreak,
                ),
                Row(
                  children: [
                    Expanded(
                      child: KartuProgresPersen(
                        title: 'Hiragana',
                        progress: _progress.progressHiragana,
                        accentColor: AppColors.primaryGreen,
                        badgeBg: colors.lightBackground,
                        icon: 'あ',
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: KartuProgresPersen(
                        title: 'Katakana',
                        progress: _progress.progressKatakana,
                        accentColor: const Color.fromARGB(255, 235, 140, 16),
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
                  _isID ? 'Pengingat Belajar' : 'Study Reminders',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                KartuPengingatBelajar(
                  isID: _isID,
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
      ),
    );
  }

  // ─── Komponen Layar ────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Center(
      child: Text(
        _isID ? 'Progres Belajar' : 'Learning Progress',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Colors.white,
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
            label: _isID ? 'Total Level Terbuka' : 'Total Unlocked Levels',
            value: '$totalUnlocked',
          ),
          const Divider(height: 24, thickness: 1.2),
          BarisStatistikProgres(
            icon: Icons.quiz_outlined,
            iconColor: const Color(0xFFE65100),
            label: _isID ? 'Total Quiz Selesai' : 'Total Quizzes Completed',
            value: '${_progress.totalQuizCompleted}',
          ),
        ],
      ),
    );
  }
}
