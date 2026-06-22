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
  int _modeIndex = 0;
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
          child: _modeIndex == 0
              ? _buildGrid()
              : _modeIndex == 1
                  ? LayoutKartuHafalan(
                      group: widget.group,
                      accentColor: widget.accentColor,
                      cardBgColor: widget.cardBgColor,
                    )
                  : _buildQuizIntro(),
        ),
      ],
    );
  }

  Widget _buildStreakBanner() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.hiKata;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? colors.cardBackground : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? colors.divider : AppColors.primaryGreen.withValues(alpha: 0.3),
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
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? colors.textPrimary : AppColors.textPrimary,
                  ),
                ),
                Text(
                  context.t.scriptGuide.keepLearning,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: isDark ? colors.textMuted : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF4A3E1B) : const Color(0xFFfbbf24), // Amber
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
            isActive: _modeIndex == 0,
            accentColor: widget.accentColor,
            activeBgColor: widget.activeBgColor,
            onTap: () => setState(() => _modeIndex = 0),
          ),
          const SizedBox(width: 10),
          PemilihModeBelajar(
            icon: Icons.style_rounded,
            label: Translations.of(context).common.flashcard,
            isActive: _modeIndex == 1,
            accentColor: widget.accentColor,
            activeBgColor: widget.activeBgColor,
            onTap: () {
              setState(() => _modeIndex = 1);
              PronunciationService.speak(
                widget.group.characters.first.character,
              );
            },
          ),
          const SizedBox(width: 10),
          PemilihModeBelajar(
            icon: Icons.quiz_rounded,
            label: Translations.of(context).common.quiz,
            isActive: _modeIndex == 2,
            accentColor: widget.accentColor,
            activeBgColor: widget.activeBgColor,
            onTap: () => setState(() => _modeIndex = 2),
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

  Widget _buildQuizIntro() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final totalChars = widget.group.characters.length;
    final learnedCount = widget.group.characters.where((c) => _learnedChars.contains(c.character)).length;
    final progress = totalChars > 0 ? learnedCount / totalChars : 0.0;
    final bool isReady = progress >= 1.0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isReady ? Icons.check_circle_outline_rounded : Icons.lock_outline_rounded,
              size: 64,
              color: isReady ? widget.accentColor : Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              isReady ? "Materi Selesai!" : "Materi Belum Selesai",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isReady 
                  ? "Anda sudah siap untuk menguji kemampuan di level ini." 
                  : "Pelajari semua huruf di tabel atau flashcard ($learnedCount/$totalChars) untuk membuka kuis.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isReady ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(
                        mode: widget.mode,
                        levelIndex: widget.levelIndex,
                      ),
                    ),
                  );
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.accentColor,
                  disabledBackgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: isReady ? 4 : 0,
                ),
                child: Text(
                  context.t.home.startPractice,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isReady ? Colors.white : Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
