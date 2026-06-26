import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: colors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // ── Header ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 14),
                    Text(
                      context.t.about.title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // ── Content ──
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(24, 32, 24, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // App identity card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isDark
                                  ? [Color(0xFF1E3A28), Color(0xFF243D2E)]
                                  : [Color(0xFFE8F5E9), Color(0xFFF1F8E9)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: AppColors.primaryGreen.withValues(
                                alpha: 0.2,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              // Logo
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  gradient: AppColors.buttonGradient,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryGreen.withValues(
                                        alpha: 0.4,
                                      ),
                                      blurRadius: 16,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/LogoHikata2.png',
                                    height: 55,
                                    width: 55,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'HI KATA',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: isDark
                                      ? colors.textPrimary
                                      : AppColors.textPrimary,
                                  letterSpacing: 2,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Teman Belajar Hiragana Dan Katakana',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: AppColors.primaryGreen,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        // Description removed
                        // Features list
                        _buildSectionTitle('Fitur Utama', isDark, colors),
                        SizedBox(height: 12),
                        _buildFeatureItem(
                          Icons.grid_view_rounded,
                          'Tabel Hiragana & Katakana',
                          isDark,
                          colors,
                        ),
                        _buildFeatureItem(
                          Icons.bolt_rounded,
                          'Latihan Cepat & Evaluasi',
                          isDark,
                          colors,
                        ),
                        _buildFeatureItem(
                          Icons.volume_up_rounded,
                          'Pelafalan Audio',
                          isDark,
                          colors,
                        ),
                        _buildFeatureItem(
                          Icons.quiz_rounded,
                          'Kuis Interaktif',
                          isDark,
                          colors,
                        ),
                        _buildFeatureItem(
                          Icons.bar_chart_rounded,
                          'Sistem Progres & Level',
                          isDark,
                          colors,
                        ),
                        SizedBox(height: 28),
                        // Version info
                        _buildSectionTitle(
                          'Informasi Aplikasi',
                          isDark,
                          colors,
                        ),
                        SizedBox(height: 12),
                        _buildInfoCard(context, isDark, colors),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark, HiKataColors colors) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.primaryGreen,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark ? colors.textPrimary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(
    IconData icon,
    String label,
    bool isDark,
    HiKataColors colors,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryGreen, size: 18),
          ),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: isDark ? colors.textPrimary : Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    bool isDark,
    HiKataColors colors,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? colors.fieldFill : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? colors.divider : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow(context.t.about.version, '1.0.0', isDark, colors),
          Divider(
            height: 20,
            color: isDark ? colors.divider : Colors.grey.shade200,
          ),
          _buildDetailRow(context.t.about.developer, 'zacth', isDark, colors),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    bool isDark,
    HiKataColors colors,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: isDark ? colors.textMuted : Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isDark ? colors.textPrimary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
