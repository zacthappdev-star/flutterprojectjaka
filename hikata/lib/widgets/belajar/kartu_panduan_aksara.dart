import 'package:flutter/material.dart';
import 'package:ppkd_b6/data/data_panduan_aksara.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/belajar/sheet_panduan_aksara.dart';
import 'package:provider/provider.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';

enum PanduanItemState { selesai, tersedia, terkunci }

class KartuPanduanAksara extends StatelessWidget {
  final int index;
  final ScriptGuideItem item;
  final PanduanItemState state;

  const KartuPanduanAksara({
    super.key,
    required this.index,
    required this.item,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelesai = state == PanduanItemState.selesai;
    final bool isTersedia = state == PanduanItemState.tersedia;
    final bool isTerkunci = state == PanduanItemState.terkunci;

    final Color bgColor = isSelesai ? const Color(0xFFf0f9f1) : Colors.white;
    final Color borderColor = isSelesai
        ? Color(0xFF1f7a35)
        : (isTersedia ? const Color(0xFFd1e8c8) : Colors.transparent);

    Widget content = Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: isSelesai ? 1.5 : 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: item.accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.accentColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  item.summary,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          _buildRightAction(),
        ],
      ),
    );

    if (isTerkunci) {
      return Opacity(opacity: 0.45, child: content);
    }
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => SheetPanduanAksara(item: item),
        ).then((_) {
          if (!context.mounted) return;
          if (state == PanduanItemState.tersedia) {
            context.read<ProfileProvider>().completeScriptGuide(index);
          }
        });
      },
      child: content,
    );
  }

  Widget _buildRightAction() {
    if (state == PanduanItemState.selesai) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Color(0xFF1f7a35),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, size: 14, color: Colors.white),
          ),
          SizedBox(height: 4),
          Text(
            "+20 XP",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1f7a35),
            ),
          ),
        ],
      );
    } else if (state == PanduanItemState.tersedia) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.primaryGreen,
            size: 24,
          ),
          SizedBox(height: 4),
          Text(
            "+20 XP",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      );
    } else {
      return Icon(
        Icons.lock_outline_rounded,
        color: AppColors.textMuted,
        size: 24,
      );
    }
  }
}
