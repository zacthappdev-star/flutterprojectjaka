import 'package:flutter/material.dart';
import 'package:ppkd_b6/data/data_panduan_aksara.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/belajar/kartu_panduan_aksara.dart';

class LayarPanduanAksara extends StatelessWidget {
  const LayarPanduanAksara({super.key});


  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: colors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 24),
                  itemCount: ScriptGuideData.items.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return KartuPanduanAksara(
                      item: ScriptGuideData.items[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Header Layar ────────────────────────────────────────────────────────────
  Widget _buildAppBar() {
    return Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 20, 8),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translations.of(context).common.japaneseScriptGuide,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
