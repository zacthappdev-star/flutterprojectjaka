// lib/models/flashcard_model.dart

class FlashcardModel {
  final String character;
  final String romaji;
  final String exampleWord; // e.g., "あめ"
  final String exampleRomaji; // e.g., "ame"
  final String exampleTranslation; // e.g., "Hujan" (ID) or "Rain" (EN)

  const FlashcardModel({
    required this.character,
    required this.romaji,
    required this.exampleWord,
    required this.exampleRomaji,
    required this.exampleTranslation,
  });
}
