import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

import 'masuk.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _emailSent = false;
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
    emailController.dispose();
    super.dispose();
  }

  void sendReset() {
    if (formKey.currentState!.validate()) {
      setState(() => _emailSent = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Translations.of(context).auth.messages.resetEmailSent,
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: AppColors.primaryGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
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
            Positioned(
              top: -40,
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
              bottom: -40,
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
              top: 50,
              left: 20,
              child: Text(
                'う',
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white.withValues(alpha: 0.04),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    Spacer(flex: 2),
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Column(
                        children: [
                          Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.15),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 2,
                              ),
                            ),
                            child: Image.asset(
                              'assets/images/Hikatanotext.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _emailSent ? 'Email Terkirim!' : t.auth.resetPasswordTitle,
                            style: AppTextStyles.appTitle.copyWith(
                              fontSize: 28,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(flex: 3),
                    SlideTransition(
                      position: _slideAnim,
                      child: FadeTransition(
                        opacity: _fadeAnim,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          decoration: AppDecorations.cardDecoration,
                          child: _emailSent
                              ? _buildSuccessContent()
                              : _buildFormContent(),
                        ),
                      ),
                    ),
                    Spacer(flex: 3),
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 12,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            SizedBox(width: 4),
                            Text(
                              t.common.back,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildFormContent() {
    return Form(
      key: formKey,
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
                Translations.of(context).auth.forgotPassword,
                style: AppTextStyles.cardTitle.copyWith(fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.softMint.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primaryGreen,
                  size: 18,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    Translations.of(context).auth.resetPasswordIntro,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: Color(0xFF263238),
            ),
            decoration: AppDecorations.fieldDecoration(
              hint: Translations.of(context).auth.emailHint,
              icon: Icons.email_outlined,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return Translations.of(context).auth.validation.emailEmpty;
              }
              if (!value.contains('@')) {
                return Translations.of(context).auth.validation.emailInvalid;
              }
              return null;
            },
          ),
          SizedBox(height: 18),
          _GradientButton(label: Translations.of(context).auth.sendEmail, onPressed: sendReset),
        ],
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.softMint,
          ),
          child: Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.primaryGreen,
            size: 30,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Berhasil!',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Email reset password telah dikirim ke:\n${emailController.text}',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: AppColors.textMuted,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 14),
        _buildStep('1', 'Buka email kamu', Icons.email_outlined),
        SizedBox(height: 6),
        _buildStep('2', 'Klik link reset password', Icons.link_rounded),
        SizedBox(height: 6),
        _buildStep('3', 'Buat password baru', Icons.lock_outline_rounded),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            setState(() => _emailSent = false);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.secondaryGreen, width: 1.5),
            ),
            child: Text(
              'Kirim ulang email',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryGreen,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep(String number, String label, IconData icon) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.buttonGradient,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Icon(icon, color: AppColors.secondaryGreen, size: 16),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Color(0xFF37474F),
          ),
        ),
      ],
    );
  }
}

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
          height: 44,
          decoration: AppDecorations.gradientButton,
          child: Center(
            child: Text(widget.label, style: AppTextStyles.buttonText),
          ),
        ),
      ),
    );
  }
}
