import 'package:flutter/material.dart';
import 'package:ppkd_b6/data/data_hiragana.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/models/model_karakter.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/belajar/konten_grup.dart';
import 'package:ppkd_b6/widgets/belajar/tampilan_level_terkunci.dart';
import 'package:ppkd_b6/widgets/huruf/sheet_detail_huruf.dart';

class LayarHiragana extends StatefulWidget {
  final bool isTab;
  const LayarHiragana({super.key, this.isTab = false});

  @override
  State<LayarHiragana> createState() => _LayarHiraganaState();
}

class _LayarHiraganaState extends State<LayarHiragana>
    with TickerProviderStateMixin {
  // ─── State Data ────────────────────────────────────────────────────────────
  late TabController _tabController;
  final _groups = HiraganaData.groups;
  int _unlockedLevels = 1;

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
      setState(() => _unlockedLevels = prog.unlockedHiraganaLevels);
    }
  }

  // ─── UI Utama ──────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: context.hiKata.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(_groups.length, (index) {
                    final isUnlocked = index < _unlockedLevels;
                    if (!isUnlocked) {
                      return TampilanLevelTerkunci(
                        title: context.t.hiragana.locked,
                        desc: context.t.hiragana.lockedDesc,
                      );
                    }
                    return _buildKontenLevel(_groups[index], index);
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Komponen Layar ────────────────────────────────────────────────────────
  Widget _buildHeader() {
    final progress = _groups.isNotEmpty
        ? (_unlockedLevels / _groups.length).clamp(0.0, 1.0)
        : 0.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        children: [
          Row(
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
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  context.t.hiragana.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                ),
                child: const Text(
                  "+10 XP",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
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
            color: Colors.black.withValues(alpha: 0.1),
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
                colors: [
                  AppColors.primaryGreen.withValues(alpha: 0.1),
                  AppColors.secondaryGreen.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Text(
              group.groupName,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryGreen,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: KontenGrup(
              group: group,
              onCharTap: (c) => _showCharDetail(c),
              levelIndex: levelIndex,
              mode: 'hiragana',
              accentColor: AppColors.primaryGreen,
              activeBgColor: colors.softMint,
              cardBgColor: colors.lightBackground,
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
        accentColor: AppColors.primaryGreen,
        cardBgColor: colors.lightBackground,
        cardBorderColor: colors.softMint,
      ),
    );
  }
}
