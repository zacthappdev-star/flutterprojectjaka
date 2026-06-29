import 'package:flutter/material.dart';
import 'package:ppkd_b6/database/database_helper.dart';
import 'package:ppkd_b6/widgets/common/tombol_gradient.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

import 'masuk.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      final String name = nameController.text.trim();
      final String email = emailController.text.trim();
      final String password = passwordController.text;

      final int userId = await DatabaseHelper.instance.registerUser(
        name,
        email,
        password,
      );

      if (!mounted) return;

      if (userId == -1) {
        // Email already registered
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Translations.of(context).auth.messages.emailAlreadyExists,
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Translations.of(context).auth.messages.registerSuccess,
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: AppColors.primaryGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        // Give the success SnackBar a moment to be seen before replacing this
        // route (pushReplacement tears down this Scaffold's messenger).
        await Future.delayed(const Duration(milliseconds: 900));
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              top: -40,
              left: -40,
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
              bottom: -40,
              right: -40,
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
              top: 50,
              left: 20,
              child: Text(
                'い',
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white.withValues(alpha: 0.04),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    Spacer(flex: 2),
                    // Header section
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/LogoHikata2.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'HI KATA',
                            style: AppTextStyles.appTitle.copyWith(
                              fontSize: 30,
                              letterSpacing: 4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Spacer(flex: 3),

                    // Register Card (Highly compact to fit 4 fields + button on 1 screen)
                    SlideTransition(
                      position: _slideAnim,
                      child: FadeTransition(
                        opacity: _fadeAnim,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          decoration: AppDecorations.cardDecorationOf(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.buttonGradient,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    t.auth.register,
                                    style: AppTextStyles.cardTitle.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14),

                              // Form
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    // Name Field
                                    TextFormField(
                                      controller: nameController,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 13,
                                        color: Theme.of(context).brightness == Brightness.dark ? context.hiKata.textPrimary : Color(0xFF263238),
                                      ),
                                      decoration:
                                          AppDecorations.fieldDecoration(
                                            hint: t.auth.usernameHint,
                                            icon: Icons.person_outline,
                                          ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return t
                                              .auth
                                              .validation
                                              .usernameEmpty;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10),

                                    // Email Field
                                    TextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 13,
                                        color: Theme.of(context).brightness == Brightness.dark ? context.hiKata.textPrimary : Color(0xFF263238),
                                      ),
                                      decoration:
                                          AppDecorations.fieldDecoration(
                                            hint: t.auth.emailHint,
                                            icon: Icons.email_outlined,
                                          ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return t.auth.validation.emailEmpty;
                                        }
                                        if (!value.contains('@')) {
                                          return t.auth.validation.emailInvalid;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10),

                                    // Password Field
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: _obscurePassword,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 13,
                                        color: Theme.of(context).brightness == Brightness.dark ? context.hiKata.textPrimary : Color(0xFF263238),
                                      ),
                                      decoration: AppDecorations.fieldDecoration(
                                        hint: t.auth.passwordHint,
                                        icon: Icons.lock_outline,
                                        suffix: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          icon: Icon(
                                            _obscurePassword
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: AppColors.textMuted,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return t
                                              .auth
                                              .validation
                                              .passwordEmpty;
                                        }
                                        if (value.length < 6) {
                                          return t
                                              .auth
                                              .validation
                                              .passwordTooShort;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10),

                                    // Confirm Password Field
                                    TextFormField(
                                      controller: confirmPasswordController,
                                      obscureText: _obscureConfirm,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 13,
                                        color: Theme.of(context).brightness == Brightness.dark ? context.hiKata.textPrimary : Color(0xFF263238),
                                      ),
                                      decoration: AppDecorations.fieldDecoration(
                                        hint: t.auth.confirmPasswordHint,
                                        icon: Icons.lock_outline,
                                        suffix: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          icon: Icon(
                                            _obscureConfirm
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: AppColors.textMuted,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscureConfirm =
                                                  !_obscureConfirm;
                                            });
                                          },
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return t
                                              .auth
                                              .validation
                                              .passwordEmpty;
                                        }
                                        if (value != passwordController.text) {
                                          return t
                                              .auth
                                              .validation
                                              .passwordMismatch;
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 18),

                                    // Submit Button
                                    TombolGradient(
                                      label: t.auth.register.toUpperCase(),
                                      onPressed: register,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Spacer(flex: 3),

                    // Back to login link
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.auth.alreadyHaveAccount,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              t.auth.login,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accentLight,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.accentLight,
                              ),
                            ),
                          ),
                        ],
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

