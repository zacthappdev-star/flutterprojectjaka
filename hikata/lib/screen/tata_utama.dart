import 'package:flutter/material.dart';
import 'package:ppkd_b6/screen/kuis/dasbor_kuis.dart';
import 'package:ppkd_b6/screen/layar_beranda.dart';
import 'package:ppkd_b6/screen/layar_profil.dart';
import 'package:ppkd_b6/screen/layar_progres.dart';
import 'package:ppkd_b6/screen/pembelajaran/dasbor_belajar.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/gen/strings.g.dart';

class TataUtama extends StatefulWidget {
  const TataUtama({super.key});
  @override
  State<TataUtama> createState() => StateTataUtama();
  static StateTataUtama? of(BuildContext context) {
    return context.findAncestorStateOfType<StateTataUtama>();
  }
}

class StateTataUtama extends State<TataUtama> {
  int _currentIndex = 0;
  void setTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late final List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    _screens = [
      DasborBelajar(),
      LayarBeranda(),
      DasborKuis(),
      LayarProgres(),
      LayarProfil(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.hiKata;
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: setTab,
          type: BottomNavigationBarType.fixed,
          backgroundColor: colors.navBarBackground,
          selectedItemColor: colors.textPrimary,
          unselectedItemColor: colors.textMuted,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 11,
            color: colors.textPrimary,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 20),
              activeIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.softMint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.home_rounded,
                  size: 20,
                  color: AppColors.primaryGreen,
                ),
              ),
              label: Translations.of(context).common.navHome,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined, size: 20),
              activeIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.softMint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.menu_book_rounded,
                  size: 20,
                  color: AppColors.primaryGreen,
                ),
              ),
              label: Translations.of(context).common.navLearn,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz_outlined, size: 20),
              activeIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.navLencanaKuis,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.quiz_rounded,
                  size: 20,
                  color: Color(0xFFE65100),
                ),
              ),
              label: Translations.of(context).common.navQuiz,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined, size: 20),
              activeIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.navLencanaProgres,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.bar_chart_rounded,
                  size: 20,
                  color: Color(0xFF1A237E),
                ),
              ),
              label: Translations.of(context).common.navProgress,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded, size: 20),
              activeIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.softMint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: 20,
                  color: AppColors.primaryGreen,
                ),
              ),
              label: Translations.of(context).common.navProfile,
            ),
          ],
        ),
      ),
    );
  }
}
