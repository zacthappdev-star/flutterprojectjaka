import 'package:flutter/material.dart';
import 'package:ppkd_b6/features/onboarding/learning_reason_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'id'; // default id

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E7D32), // Solid Green
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF388E3C),
                child: Text('🌐', style: TextStyle(fontSize: 28)),
              ),
              const SizedBox(height: 20),
              const Text(
                'HI KATA',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pilih Bahasa / Choose Language',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),
              _buildLanguageOptionCard(
                flag: '🇮🇩',
                name: 'Bahasa Indonesia',
                desc: 'Indonesian',
                value: 'id',
              ),
              const SizedBox(height: 16),
              _buildLanguageOptionCard(
                flag: '🇺🇸',
                name: 'English',
                desc: 'English',
                value: 'en',
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LearningReasonScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF2E7D32), // Green bold text
                ),
                child: const Text('LANJUTKAN'),
              ),
              const SizedBox(height: 12),
              const Text(
                'You can change language anytime',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOptionCard({
    required String flag,
    required String name,
    required String desc,
    required String value,
  }) {
    final bool isSelected = _selectedLanguage == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E5C35) : Colors.transparent, // Dark Green
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              radius: 12,
              backgroundColor: isSelected ? const Color(0xFF2E7D32) : Colors.transparent,
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF2E7D32), width: 1.5),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
