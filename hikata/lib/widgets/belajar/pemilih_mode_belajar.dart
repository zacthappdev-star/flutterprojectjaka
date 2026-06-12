import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class PemilihModeBelajar extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color accentColor;
  final Color activeBgColor;
  final VoidCallback onTap;

  const PemilihModeBelajar({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.accentColor,
    required this.activeBgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? activeBgColor : colors.fieldFill,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? accentColor : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? accentColor : colors.textMuted,
              size: 16,
            ),
            SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive ? accentColor : colors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
