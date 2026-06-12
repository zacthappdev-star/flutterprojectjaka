import 'package:flutter/material.dart';
import 'package:ppkd_b6/data/data_hiragana.dart';
import 'package:ppkd_b6/data/data_katakana.dart';
import 'package:ppkd_b6/screen/pengenalan/pilih_bahasa.dart';
import 'package:ppkd_b6/screen/tata_utama.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/huruf/tabel_aksara_lengkap.dart';

class TableIntroScreen extends StatefulWidget {
  const TableIntroScreen({super.key});

  @override
  State<TableIntroScreen> createState() => _TableIntroScreenState();
}

class _TableIntroScreenState extends State<TableIntroScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool get _isID => AppLanguage.current == 'id';

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
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      TabelAksaraLengkap(
                        groups: HiraganaData.tableGroups,
                        isHiragana: true,
                        isID: _isID,
                      ),
                      TabelAksaraLengkap(
                        groups: KatakanaData.tableGroups,
                        isHiragana: false,
                        isID: _isID,
                      ),
                    ],
                  ),
                ),
              ),
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        children: [
          Row(
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
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  _isID ? 'Tabel Pengenalan Huruf' : 'Alphabet Intro Tables',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 50),
              child: Text(
                _isID
                    ? 'Ketuk huruf untuk mendengarkan pelafalan suaranya 🔊'
                    : 'Tap characters to hear their voice pronunciation 🔊',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 44,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: Colors.white70,
        dividerColor: Colors.transparent,
        tabs: [
          Tab(text: 'Hiragana'),
          Tab(text: 'Katakana'),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: GestureDetector(
        onTap: () {
          // Go to MainLayout (clears stack)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => TataUtama()),
            (route) => false,
          );
        },
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: AppDecorations.gradientButton.copyWith(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isID ? 'MULAI MODUL BELAJAR' : 'START STUDY MODULES',
                style: AppTextStyles.buttonText.copyWith(fontSize: 14),
              ),
              SizedBox(width: 8),
              Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
