import '../models/model_karakter.dart';
import 'data_hiragana.dart';
import 'data_katakana.dart';

class QuizQuestion {
  final String question; // "Apa bacaan huruf ini?"
  final String questionChar; // "あ"
  final List<String> options; // 4 pilihan romaji
  final int correctIndex; // Jawaban benar
  final String type; // 'Hiragana' ATAU 'Katakana'

  const QuizQuestion({
    required this.question,
    required this.questionChar,
    required this.options,
    required this.correctIndex,
    required this.type,
  });
}

class QuizData {
  static List<QuizQuestion> generateLevelQuiz({
    required String type,
    required int levelIndex,
  }) {
    final isHiragana = type.toLowerCase() == 'hiragana';
    final group = isHiragana
        ? HiraganaData.groups[levelIndex]
        : KatakanaData.groups[levelIndex];
    final selected = List<JapaneseCharacter>.from(group.characters)..shuffle();
    final pool = isHiragana
        ? HiraganaData.groups.expand((g) => g.characters).toList()
        : KatakanaData.groups.expand((g) => g.characters).toList();
    return _buildQuestions(selected, pool, type);
  }

  static List<QuizQuestion> generateHiraganaQuiz({int count = 10}) {
    final chars = HiraganaData.allBasicChars;
    chars.shuffle();
    final selected = chars.take(count).toList();
    return _buildQuestions(selected, chars, 'Hiragana');
  }

  static List<QuizQuestion> generateKatakanaQuiz({int count = 10}) {
    final chars = KatakanaData.allBasicChars;
    chars.shuffle();
    final selected = chars.take(count).toList();
    return _buildQuestions(selected, chars, 'Katakana');
  }

  static List<QuizQuestion> generateMixedQuiz({int count = 10}) {
    final hiragana = HiraganaData.allBasicChars;
    final katakana = KatakanaData.allBasicChars;
    final all = [...hiragana, ...katakana];
    all.shuffle();
    final selected = all.take(count).toList();
    return _buildQuestions(selected, all, 'Mixed');
  }

  static List<QuizQuestion> _buildQuestions(
    List<JapaneseCharacter> selected,
    List<JapaneseCharacter> pool,
    String type,
  ) {
    final List<QuizQuestion> questions = [];
    for (final char in selected) {
      // 3 wrong options from pool
      final wrongOptions = pool.where((c) => c.romaji != char.romaji).toList()
        ..shuffle();
      final wrongs = wrongOptions.take(3).map((c) => c.romaji).toList();

      // Combine and shuffle
      final allOptions = [...wrongs, char.romaji]..shuffle();
      final correctIdx = allOptions.indexOf(char.romaji);

      questions.add(
        QuizQuestion(
          question: type.toLowerCase() == 'hiragana'
              ? 'Apa bacaan huruf Hiragana ini?'
              : type.toLowerCase() == 'katakana'
              ? 'Apa bacaan huruf Katakana ini?'
              : 'Apa bacaan huruf ini?',
          questionChar: char.character,
          options: allOptions,
          correctIndex: correctIdx,
          type: type,
        ),
      );
    }
    return questions;
  }
}
