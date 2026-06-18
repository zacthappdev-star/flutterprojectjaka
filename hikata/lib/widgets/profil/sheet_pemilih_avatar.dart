import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class SheetPemilihAvatar extends StatelessWidget {
  final String avatarSaatIni;
  final List<String> daftarAvatar;
  final ValueChanged<String> onPilih;
  const SheetPemilihAvatar({
    super.key,
    required this.avatarSaatIni,
    required this.daftarAvatar,
    required this.onPilih,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colors.divider,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 20),
          Text(
            Translations.of(context).profile.chooseAvatar,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: daftarAvatar.map((av) {
              final isSelected = av == avatarSaatIni;
              return GestureDetector(
                onTap: () => onPilih(av),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isSelected ? colors.softMint : colors.fieldFill,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryGreen
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(av, style: TextStyle(fontSize: 28)),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
