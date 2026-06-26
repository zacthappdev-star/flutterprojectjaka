import 'package:flutter/material.dart';
import 'package:ppkd_b6/screen/tujuanbelajar.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class HomeReasonScreen extends StatefulWidget {
  const HomeReasonScreen({super.key});

  @override
  State<HomeReasonScreen> createState() => _HomeReasonScreenState();
}

class _HomeReasonScreenState extends State<HomeReasonScreen>
    with SingleTickerProviderStateMixin {
  String? selected;

  List<Map<String, dynamic>> reasons(BuildContext context) => [
    {
      "id": "Sekolah",
      "title": context.t.goals.reasonSchoolTitle,
      "desc": context.t.goals.reasonSchoolDesc,
      "icon": Icons.school_outlined,
    },
    {
      "id": "Hobi anime",
      "title": context.t.goals.reasonAnimeTitle,
      "desc": context.t.goals.reasonAnimeDesc,
      "icon": Icons.tv_rounded,
    },
    {
      "id": "Kerja / kuliah",
      "title": context.t.goals.reasonWorkTitle,
      "desc": context.t.goals.reasonWorkDesc,
      "icon": Icons.work_outline_rounded,
    },
    {
      "id": "Travel Jepang",
      "title": context.t.goals.reasonTravelTitle,
      "desc": context.t.goals.reasonTravelDesc,
      "icon": Icons.flight_takeoff_rounded,
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

  @override
  Widget build(BuildContext context) {
    final list = reasons(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          value: 0.5,
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
                      "1/2",
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

                // Title
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.t.goals.questionTitle,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        context.t.goals.questionSubtitle,
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

                // Options
                Expanded(
                  child: SlideTransition(
                    position: _slideAnim,
                    child: FadeTransition(
                      opacity: _fadeAnim,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final reason = list[index];
                          final isSelected = selected == reason["id"];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = reason["id"];
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? AppColors.primaryGreen : Colors.transparent,
                                  width: 2.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? AppColors.primaryGreen.withValues(alpha: 0.1)
                                          : Colors.grey.shade100,
                                    ),
                                    child: Icon(
                                      reason["icon"],
                                      color: isSelected ? AppColors.primaryGreen : Colors.grey.shade600,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reason["title"],
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          reason["desc"],
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 11,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Continue Button
                FadeTransition(
                  opacity: _fadeAnim,
                  child: _ContinueButton(
                    label: context.t.common.continueText,
                    onPressed: () {
                      if (selected != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReasonResultScreen(
                              reason: selected!,
                              isUpdate: false,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Pilih salah satu alasan dulu ya!',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
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
