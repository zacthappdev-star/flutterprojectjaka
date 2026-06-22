import 'package:flutter/material.dart';
import 'package:ppkd_b6/features/onboarding/learning_goal_screen.dart';

class LearningReasonScreen extends StatefulWidget {
  const LearningReasonScreen({super.key});

  @override
  State<LearningReasonScreen> createState() => _LearningReasonScreenState();
}

class _LearningReasonScreenState extends State<LearningReasonScreen> {
  String? _selectedReason;

  final List<Map<String, dynamic>> _reasons = [
    {
      'icon': Icons.school,
      'title': 'Pendidikan / Sekolah',
      'subtitle': 'Untuk tugas sekolah atau pelajaran formal',
    },
    {
      'icon': Icons.tv,
      'title': 'Anime & Pop Culture',
      'subtitle': 'Biar bisa nonton anime tanpa subtitle',
    },
    {
      'icon': Icons.work_outline,
      'title': 'Karir & Pekerjaan',
      'subtitle': 'Persiapan kerja atau beasiswa ke Jepang',
    },
    {
      'icon': Icons.flight,
      'title': 'Wisata / Travelling',
      'subtitle': 'Kemudahan berkomunikasi saat berwisata',
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
                      value: 0.5,
                      backgroundColor: Colors.white30,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('1/2', style: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Kenapa kamu tertarik belajar Bahasa Jepang?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pilih salah satu alasan utamamu belajar bahasa Jepang',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),
              // Options
              ..._reasons.map((reason) => _buildReasonOptionCard(
                    icon: reason['icon'],
                    title: reason['title'],
                    subtitle: reason['subtitle'],
                  )),
              const Spacer(),
              ElevatedButton(
                onPressed: _selectedReason == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LearningGoalScreen(
                              selectedReason: _selectedReason!,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedReason == null ? Colors.white38 : Colors.white,
                  foregroundColor: const Color(0xFF2E7D32), // Green bold text
                ),
                child: const Text('LANJUTKAN'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReasonOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final bool isSelected = _selectedReason == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedReason = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14.0),
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
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFC8E6C9), // Light green bg
              child: Icon(icon, color: const Color(0xFF2E7D32), size: 18),
            ),
            const SizedBox(width: 12),
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
          ],
        ),
      ),
    );
  }
}
