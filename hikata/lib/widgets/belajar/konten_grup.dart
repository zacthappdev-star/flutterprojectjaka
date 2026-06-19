import 'package:flutter/material.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/models/model_karakter.dart';
import 'package:ppkd_b6/screen/kuis/layar_kuis.dart';
import 'package:ppkd_b6/services/layanan_pelafalan.dart';
import 'package:ppkd_b6/services/layanan_progres.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:ppkd_b6/widgets/belajar/layout_kartu_hafalan.dart';
import 'package:ppkd_b6/widgets/belajar/pemilih_mode_belajar.dart';
import 'package:ppkd_b6/widgets/huruf/kartu_huruf.dart';

class KontenGrup extends StatefulWidget {
  final CharacterGroup group;
  final Function(JapaneseCharacter) onCharTap;
  final int levelIndex;
  final String mode;
  final Color accentColor;
  final Color activeBgColor;
  final Color cardBgColor;
  final Color cardBorderColor;

  const KontenGrup({
    super.key,
    required this.group,
    required this.onCharTap,
    required this.levelIndex,
    required this.mode,
    required this.accentColor,
    required this.activeBgColor,
    required this.cardBgColor,
    required this.cardBorderColor,
  });

  @override
  State<KontenGrup> createState() => _KontenGrupState();
}

class _KontenGrupState extends State<KontenGrup> {
  bool _modeKartu = false;
  Set<String> _learnedChars = {};

  @override
  void initState() {
    super.initState();
    _loadLearnedChars();
  }

  Future<void> _loadLearnedChars() async {
    final chars = await ProgressService.getLearnedCharacters();
    if (mounted) {
      setState(() {
        _learnedChars = chars.toSet();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPemilihMode(),
        Divider(height: 1, thickness: 1, color: context.hiKata.divider),
        _buildStreakBanner(),
        Expanded(
          child: _modeKartu
              ? LayoutKartuHafalan(
                  group: widget.group,
                  accentColor: widget.accentColor,
                  cardBgColor: widget.cardBgColor,
                )
              : _buildGrid(),
        ),
      ],
    );
  }

  Widget _buildStreakBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryGreen.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          const Text('🔥', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.t.scriptGuide.awesome,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  context.t.scriptGuide.keepLearning,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFfbbf24), // Amber
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '+5 XP',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF78350f), // Dark brown
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPemilihMode() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PemilihModeBelajar(
            icon: Icons.grid_view_rounded,
            label: Translations.of(context).common.grid,
            isActive: !_modeKartu,
            accentColor: widget.accentColor,
            activeBgColor: widget.activeBgColor,
            onTap: () => setState(() => _modeKartu = false),
          ),
          const SizedBox(width: 10),
          PemilihModeBelajar(
            icon: Icons.style_rounded,
            label: Translations.of(context).common.flashcard,
            isActive: _modeKartu,
            accentColor: widget.accentColor,
            activeBgColor: widget.activeBgColor,
            onTap: () {
              setState(() => _modeKartu = true);
              PronunciationService.speak(
                widget.group.characters.first.character,
              );
            },
          ),
          const SizedBox(width: 10),
          PemilihModeBelajar(
            icon: Icons.quiz_rounded,
            label: Translations.of(context).common.quiz,
            isActive: false,
            accentColor: widget.accentColor,
            activeBgColor: widget.activeBgColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizScreen(
                    mode: widget.mode,
                    levelIndex: widget.levelIndex,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.78,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: widget.group.characters.length,
      itemBuilder: (ctx, i) {
        final c = widget.group.characters[i];
        final isLearned = _learnedChars.contains(c.character);
        return KartuHuruf(
          character: c,
          accentColor: widget.accentColor,
          backgroundColor: widget.cardBgColor,
          borderColor: widget.cardBorderColor,
          isLearned: isLearned,
          onTap: () async {
            PronunciationService.speak(c.character);
            await ProgressService.markCharacterAsLearned(c.character);
            _loadLearnedChars();
            widget.onCharTap(c);
          },
        );
      },
    );
  }
}
