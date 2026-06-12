// lib/models/lesson_model.dart

class LessonLevel {
  final int id; // 1-based level id
  final String name;
  final String type; // 'Hiragana' ATAU 'Katakana'
  final List<String> characters;

  const LessonLevel({
    required this.id,
    required this.name,
    required this.type,
    required this.characters,
  });
}
