import 'package:flutter/material.dart';
import 'package:ppkd_b6/data/data_hiragana.dart';
import 'package:ppkd_b6/data/data_katakana.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/belajar/kartu_modul_belajar.dart';
import 'package:ppkd_b6/widgets/belajar/kartu_panduan_huruf.dart';

import '../pengenalan/pilih_bahasa.dart';
import 'layar_hiragana.dart';
import 'layar_katakana.dart';
import 'layar_panduan_aksara.dart';

class DasborBelajar extends StatefulWidget {
  const DasborBelajar({super.key});

  @override
  State<DasborBelajar> createState() => _DasborBelajarState();
}

class _DasborBelajarState extends State<DasborBelajar> {
  // ─── State Data ────────────────────────────────────────────────────────────
  int _unlockedHiragana = 1;
  int _unlockedKatakana = 1;
  double _hiraganaProgress = 0.0;
  double _katakanaProgress = 0.0;
  bool _isLoading = true;

  bool get _isID => AppLanguage.current == 'id';

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prog = await ProgressService.getProgress();
    if (mounted) {
      setState(() {
        _unlockedHiragana = prog.unlockedHiraganaLevels;
        _unlockedKatakana = prog.unlockedKatakanaLevels;
        _hiraganaProgress = prog.progressHiragana;
        _katakanaProgress = prog.progressKatakana;
        _isLoading = false;
      });
    }
  }

  // ─── UI Utama ──────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryGreen),
        ),
      );
    }

    final colors = context.hiKata;
    final hiraganaLevels = HiraganaData.groups.length;
    final katakanaLevels = KatakanaData.groups.length;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: colors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 12),
                KartuPanduanHuruf(
                  isID: _isID,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LayarPanduanAksara()),
                  ),
                ),
                KartuModulBelajar(
                  title: 'Hiragana',
                  subtitle: _isID
                      ? 'Level $_unlockedHiragana dari $hiraganaLevels Terbuka'
                      : 'Level $_unlockedHiragana of $hiraganaLevels Unlocked',
                  badgeText: 'あ',
                  progressText: '${(_hiraganaProgress * 100).toInt()}%',
                  progressPercent: _hiraganaProgress,
                  accentColor: AppColors.primaryGreen,
                  badgeBg: colors.lightBackground,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LayarHiragana()),
                    ).then((_) => _loadProgress());
                  },
                ),
                KartuModulBelajar(
                  title: 'Katakana',
                  subtitle: _isID
                      ? 'Level $_unlockedKatakana dari $katakanaLevels Terbuka'
                      : 'Level $_unlockedKatakana of $katakanaLevels Unlocked',
                  badgeText: 'ア',
                  progressText: '${(_katakanaProgress * 100).toInt()}%',
                  progressPercent: _katakanaProgress,
                  accentColor: Color.fromARGB(223, 158, 175, 0),
                  badgeBg: colors.tableCardBgKatakana,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LayarKatakana()),
                    ).then((_) => _loadProgress());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Komponen Header ───────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.15),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Image.asset('assets/images/leaves.png', fit: BoxFit.contain),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isID
                    ? 'Selamat Datang di HI KATA! 🥳'
                    : 'Welcome to HI KATA! 🥳',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
