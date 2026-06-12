import 'package:flutter/material.dart';
import 'package:ppkd_b6/models/mode_tema_aplikasi.dart';
import 'package:ppkd_b6/services/layanan_tema.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class PemilihModeTema extends StatelessWidget {
  final bool isID;

  const PemilihModeTema({super.key, required this.isID});

  Future<void> _onSelect(AppThemeMode mode) async {
    await ThemeService.setMode(mode);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;

    return ValueListenableBuilder(
      valueListenable: ThemeService.themeModeNotifier,
      builder: (context, _, child) {
        final selected = ThemeService.mode;
        return Row(
          children: AppThemeMode.values.map((mode) {
            final isActive = selected == mode;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: mode == AppThemeMode.light ? 6 : 0,
                  left: mode == AppThemeMode.dark ? 6 : 0,
                ),
                child: GestureDetector(
                  onTap: () => _onSelect(mode),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isActive ? colors.softMint : colors.fieldFill,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isActive
                            ? AppColors.primaryGreen
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _iconFor(mode),
                          color: isActive
                              ? AppColors.primaryGreen
                              : colors.textMuted,
                          size: 22,
                        ),
                        SizedBox(height: 4),
                        Text(
                          mode.label(isID),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isActive
                                ? colors.textPrimary
                                : colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  IconData _iconFor(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.light_mode_rounded;
      case AppThemeMode.dark:
        return Icons.dark_mode_rounded;
    }
  }
}
