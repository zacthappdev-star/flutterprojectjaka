import '../models/model_karakter.dart';
import 'data_hiragana.dart';
import 'data_katakana.dart';

class QuizQuestion {
  final String questionChar; // "あ"
  final List<String> options; // 4 pilihan romaji
  final int correctIndex; // Jawaban benar
  final String type; // 'Hiragana' ATAU 'Katakana'

  const QuizQuestion({
    required this.questionChar,
    required this.options,
    required this.correctIndex,
    required this.type,
  });
}

class QuizData {
  static List<JapaneseCharacter> get allCharacters {
    return [...HiraganaData.allBasicChars, ...KatakanaData.allBasicChars];
  }

  static List<QuizQuestion> generateLevelQuiz({
    required String type,
    required int levelIndex,
    bool isListening = false,
  }) {
    final isHiragana = type.toLowerCase() == 'hiragana';
    final group = isHiragana
        ? HiraganaData.groups[levelIndex]
        : KatakanaData.groups[levelIndex];
    final selected = List<JapaneseCharacter>.from(group.characters)..shuffle();

    final pool = allCharacters
        .where((char) => char.type == type.toLowerCase())
        .toList();

    return _buildQuestions(selected, pool, type, isListening);
  }

  static List<QuizQuestion> _generateQuizHelper(String type, int count, bool isListening) {
    final filteredCharacters = type == 'Mixed'
        ? allCharacters
        : allCharacters.where((char) => char.type == type.toLowerCase()).toList();

    final shuffledChars = List<JapaneseCharacter>.from(filteredCharacters)..shuffle();
    final selected = shuffledChars.take(count).toList();
    return _buildQuestions(selected, filteredCharacters, type, isListening);
  }

  static List<QuizQuestion> generateHiraganaQuiz({
    int count = 10,
    bool isListening = false,
  }) {
    return _generateQuizHelper('Hiragana', count, isListening);
  }

  static List<QuizQuestion> generateKatakanaQuiz({
    int count = 10,
    bool isListening = false,
  }) {
    return _generateQuizHelper('Katakana', count, isListening);
  }

  static List<QuizQuestion> generateMixedQuiz({
    int count = 10,
    bool isListening = false,
  }) {
    return _generateQuizHelper('Mixed', count, isListening);
  }

  static List<QuizQuestion> _buildQuestions(
    List<JapaneseCharacter> selected,
    List<JapaneseCharacter> pool,
    String type,
    bool isListening,
  ) {
    final List<QuizQuestion> questions = [];
    for (final char in selected) {
      final wrongOptions = pool.where((c) => c.romaji != char.romaji).toList()
        ..shuffle();

      final wrongs = isListening
          ? wrongOptions.take(3).map((c) => c.character).toList()
          : wrongOptions.take(3).map((c) => c.romaji).toList();

      final correctOption = isListening ? char.character : char.romaji;

      final allOptions = [...wrongs, correctOption]..shuffle();
      final correctIdx = allOptions.indexOf(correctOption);

      questions.add(
        QuizQuestion(
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
