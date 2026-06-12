import 'package:flutter/material.dart';
import 'package:ppkd_b6/screen/pengenalan/pilih_bahasa.dart';
import 'package:ppkd_b6/screen/tata_utama.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReasonResultScreen extends StatefulWidget {
  final String reason;

  const ReasonResultScreen({super.key, required this.reason});

  @override
  State<ReasonResultScreen> createState() => _ReasonResultScreenState();
}

class _ReasonResultScreenState extends State<ReasonResultScreen>
    with SingleTickerProviderStateMixin {
  int _selectedGoalIndex = 1; // Default to "Biasa (10 menit/hari)"

  bool get _isID => AppLanguage.current == 'id';

  List<Map<String, String>> get dailyGoals => [
    {
      "name": _isID ? "Santai" : "Relaxed",
      "time": _isID ? "5 menit / hari" : "5 mins / day",
      "desc": _isID ? "Bagus untuk perkenalan awal" : "Good for initial intro",
      "badge": "🌟",
    },
    {
      "name": _isID ? "Biasa" : "Regular",
      "time": _isID ? "10 menit / hari" : "10 mins / day",
      "desc": _isID ? "Rekomendasi untuk pemula" : "Recommended for beginners",
      "badge": "⚡",
    },
    {
      "name": _isID ? "Serius" : "Serious",
      "time": _isID ? "15 menit / hari" : "15 mins / day",
      "desc": _isID ? "Progress belajar cepat" : "Fast learning progress",
      "badge": "🔥",
    },
    {
      "name": _isID ? "Intens" : "Intense",
      "time": _isID ? "20 menit / hari" : "20 mins / day",
      "desc": _isID
          ? "Tantangan belajar maksimal"
          : "Maximum learning challenge",
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
      duration: Duration(milliseconds: 800),
    );
    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _slideAnim = Tween<Offset>(
      begin: Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // Helper method to format reasons ID into human readable label if needed
  String _getReasonLabel(String id) {
    if (_isID) {
      switch (id) {
        case "Sekolah":
          return "Pendidikan & Sekolah 🏫";
        case "Hobi anime":
          return "Anime & Pop Culture 🍿";
        case "Kerja / kuliah":
          return "Karir & Pekerjaan 💼";
        case "Travel Jepang":
          return "Wisata & Travelling ✈️";
        default:
          return "$id 🎉";
      }
    } else {
      switch (id) {
        case "Sekolah":
          return "Education & School 🏫";
        case "Hobi anime":
          return "Anime & Pop Culture 🍿";
        case "Kerja / kuliah":
          return "Career & Work 💼";
        case "Travel Jepang":
          return "Tourism & Travelling ✈️";
        default:
          return "$id 🎉";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final goals = dailyGoals;
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
            Positioned(
              bottom: -50,
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

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
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
                              value: 1.0, // Step 2 of 2 (Full)
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
                    Spacer(flex: 2),
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
                            child: Center(
                              child: Text("🎯", style: TextStyle(fontSize: 28)),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _isID ? "Tujuan Belajarmu" : "Your Learning Goal",
                            style: AppTextStyles.appTitle.copyWith(
                              fontSize: 24,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _isID
                                ? "Mari tentukan target harian belajarmu!"
                                : "Let's set your daily learning target!",
                            style: AppTextStyles.appSubtitle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Spacer(flex: 3),

                    // Main goal selection card (Duolingo style)
                    SlideTransition(
                      position: _slideAnim,
                      child: FadeTransition(
                        opacity: _fadeAnim,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: AppDecorations.cardDecoration,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Reason banner
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.softMint.withValues(
                                    alpha: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.accent.withValues(
                                      alpha: 0.3,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text("💡", style: TextStyle(fontSize: 16)),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: AppColors.textPrimary,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: _isID
                                                  ? "Pilihan mantap! Kamu belajar untuk: "
                                                  : "Great choice! You are learning for: ",
                                            ),
                                            TextSpan(
                                              text: _getReasonLabel(
                                                widget.reason,
                                              ),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 18),

                              Text(
                                _isID
                                    ? "Berapa target belajar harianmu?"
                                    : "How much is your daily target?",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 10),

                              // Goal choices
                              Column(
                                children: List.generate(goals.length, (index) {
                                  final goal = goals[index];
                                  final isSelected =
                                      _selectedGoalIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedGoalIndex = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      margin: EdgeInsets.only(bottom: 8),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.softMint.withValues(
                                                alpha: 0.3,
                                              )
                                            : Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.secondaryGreen
                                              : Colors.grey.shade200,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            goal["badge"]!,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  goal["name"]!,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: isSelected
                                                        ? AppColors.textPrimary
                                                        : Colors.grey.shade700,
                                                  ),
                                                ),
                                                Text(
                                                  goal["desc"]!,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 10,
                                                    color: isSelected
                                                        ? AppColors.textPrimary
                                                              .withValues(
                                                                alpha: 0.7,
                                                              )
                                                        : Colors.grey.shade500,
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
                                              color: isSelected
                                                  ? AppColors.secondaryGreen
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spacer(flex: 3),
                    // "MULAI BELAJAR" button
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: _GradientButton(
                        label: _isID ? "MULAI BELAJAR" : "START LEARNING",
                        onPressed: () async {
                          final scaffoldMessenger = ScaffoldMessenger.of(
                            context,
                          );
                          final navigator = Navigator.of(context);
                          // Save to SharedPreferences
                          try {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString(
                              'daily_goal_name',
                              goals[_selectedGoalIndex]["name"]!,
                            );
                            await prefs.setString(
                              'daily_goal_time',
                              goals[_selectedGoalIndex]["time"]!,
                            );
                            await prefs.setString(
                              'study_reason',
                              widget.reason,
                            );
                          } catch (e) {
                            debugPrint("Error saving to SharedPreferences: $e");
                          }

                          // Success snackbar
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text(
                                _isID
                                    ? 'Target harian diatur ke: ${goals[_selectedGoalIndex]["name"]} (${goals[_selectedGoalIndex]["time"]})🔥'
                                    : 'Daily target set to: ${goals[_selectedGoalIndex]["name"]} (${goals[_selectedGoalIndex]["time"]})🔥',
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                              backgroundColor: AppColors.primaryGreen,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );

                          // Langsung ke MainLayout (Selamat Datang)
                          navigator.pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => TataUtama()),
                            (route) => false,
                          );
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

// ─── Reusable Gradient Button ──────────────────────────────────────────────────

class _GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _GradientButton({required this.label, required this.onPressed});

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
