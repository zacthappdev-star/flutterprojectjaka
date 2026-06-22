import '../models/model_karakter.dart';

class HiraganaData {
  static List<CharacterGroup> groups = [
    CharacterGroup(
      groupName: 'A-I-U-E-O',
      characters: [
        JapaneseCharacter(
          character: 'あ',
          romaji: 'a',
          type: 'hiragana',
          mnemonicID: 'Seperti huruf "A" berdiri',
          mnemonicEN: 'Looks like a person saying "Ah"',
        ),
        JapaneseCharacter(
          character: 'い',
          romaji: 'i',
          type: 'hiragana',
          mnemonicID: 'Seperti dua garis tegak "i"',
          mnemonicEN: 'Two sticks like "ee"',
        ),
        JapaneseCharacter(
          character: 'う',
          romaji: 'u',
          type: 'hiragana',
          mnemonicID: 'Seperti bibir yang membulat mengucap "u"',
          mnemonicEN: 'Lips rounded saying "oo"',
        ),
        JapaneseCharacter(
          character: 'え',
          romaji: 'e',
          type: 'hiragana',
          mnemonicID: 'Seperti orang membawa tongkat',
          mnemonicEN: 'Person carrying a stick',
        ),
        JapaneseCharacter(
          character: 'お',
          romaji: 'o',
          type: 'hiragana',
          mnemonicID: 'Seperti huruf O dengan topi',
          mnemonicEN: 'An O with a hat',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'KA-KI-KU-KE-KO',
      characters: [
        JapaneseCharacter(
          character: 'か',
          romaji: 'ka',
          type: 'hiragana',
          mnemonicID: 'Seperti tongkat dan sabit',
          mnemonicEN: 'A stick with a sickle',
        ),
        JapaneseCharacter(
          character: 'き',
          romaji: 'ki',
          type: 'hiragana',
          mnemonicID: 'Seperti kunci (key)',
          mnemonicEN: 'Looks like a KEY',
        ),
        JapaneseCharacter(
          character: 'く',
          romaji: 'ku',
          type: 'hiragana',
          mnemonicID: 'Seperti paruh burung kukuk',
          mnemonicEN: 'Beak of a cuckoo bird',
        ),
        JapaneseCharacter(
          character: 'け',
          romaji: 'ke',
          type: 'hiragana',
          mnemonicID: 'Seperti tiang dan tanda centang',
          mnemonicEN: 'A post with a check mark',
        ),
        JapaneseCharacter(
          character: 'こ',
          romaji: 'ko',
          type: 'hiragana',
          mnemonicID: 'Dua garis seperti "co" yang sederhana',
          mnemonicEN: 'Two lines like "co"',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'SA-SI-SU-SE-SO',
      characters: [
        JapaneseCharacter(
          character: 'さ',
          romaji: 'sa',
          type: 'hiragana',
          mnemonicID: 'Seperti huruf "s" dengan ekor',
          mnemonicEN: 'An "s" with a tail',
        ),
        JapaneseCharacter(
          character: 'し',
          romaji: 'shi',
          type: 'hiragana',
          mnemonicID: 'Seperti kail pancing',
          mnemonicEN: 'A fishing hook',
        ),
        JapaneseCharacter(
          character: 'す',
          romaji: 'su',
          type: 'hiragana',
          mnemonicID: 'Seperti sapu (su=sapu)',
          mnemonicEN: 'A broom handle',
        ),
        JapaneseCharacter(
          character: 'せ',
          romaji: 'se',
          type: 'hiragana',
          mnemonicID: 'Seperti se-buah kursi',
          mnemonicEN: 'Looks like a chair',
        ),
        JapaneseCharacter(
          character: 'そ',
          romaji: 'so',
          type: 'hiragana',
          mnemonicID: 'Seperti angka 3 miring',
          mnemonicEN: 'A curved 3',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'TA-TI-TU-TE-TO',
      characters: [
        JapaneseCharacter(
          character: 'た',
          romaji: 'ta',
          type: 'hiragana',
          mnemonicID: 'Seperti huruf t dengan hiasan',
          mnemonicEN: 'A decorated letter t',
        ),
        JapaneseCharacter(
          character: 'ち',
          romaji: 'chi',
          type: 'hiragana',
          mnemonicID: 'Seperti angka 5',
          mnemonicEN: 'Looks like the number 5',
        ),
        JapaneseCharacter(
          character: 'つ',
          romaji: 'tsu',
          type: 'hiragana',
          mnemonicID: 'Seperti ombak kecil (tsunami!)',
          mnemonicEN: 'A small wave (tsunami!)',
        ),
        JapaneseCharacter(
          character: 'て',
          romaji: 'te',
          type: 'hiragana',
          mnemonicID: 'Seperti antena TV',
          mnemonicEN: 'A TV antenna',
        ),
        JapaneseCharacter(
          character: 'と',
          romaji: 'to',
          type: 'hiragana',
          mnemonicID: 'Seperti jari kaki (toe)',
          mnemonicEN: 'A TOE',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'NA-NI-NU-NE-NO ',
      characters: [
        JapaneseCharacter(
          character: 'な',
          romaji: 'na',
          type: 'hiragana',
          mnemonicID: 'Seperti tulisan "na" yang rapi',
          mnemonicEN: 'Looks like cursive "na"',
        ),
        JapaneseCharacter(
          character: 'に',
          romaji: 'ni',
          type: 'hiragana',
          mnemonicID: 'Dua garis dan titik: "2" di Jepang',
          mnemonicEN: 'Two sticks and a dot',
        ),
        JapaneseCharacter(
          character: 'ぬ',
          romaji: 'nu',
          type: 'hiragana',
          mnemonicID: 'Seperti mangkuk mie ',
          mnemonicEN: 'A bowl of noodles',
        ),
        JapaneseCharacter(
          character: 'ね',
          romaji: 'ne',
          type: 'hiragana',
          mnemonicID: 'Seperti kucing tidur',
          mnemonicEN: 'A sleeping cat',
        ),
        JapaneseCharacter(
          character: 'の',
          romaji: 'no',
          type: 'hiragana',
          mnemonicID: 'Seperti huruf "no" melingkar',
          mnemonicEN: 'A spiral NO',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'HA-HI-HU-HE-HO ',
      characters: [
        JapaneseCharacter(
          character: 'は',
          romaji: 'ha',
          type: 'hiragana',
          mnemonicID: 'Seperti atap rumah di Jepang',
          mnemonicEN: 'A Japanese house roof',
        ),
        JapaneseCharacter(
          character: 'ひ',
          romaji: 'hi',
          type: 'hiragana',
          mnemonicID: 'Seperti senyuman (he-he!)',
          mnemonicEN: 'A smiling face (hee-hee)',
        ),
        JapaneseCharacter(
          character: 'ふ',
          romaji: 'fu',
          type: 'hiragana',
          mnemonicID: 'Seperti gunung Fuji (fu=Fuji)',
          mnemonicEN: 'Mount FUji',
        ),
        JapaneseCharacter(
          character: 'へ',
          romaji: 'he',
          type: 'hiragana',
          mnemonicID: 'Seperti bentuk tenda/gunung kecil',
          mnemonicEN: 'A small mountain tent',
        ),
        JapaneseCharacter(
          character: 'ほ',
          romaji: 'ho',
          type: 'hiragana',
          mnemonicID: 'Seperti lumbung Ho-ho-ho',
          mnemonicEN: 'Santa saying HO HO',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'MA-MI-MU-ME-MO ',
      characters: [
        JapaneseCharacter(
          character: 'ま',
          romaji: 'ma',
          type: 'hiragana',
          mnemonicID: 'Seperti mama duduk',
          mnemonicEN: 'A MAMA sitting down',
        ),
        JapaneseCharacter(
          character: 'み',
          romaji: 'mi',
          type: 'hiragana',
          mnemonicID: 'Seperti kail dengan ekor (me)',
          mnemonicEN: 'A hook with a tail',
        ),
        JapaneseCharacter(
          character: 'む',
          romaji: 'mu',
          type: 'hiragana',
          mnemonicID: 'Seperti sapi melirik (mu=moo)',
          mnemonicEN: 'A cow saying MOO',
        ),
        JapaneseCharacter(
          character: 'め',
          romaji: 'me',
          type: 'hiragana',
          mnemonicID: 'Seperti mata (me = mata dalam Jepang)',
          mnemonicEN: 'Meye (me = eye in Japanese)',
        ),
        JapaneseCharacter(
          character: 'も',
          romaji: 'mo',
          type: 'hiragana',
          mnemonicID: 'Seperti kail pancing dengan ikan',
          mnemonicEN: 'A fishing hook with a catch',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'YA-YU-YO ',
      characters: [
        JapaneseCharacter(
          character: 'や',
          romaji: 'ya',
          type: 'hiragana',
          mnemonicID: 'Seperti seorang yang berteriak "ya!"',
          mnemonicEN: 'Someone shouting "YA!"',
        ),
        JapaneseCharacter(
          character: 'ゆ',
          romaji: 'yu',
          type: 'hiragana',
          mnemonicID: 'Seperti ikan berenang',
          mnemonicEN: 'A swimming fish',
        ),
        JapaneseCharacter(
          character: 'よ',
          romaji: 'yo',
          type: 'hiragana',
          mnemonicID: 'Seperti angka 3 dengan ekor',
          mnemonicEN: 'A 3 with a tail',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'RA-RI-RU-RE-RO ',
      characters: [
        JapaneseCharacter(
          character: 'ら',
          romaji: 'ra',
          type: 'hiragana',
          mnemonicID: 'Seperti orang duduk santai',
          mnemonicEN: 'A relaxing person',
        ),
        JapaneseCharacter(
          character: 'り',
          romaji: 'ri',
          type: 'hiragana',
          mnemonicID: 'Dua garis melengkung seperti "ree"',
          mnemonicEN: 'Two curved lines',
        ),
        JapaneseCharacter(
          character: 'る',
          romaji: 'ru',
          type: 'hiragana',
          mnemonicID: 'Seperti angka 9 (loop)',
          mnemonicEN: 'A looping number 9',
        ),
        JapaneseCharacter(
          character: 'れ',
          romaji: 're',
          type: 'hiragana',
          mnemonicID: 'Seperti putri rambut panjang',
          mnemonicEN: 'A princess with long hair',
        ),
        JapaneseCharacter(
          character: 'ろ',
          romaji: 'ro',
          type: 'hiragana',
          mnemonicID: 'Seperti angka 3 tanpa ujung',
          mnemonicEN: 'A 3 without the end',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'WA-WO-N',
      characters: [
        JapaneseCharacter(
          character: 'わ',
          romaji: 'wa',
          type: 'hiragana',
          mnemonicID: 'Seperti orang berteriak "wah!"',
          mnemonicEN: 'A person saying WAH!',
        ),
        JapaneseCharacter(
          character: 'を',
          romaji: 'wo',
          type: 'hiragana',
          mnemonicID: 'Seperti orang duduk bersila',
          mnemonicEN: 'A person sitting cross-legged',
        ),
        JapaneseCharacter(
          character: 'ん',
          romaji: 'n',
          type: 'hiragana',
          mnemonicID: 'Seperti huruf n miring',
          mnemonicEN: 'A slanted letter n',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'Dakuten GA',
      characters: [
        JapaneseCharacter(
          character: 'が',
          romaji: 'ga',
          type: 'hiragana',
          mnemonicID: 'か + tanda dakuten (゛)',
          mnemonicEN: 'ka + dakuten mark (゛)',
        ),
        JapaneseCharacter(
          character: 'ぎ',
          romaji: 'gi',
          type: 'hiragana',
          mnemonicID: 'き + tanda dakuten',
          mnemonicEN: 'ki + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'ぐ',
          romaji: 'gu',
          type: 'hiragana',
          mnemonicID: 'く + tanda dakuten',
          mnemonicEN: 'ku + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'げ',
          romaji: 'ge',
          type: 'hiragana',
          mnemonicID: 'け + tanda dakuten',
          mnemonicEN: 'ke + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'ご',
          romaji: 'go',
          type: 'hiragana',
          mnemonicID: 'こ + tanda dakuten',
          mnemonicEN: 'ko + dakuten mark',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'Dakuten ZA',
      characters: [
        JapaneseCharacter(
          character: 'ざ',
          romaji: 'za',
          type: 'hiragana',
          mnemonicID: 'さ + tanda dakuten',
          mnemonicEN: 'sa + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'じ',
          romaji: 'ji',
          type: 'hiragana',
          mnemonicID: 'し + tanda dakuten',
          mnemonicEN: 'shi + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'ず',
          romaji: 'zu',
          type: 'hiragana',
          mnemonicID: 'す + tanda dakuten',
          mnemonicEN: 'su + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'ぜ',
          romaji: 'ze',
          type: 'hiragana',
          mnemonicID: 'せ + tanda dakuten',
          mnemonicEN: 'se + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'ぞ',
          romaji: 'zo',
          type: 'hiragana',
          mnemonicID: 'そ + tanda dakuten',
          mnemonicEN: 'so + dakuten mark',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'Dakuten DA',
      characters: [
        JapaneseCharacter(
          character: 'だ',
          romaji: 'da',
          type: 'hiragana',
          mnemonicID: 'た + tanda dakuten',
          mnemonicEN: 'ta + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'ぢ',
          romaji: 'ji',
          type: 'hiragana',
          mnemonicID: 'ち + tanda dakuten (jarang dipakai)',
          mnemonicEN: 'chi + dakuten (rarely used)',
        ),
        JapaneseCharacter(
          character: 'づ',
          romaji: 'zu',
          type: 'hiragana',
          mnemonicID: 'つ + tanda dakuten (jarang dipakai)',
          mnemonicEN: 'tsu + dakuten (rarely used)',
        ),
        JapaneseCharacter(
          character: 'で',
          romaji: 'de',
          type: 'hiragana',
          mnemonicID: 'て + tanda dakuten',
          mnemonicEN: 'te + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'ど',
          romaji: 'do',
          type: 'hiragana',
          mnemonicID: 'と + tanda dakuten',
          mnemonicEN: 'to + dakuten mark',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'Dakuten BA',
      characters: [
        JapaneseCharacter(
          character: 'ば',
          romaji: 'ba',
          type: 'hiragana',
          mnemonicID: 'は + tanda dakuten',
          mnemonicEN: 'ha + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'び',
          romaji: 'bi',
          type: 'hiragana',
          mnemonicID: 'ひ + tanda dakuten',
          mnemonicEN: 'hi + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'ぶ',
          romaji: 'bu',
          type: 'hiragana',
          mnemonicID: 'ふ + tanda dakuten',
          mnemonicEN: 'fu + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'べ',
          romaji: 'be',
          type: 'hiragana',
          mnemonicID: 'へ + tanda dakuten',
          mnemonicEN: 'he + dakuten mark',
        ),
        JapaneseCharacter(
          character: 'ぼ',
          romaji: 'bo',
          type: 'hiragana',
          mnemonicID: 'ほ + tanda dakuten',
          mnemonicEN: 'ho + dakuten mark',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'Handakuten PA',
      characters: [
        JapaneseCharacter(
          character: 'ぱ',
          romaji: 'pa',
          type: 'hiragana',
          mnemonicID: 'は + tanda handakuten (゜)',
          mnemonicEN: 'ha + handakuten mark (゜)',
        ),
        JapaneseCharacter(
          character: 'ぴ',
          romaji: 'pi',
          type: 'hiragana',
          mnemonicID: 'ひ + tanda handakuten',
          mnemonicEN: 'hi + handakuten mark',
        ),
        JapaneseCharacter(
          character: 'ぷ',
          romaji: 'pu',
          type: 'hiragana',
          mnemonicID: 'ふ + tanda handakuten',
          mnemonicEN: 'fu + handakuten mark',
        ),
        JapaneseCharacter(
          character: 'ぺ',
          romaji: 'pe',
          type: 'hiragana',
          mnemonicID: 'へ + tanda handakuten',
          mnemonicEN: 'he + handakuten mark',
        ),
        JapaneseCharacter(
          character: 'ぽ',
          romaji: 'po',
          type: 'hiragana',
          mnemonicID: 'ほ + tanda handakuten',
          mnemonicEN: 'ho + handakuten mark',
        ),
      ],
    ),
    CharacterGroup(
      groupName: 'Kombinasi KYA・SHI・CHI ',
      characters: [
        JapaneseCharacter(
          character: 'きゃ',
          romaji: 'kya',
          type: 'hiragana',
          mnemonicID: 'き + や kecil',
        ),
        JapaneseCharacter(
          character: 'きゅ',
          romaji: 'kyu',
          type: 'hiragana',
          mnemonicID: 'き + ゆ kecil',
        ),
        JapaneseCharacter(
          character: 'きょ',
          romaji: 'kyo',
          type: 'hiragana',
          mnemonicID: 'き + よ kecil',
        ),
        JapaneseCharacter(
          character: 'しゃ',
          romaji: 'sha',
          type: 'hiragana',
          mnemonicID: 'し + や kecil',
        ),
        JapaneseCharacter(
          character: 'しゅ',
          romaji: 'shu',
          type: 'hiragana',
          mnemonicID: 'し + ゆ kecil',
        ),
        JapaneseCharacter(
          character: 'しょ',
          romaji: 'sho',
          type: 'hiragana',
          mnemonicID: 'し + よ kecil',
        ),
        JapaneseCharacter(
          character: 'ちゃ',
          romaji: 'cha',
          type: 'hiragana',
          mnemonicID: 'ち + や kecil',
        ),
        JapaneseCharacter(
          character: 'ちゅ',
          romaji: 'chu',
          type: 'hiragana',
          mnemonicID: 'ち + ゆ kecil',
        ),
        JapaneseCharacter(
          character: 'ちょ',
          romaji: 'cho',
          type: 'hiragana',
          mnemonicID: 'ち + よ kecil',
        ),
        JapaneseCharacter(
          character: 'にゃ',
          romaji: 'nya',
          type: 'hiragana',
          mnemonicID: 'に + や kecil',
        ),
        JapaneseCharacter(
          character: 'にゅ',
          romaji: 'nyu',
          type: 'hiragana',
          mnemonicID: 'に + ゆ kecil',
        ),
        JapaneseCharacter(
          character: 'にょ',
          romaji: 'nyo',
          type: 'hiragana',
          mnemonicID: 'に + よ kecil',
        ),
        JapaneseCharacter(
          character: 'ひゃ',
          romaji: 'hya',
          type: 'hiragana',
          mnemonicID: 'ひ + や kecil',
        ),
        JapaneseCharacter(
          character: 'ひゅ',
          romaji: 'hyu',
          type: 'hiragana',
          mnemonicID: 'ひ + ゆ kecil',
        ),
        JapaneseCharacter(
          character: 'ひょ',
          romaji: 'hyo',
          type: 'hiragana',
          mnemonicID: 'ひ + よ kecil',
        ),
        JapaneseCharacter(
          character: 'みゃ',
          romaji: 'mya',
          type: 'hiragana',
          mnemonicID: 'み + や kecil',
        ),
        JapaneseCharacter(
          character: 'みゅ',
          romaji: 'myu',
          type: 'hiragana',
          mnemonicID: 'み + ゆ kecil',
        ),
        JapaneseCharacter(
          character: 'みょ',
          romaji: 'myo',
          type: 'hiragana',
          mnemonicID: 'み + よ kecil',
        ),
        JapaneseCharacter(
          character: 'りゃ',
          romaji: 'rya',
          type: 'hiragana',
          mnemonicID: 'り + や kecil',
        ),
        JapaneseCharacter(
          character: 'りゅ',
          romaji: 'ryu',
          type: 'hiragana',
          mnemonicID: 'り + ゆ kecil',
        ),
        JapaneseCharacter(
          character: 'りょ',
          romaji: 'ryo',
          type: 'hiragana',
          mnemonicID: 'り + よ kecil',
        ),
      ],
    ),
  ];
  static final int _basicGroupCount = 10;

  /// 46 huruf dasar (sebelum dakuten).
  static List<JapaneseCharacter> get allBasicChars {
    return groups.take(_basicGroupCount).expand((g) => g.characters).toList();
  }

  /// Semua grup untuk tabel referensi (dasar + dakuten + handakuten).
  static List<CharacterGroup> get tableGroups => groups;

  /// Semua karakter dalam tabel lengkap.
  static List<JapaneseCharacter> get allTableChars {
    return tableGroups.expand((g) => g.characters).toList();
  }
}
