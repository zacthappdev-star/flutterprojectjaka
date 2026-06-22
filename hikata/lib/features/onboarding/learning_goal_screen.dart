import 'package:flutter/material.dart';
import 'package:ppkd_b6/features/auth/login_screen.dart';

class LearningGoalScreen extends StatefulWidget {
  final String selectedReason;

  const LearningGoalScreen({super.key, required this.selectedReason});

  @override
  State<LearningGoalScreen> createState() => _LearningGoalScreenState();
}

class _LearningGoalScreenState extends State<LearningGoalScreen> {
  String _selectedGoal = 'Biasa'; // Default

  final List<Map<String, String>> _goals = [
    {
      'emoji': '☀️',
      'title': 'Santai',
      'subtitle': 'Bagus untuk perkenalan awal',
      'time': '5 menit / hari',
    },
    {
      'emoji': '⚡',
      'title': 'Biasa',
      'subtitle': 'Rekomendasi untuk pemula',
      'time': '10 menit / hari',
    },
    {
      'emoji': '🔥',
      'title': 'Serius',
      'subtitle': 'Progress belajar cepat',
      'time': '15 menit / hari',
    },
    {
      'emoji': '👑',
      'title': 'Intens',
      'subtitle': 'Tantangan belajar maksimal',
      'time': '20 menit / hari',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E7D32), // Solid Green
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Top Row
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 1.0,
                      backgroundColor: Colors.white30,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('2/2', style: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 16),
              const Center(
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Color(0xFF388E3C), // Hijau muda
                  child: Icon(Icons.track_changes, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Tujuan Belajarmu',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Mari tentukan target harian belajarmu!',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Feedback box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                          children: [
                            const TextSpan(text: 'Pilihan mantap! Kamu belajar untuk: '),
                            TextSpan(
                              text: widget.selectedReason,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Berapa target belajar harianmu?',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              // Goal Options
              ..._goals.map((goal) => _buildGoalOptionCard(
                    emoji: goal['emoji']!,
                    title: goal['title']!,
                    subtitle: goal['subtitle']!,
                    timeLabel: goal['time']!,
                  )),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Login Screen after onboarding
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2E7D32), // Green bold text
                ),
                child: const Text('MULAI BELAJAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalOptionCard({
    required String emoji,
    required String title,
    required String subtitle,
    required String timeLabel,
  }) {
    final bool isSelected = _selectedGoal == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGoal = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1F8E9) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFF2E7D32) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              timeLabel,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
