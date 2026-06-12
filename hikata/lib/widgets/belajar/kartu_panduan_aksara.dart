import 'package:flutter/material.dart';
import 'package:ppkd_b6/data/data_panduan_aksara.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class KartuPanduanAksara extends StatefulWidget {
  final ScriptGuideItem item;
  final bool isID;
  const KartuPanduanAksara({super.key, required this.item, required this.isID});

  @override
  State<KartuPanduanAksara> createState() => _KartuPanduanAksaraState();
}

class _KartuPanduanAksaraState extends State<KartuPanduanAksara> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    final item = widget.item;
    final isID = widget.isID;

    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(18),
        decoration: AppDecorations.cardDecorationOf(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: item.accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: item.accentColor, size: 22),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isID ? item.titleID : item.titleEN,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: item.accentColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        isID ? item.summaryID : item.summaryEN,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: colors.textOnCardSubtitle,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: colors.textMuted,
                  size: 22,
                ),
              ],
            ),
            if (_expanded) ...[
              SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: colors.fieldFill,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: item.accentColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  item.exampleChars,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: item.accentColor,
                    letterSpacing: 4,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Text(
                isID ? item.bodyID : item.bodyEN,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: colors.textPrimary,
                  height: 1.6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
