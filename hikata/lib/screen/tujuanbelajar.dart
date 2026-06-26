import 'package:flutter/material.dart';
import 'package:ppkd_b6/screen/tata_utama.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReasonResultScreen extends StatefulWidget {
  final String reason;
  final bool isUpdate;

  const ReasonResultScreen({super.key, required this.reason, this.isUpdate = false});

  @override
  State<ReasonResultScreen> createState() => _ReasonResultScreenState();
}

class _ReasonResultScreenState extends State<ReasonResultScreen>
    with SingleTickerProviderStateMixin {
  int _selectedGoalIndex = 1; // Default to "Biasa (10 menit/hari)"

  List<Map<String, String>> dailyGoals(BuildContext context) => [
    {
      "name": context.t.goals.goalRelaxed,
      "time": context.t.goals.time5m,
      "desc": context.t.goals.descRelaxed,
      "badge": "🌟",
    },
    {
      "name": context.t.goals.goalRegular,
      "time": context.t.goals.time10m,
      "desc": context.t.goals.descRegular,
      "badge": "⚡",
    },
    {
      "name": context.t.goals.goalSerious,
      "time": context.t.goals.time15m,
      "desc": context.t.goals.descSerious,
      "badge": "🔥",
    },
    {
      "name": context.t.goals.goalIntense,
      "time": context.t.goals.time20m,
      "desc": context.t.goals.descIntense,
      "badge": "👑",
    },
  ];

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  String _getReasonLabel(BuildContext context, String id) {
    switch (id) {
      case "Sekolah":
        return "${context.t.goals.reasonSchool} 🏫";
      case "Hobi anime":
        return "${context.t.goals.reasonAnime} 📺";
      case "Kerja / kuliah":
        return "${context.t.goals.reasonWork} 💼";
      case "Travel Jepang":
        return "${context.t.goals.reasonTravel} ✈️";
      default:
        return "$id 🎉";
    }
  }

  @override
  Widget build(BuildContext context) {
    final goals = dailyGoals(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Top Progress Bar
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: 1.0,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.accentLight,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "2/2",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Header section
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.15),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: const Center(
                          child: Text("🎯", style: TextStyle(fontSize: 28)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        context.t.goals.title,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        context.t.goals.subtitle,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Main Content Card
                Expanded(
                  child: SlideTransition(
                    position: _slideAnim,
                    child: FadeTransition(
                      opacity: _fadeAnim,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Info Box
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGreen.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("💡", style: TextStyle(fontSize: 20)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12.5,
                                          color: AppColors.textPrimary,
                                          height: 1.5,
                                        ),
                                        children: [
                                          TextSpan(text: "${context.t.goals.greatChoice}\n"),
                                          TextSpan(
                                            text: _getReasonLabel(context, widget.reason),
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Subtitle
                            const Text(
                              'Berapa target belajar harianmu?',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Options List
                            Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: goals.length,
                                itemBuilder: (context, index) {
                                  final goal = goals[index];
                                  final isSelected = _selectedGoalIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedGoalIndex = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: isSelected ? AppColors.primaryGreen : Colors.grey.shade200,
                                          width: isSelected ? 1.5 : 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(goal["badge"]!, style: const TextStyle(fontSize: 24)),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  goal["name"]!,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: isSelected ? AppColors.primaryGreen : AppColors.textPrimary,
                                                  ),
                                                ),
                                                Text(
                                                  goal["desc"]!,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 10,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            goal["time"]!,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Continue Button
                FadeTransition(
                  opacity: _fadeAnim,
                  child: _ContinueButton(
                    label: context.t.goals.startLearning,
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('selected_reason', widget.reason);
                      await prefs.setInt('daily_goal_index', _selectedGoalIndex);
                      await prefs.setBool('has_completed_onboarding', true);
                      
                      if (widget.isUpdate) {
                        navigator.pop(); // returns to setting/profile
                        navigator.pop();
                      } else {
                        navigator.pushReplacement(
                          MaterialPageRoute(builder: (_) => const TataUtama()),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  const _ContinueButton({required this.label, required this.onPressed});

  @override
  State<_ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<_ContinueButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));
    _scale = Tween<double>(begin: 1, end: 0.97)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          widget.onPressed();
        },
        onTapCancel: () => _ctrl.reverse(),
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Center(
            child: Text(
              widget.label.toUpperCase(),
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
