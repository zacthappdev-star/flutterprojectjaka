import 'package:ppkd_b6/gen/strings.g.dart';

class JapaneseCharacter {
  final String character;
  final String romaji;
  final String? mnemonicID;
  final String? mnemonicEN;
  final String? audioPath;

  const JapaneseCharacter({
    required this.character,
    required this.romaji,
    this.mnemonicID,
    this.mnemonicEN,
    this.audioPath,
  });

  String get effectiveAudioPath {
    if (audioPath != null) return audioPath!;
    final isKatakana =
        character.codeUnitAt(0) >= 0x30A0 && character.codeUnitAt(0) <= 0x30FF;
    final folder = isKatakana ? 'Katakana' : 'Hiragana';
    return 'audio/$folder/${romaji.toLowerCase()}.mp3';
  }

  String? get mnemonic =>
      LocaleSettings.currentLocale == AppLocale.id ? mnemonicID : mnemonicEN;
}

class CharacterGroup {
  final String groupName;
  final List<JapaneseCharacter> characters;
  CharacterGroup({required this.groupName, required this.characters});
  String get tabLabel {
    if (groupName.contains('Youon')) {
      return 'Youon';
    }

    return characters.first.character;
  }
}
