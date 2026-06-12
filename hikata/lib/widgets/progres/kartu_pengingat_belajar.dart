import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class KartuPengingatBelajar extends StatelessWidget {
  final bool isID;
  final bool reminderEnabled;
  final int reminderHour;
  final int reminderMinute;
  final String nextReminderText;
  final ValueChanged<bool> onToggle;
  final VoidCallback onPilihWaktu;
  final String Function(int hour, int minute) formatWaktu;

  const KartuPengingatBelajar({
    super.key,
    required this.isID,
    required this.reminderEnabled,
    required this.reminderHour,
    required this.reminderMinute,
    required this.nextReminderText,
    required this.onToggle,
    required this.onPilihWaktu,
    required this.formatWaktu,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: AppDecorations.cardDecorationOf(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.notifications_active_outlined,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    isID ? 'Aktifkan Pengingat' : 'Enable Alarm',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
              Switch(
                value: reminderEnabled,
                onChanged: onToggle,
                activeThumbColor: AppColors.primaryGreen,
              ),
            ],
          ),
          if (reminderEnabled) ...[
            Divider(height: 24, thickness: 1.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.alarm_rounded,
                        color: AppColors.secondaryGreen,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      isID ? 'Waktu Belajar' : 'Study Time',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: onPilihWaktu,
                  child: Text(
                    formatWaktu(reminderHour, reminderMinute),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.secondaryGreen,
                    ),
                  ),
                ),
              ],
            ),
            if (nextReminderText.isNotEmpty) ...[
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isID ? 'Notifikasi Berikutnya' : 'Next Reminder',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.textMuted,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      nextReminderText,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
