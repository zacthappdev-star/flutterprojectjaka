import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';

class HeaderDasbor extends StatelessWidget {
  final ProfileProvider profile;

  const HeaderDasbor({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final t = context.t.home;
    String greeting = t.morning;
    if (hour >= 11 && hour < 15) {
      greeting = t.afternoon;
    } else if (hour >= 15 && hour < 19) {
      greeting = t.evening;
    } else if (hour >= 19 || hour < 4) {
      greeting = t.night;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF2E9E5B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(profile.avatar, style: const TextStyle(fontSize: 44)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    Text(
                      profile.userName,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildStatPill('🔥', t.days(count: profile.currentStreak)),
              _buildStatPill('✨', t.xp(count: profile.totalXP)),
              _buildStatPill(profile.rankIcon, profile.rankName),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(String emoji, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
