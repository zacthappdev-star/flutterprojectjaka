import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.t.about.title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(22),
                  decoration: AppDecorations.cardDecorationOf(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen.withValues(
                                alpha: 0.14,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.info_rounded,
                              color: AppColors.primaryGreen,
                              size: 28,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'HI KATA',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      Text(
                        context.t.about.description,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          height: 1.6,
                          color: colors.textPrimary,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20),
                      Divider(color: colors.divider, height: 1.2, thickness: 1),
                      SizedBox(height: 18),
                      _buildDetailRow(
                        label: context.t.about.version,
                        value: '1.0.0',
                        colors: colors,
                      ),
                      SizedBox(height: 12),
                      _buildDetailRow(
                        label: context.t.about.developer,
                        value: 'zacth',
                        colors: colors,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required HiKataColors colors,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colors.textMuted,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
