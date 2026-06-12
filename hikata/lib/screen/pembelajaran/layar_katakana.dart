import 'package:flutter/material.dart';
import 'package:ppkd_b6/data/data_katakana.dart';
import 'package:ppkd_b6/models/model_karakter.dart';
import 'package:ppkd_b6/screen/kuis/layar_kuis.dart';
import 'package:ppkd_b6/screen/pengenalan/pilih_bahasa.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/belajar/konten_grup.dart';
import 'package:ppkd_b6/widgets/belajar/tampilan_level_terkunci.dart';
import 'package:ppkd_b6/widgets/belajar/tombol_kuis_level.dart';
import 'package:ppkd_b6/widgets/huruf/sheet_detail_huruf.dart';

class LayarKatakana extends StatefulWidget {
  final bool isTab;
  const LayarKatakana({super.key, this.isTab = false});

  @override
  State<LayarKatakana> createState() => _LayarKatakanaState();
}

class _LayarKatakanaState extends State<LayarKatakana>
    with TickerProviderStateMixin {
  Color get _accentColor => Theme.of(context).brightness == Brightness.dark
      ? Color(0xFF9FA8DA)
      : AppColors.katakanaBlue;

  LinearGradient get _backgroundGradient =>
      Theme.of(context).brightness == Brightness.dark
      ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF080D21), Color(0xFF10173D), Color(0xFF1B235A)],
          stops: [0.0, 0.5, 1.0],
        )
      : LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A237E), Color(0xFF283593), Color(0xFF3949AB)],
          stops: [0.0, 0.5, 1.0],
        );

  // ─── State Data ────────────────────────────────────────────────────────────
  late TabController _tabController;
  final _groups = KatakanaData.groups;
  int _unlockedLevels = 1;

  bool get _isID => AppLanguage.current == 'id';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _groups.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) setState(() {});
    });
    _loadUnlockedLevels();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadUnlockedLevels() async {
    final prog = await ProgressService.getProgress();
    if (mounted) {
      setState(() => _unlockedLevels = prog.unlockedKatakanaLevels);
    }
  }

  // ─── UI Utama ──────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(_groups.length, (index) {
                    if (index >= _unlockedLevels) {
                      return TampilanLevelTerkunci(
                        isID: _isID,
                        titleColor: _accentColor,
                      );
                    }
                    return _buildKontenLevel(_groups[index], index);
                  }),
                ),
              ),
              TombolKuisLevel(
                isID: _isID,
                isUnlocked: _tabController.index < _unlockedLevels,
                unlockedDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: Theme.of(context).brightness == Brightness.dark
                        ? [Color(0xFF283593), Color(0xFF3F51B5)]
                        : [Color(0xFF1A237E), Color(0xFF3949AB)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _accentColor.withValues(alpha: 0.4),
                      blurRadius: 15,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(
                        mode: 'Katakana',
                        levelIndex: _tabController.index,
                      ),
                    ),
                  ).then((_) => _loadUnlockedLevels());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Komponen Layar ────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          if (!widget.isTab) ...[
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
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isID ? 'Pengenalan Katakana' : 'Katakana Introduction',
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 36,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white54,
        tabAlignment: TabAlignment.start,
        tabs: _groups.map((g) => Tab(text: g.tabLabel)).toList(),
      ),
    );
  }

  Widget _buildKontenLevel(CharacterGroup group, int levelIndex) {
    final colors = context.hiKata;
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.tableCardBgKatakana, colors.fieldFill],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Text(
              group.groupName,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _accentColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: KontenGrup(
              group: group,
              isID: _isID,
              onCharTap: (c) => _showCharDetail(c),
              levelIndex: levelIndex,
              mode: 'Katakana',
              accentColor: _accentColor,
              activeBgColor: colors.tableCardBgKatakana,
              cardBgColor: colors.tableCardBgKatakana,
              cardBorderColor: colors.softMint,
            ),
          ),
        ],
      ),
    );
  }

  void _showCharDetail(JapaneseCharacter c) {
    final colors = context.hiKata;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      backgroundColor: colors.cardBackground,
      builder: (_) => SheetDetailHuruf(
        character: c,
        isID: _isID,
        accentColor: _accentColor,
        cardBgColor: colors.tableCardBgKatakana,
        cardBorderColor: colors.softMint,
      ),
    );
  }
}
