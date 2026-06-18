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

  // Structuring reasons with labels, descriptions and custom icons
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
      duration: Duration(milliseconds: 800),
    );
    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _slideAnim = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
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
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.04),
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              right: -50,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.04),
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Onboarding progress bar (Duolingo style)
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: 0.5, // Step 1 of 2
                              backgroundColor: Colors.white24,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.accentLight,
                              ),
                              minHeight: 8,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
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

                    Spacer(flex: 1),

                    // Onboarding Title
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.t.goals.questionTitle,
                            style: AppTextStyles.appTitle.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            context.t.goals.questionSubtitle,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Spacer(flex: 2),

                    // Custom choice list (Compact & Clean)
                    SlideTransition(
                      position: _slideAnim,
                      child: FadeTransition(
                        opacity: _fadeAnim,
                        child: Column(
                          children: list.map((reason) {
                            final isSelected = selected == reason["id"];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = reason["id"];
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.softMint.withValues(
                                          alpha: 0.95,
                                        )
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primaryGreen
                                        : Colors.white,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isSelected
                                          ? AppColors.primaryGreen.withValues(
                                              alpha: 0.15,
                                            )
                                          : Colors.black.withValues(
                                              alpha: 0.04,
                                            ),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // Custom circle icon container
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? AppColors.primaryGreen.withValues(
                                                alpha: 0.15,
                                              )
                                            : Colors.grey.shade100,
                                      ),
                                      child: Icon(
                                        reason["icon"],
                                        color: isSelected
                                            ? AppColors.primaryGreen
                                            : Colors.grey.shade600,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            reason["title"],
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: isSelected
                                                  ? AppColors.textPrimary
                                                  : Colors.grey.shade800,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            reason["desc"],
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 11,
                                              color: isSelected
                                                  ? AppColors.textPrimary
                                                        .withValues(alpha: 0.7)
                                                  : Colors.grey.shade500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check_circle_rounded,
                                        color: AppColors.primaryGreen,
                                        size: 22,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    Spacer(flex: 3),

                    // "LANJUT" Button
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: _GradientButton(
                        label: context.t.goals.continueBtn,
                        enabled: selected != null,
                        onPressed: () {
                          if (selected != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ReasonResultScreen(reason: selected!),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Custom Gradient Button with Enabled/Disabled State ───────────────────────

class _GradientButton extends StatefulWidget {
  final String label;
  final bool enabled;
  final VoidCallback onPressed;

  const _GradientButton({
    required this.label,
    required this.enabled,
    required this.onPressed,
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(
      begin: 1,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white54,
            ),
          ),
        ),
      );
    }

    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          widget.onPressed();
        },
        onTapCancel: () => _ctrl.reverse(),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: AppDecorations.gradientButton.copyWith(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: AppTextStyles.buttonText.copyWith(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
