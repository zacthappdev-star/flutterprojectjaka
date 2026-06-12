import 'package:flutter/material.dart';

class ScriptGuideItem {
  final String id;
  final String titleID;
  final String titleEN;
  final String summaryID;
  final String summaryEN;
  final String bodyID;
  final String bodyEN;
  final String exampleChars;
  final IconData icon;
  final Color accentColor;

  const ScriptGuideItem({
    required this.id,
    required this.titleID,
    required this.titleEN,
    required this.summaryID,
    required this.summaryEN,
    required this.bodyID,
    required this.bodyEN,
    required this.exampleChars,
    required this.icon,
    required this.accentColor,
  });
}

class ScriptGuideData {
  static const items = [
    ScriptGuideItem(
      id: 'Hiragana',
      titleID: 'Hiragana',
      titleEN: 'Hiragana',
      summaryID: 'Aksara fonetik asli Jepang dengan bentuk melengkung.',
      summaryEN: 'Native Japanese phonetic script with curved shapes.',
      bodyID:
          'Hiragana adalah sistem penulisan fonetik Jepang yang digunakan'
          ' untuk kata-kata asli Jepang mempunyai 46 karakter.\n'
          'Contoh :\n あさ (asa) = pagi  \n ねこ (neko) = kucing.',
      bodyEN:
          'Hiragana is a Japanese phonetic writing system used'
          ' for native Japanese words and has 46 characters.\n'
          'Example:\n あさ (asa) = morning  \n ねこ (neko) = cat.',
      exampleChars: 'あ い う え お',
      icon: Icons.abc,
      accentColor: Color(0xFF2E7D32),
    ),
    ScriptGuideItem(
      id: 'Katakana',
      titleID: 'Katakana',
      titleEN: 'Katakana',
      summaryID: 'Aksara fonetik untuk kata serapan dan nama asing.',
      summaryEN: 'Phonetic script for loanwords and foreign names.',
      bodyID:
          'Katakana adalah sistem penulisan digunakan untuk'
          ' kata serapan asing, nama, dan penekanan dalam bahasa Jepang dan '
          'mempunyai 46 karakter.\n'
          'Contoh:\n コーヒー (kōhī = kopi)\n, テレビ (terebi = televisi).',
      bodyEN:
          'Katakana is a writing system used for'
          'foreign loanwords, names, and emphasis in Japanese and'
          'has 46 characters.\n'
          'Example: コーヒー (kōhī = coffee)'
          ', テレビ (terebi = television).',
      exampleChars: 'ア イ ウ エ オ',
      icon: Icons.translate_rounded,
      accentColor: Color.fromARGB(223, 158, 175, 0),
    ),
    ScriptGuideItem(
      id: 'Gojūon',
      titleID: 'Gojūon',
      titleEN: 'Gojūon',
      summaryID: 'Tabel 46 huruf dasar yang menjadi fondasi belajar.',
      summaryEN: 'The basic table of 46 foundational characters.',
      bodyID:
          'Gojūon artinya "lima puluh suara" dan merujuk pada tabel huruf dasar Jepang. '
          'Huruf-huruf ini disusun dalam baris berdasarkan konsonan + vokal:\n\n'
          '• Baris vokal: あ い う え お\n'
          '• Baris K: か き く け こ\n\n'
          'Kuasai gojūon dulu sebelum belajar dakuten dan youon.',
      bodyEN:
          'Gojūon means "fifty sounds" and refers to the basic Japanese character table. '
          'Characters are arranged in rows by consonant + vowel:\n\n'
          '• Vowel row: あ い う え お\n'
          '• K row: か き く け こ\n\n'
          'Master gojūon before learning dakuten and yōon.',
      exampleChars: 'か さ た な は',
      icon: Icons.grid_view_rounded,
      accentColor: Color(0xFF00695C),
    ),
    ScriptGuideItem(
      id: 'Dakuten',
      titleID: 'Dakuten',
      titleEN: 'Dakuten',
      summaryID: 'Tanda dua titik yang mengubah suara menjadi berat.',
      summaryEN: 'Two dots that change sounds to voiced versions.',
      bodyID:
          'Dakuten (゛) adalah dua titik kecil di pojok kanan atas huruf. '
          'Tanda ini mengubah suara konsonan menjadi "berat" atau bersuara.\n\n'
          'Contoh perubahan:\n'
          '• か (ka) → が (ga)\n'
          '• さ (sa) → ざ (za)\n'
          '• た (ta) → だ (da)\n'
          '• は (ha) → ば (ba)\n\n',
      bodyEN:
          'Dakuten (゛) is a pair of small dots placed on the top-right of a character. '
          'It changes consonant sounds into voiced (heavier) versions.\n\n'
          'Examples of changes:\n'
          '• か (ka) → が (ga)\n'
          '• さ (sa) → ざ (za)\n'
          '• た (ta) → だ (da)\n'
          '• は (ha) → ば (ba)\n\n',
      exampleChars: 'が ざ だ ば',
      icon: Icons.more_horiz_rounded,
      accentColor: Color(0xFFE65100),
    ),
    ScriptGuideItem(
      id: 'Handakuten',
      titleID: 'Handakuten',
      titleEN: 'Handakuten',
      summaryID: 'Tanda bulat kecil untuk suara "p".',
      summaryEN: 'A small circle mark for "p" sounds.',
      bodyID:
          'Handakuten (゜) adalah lingkaran kecil yang hanya dipakai pada baris HA.'
          'Tanda ini mengubah suara menjadi "p".\n\n'
          'Contoh perubahan:\n'
          '• は (ha) → ぱ (pa)\n'
          '• ひ (hi) → ぴ (pi)\n'
          '• ふ (fu) → ぷ (pu)\n'
          '• へ (he) → ぺ (pe)\n'
          '• ほ (ho) → ぽ (po)\n\n',
      bodyEN:
          'Handakuten (゜) is a small circle used only on the HA row'
          'It changes the sound to "p".\n\n'
          'Examples of changes:\n'
          '• は (ha) → ぱ (pa)\n'
          '• ひ (hi) → ぴ (pi)\n'
          '• ふ (fu) → ぷ (pu)\n'
          '• へ (he) → ぺ (pe)\n'
          '• ほ (ho) → ぽ (po)\n\n',
      exampleChars: 'ぱ ぴ ぷ ぺ ぽ',
      icon: Icons.circle_outlined,
      accentColor: Color(0xFF6A1B9A),
    ),
    ScriptGuideItem(
      id: 'Youon',
      titleID: 'Youon / Yōon',
      titleEN: 'Yōon',
      summaryID: 'Kombinasi huruf kecil untuk suara gabungan.',
      summaryEN: 'Small-character combinations for blended sounds.',
      bodyID:
          'Yōon dibentuk dengan menambahkan huruf kecil ゃ (ya), ゅ (yu), atau ょ (yo) '
          'setelah konsonan. Hasilnya adalah suara gabungan.\n\n'
          'Contoh Hiragana:\n'
          '• き + ゃ = きゃ (kya)\n'
          '• し + ゅ = しゅ (shu)\n'
          '• ち + ょ = ちょ (cho)\n\n',
      bodyEN:
          'Yōon is formed by adding a small ゃ (ya), ゅ (yu), or ょ (yo) '
          'after a consonant character, creating a blended sound (digraph).\n\n'
          'Hiragana examples:\n'
          '• き + ゃ = きゃ (kya)\n'
          '• し + ゅ = しゅ (shu)\n'
          '• ち + ょ = ちょ (cho)\n\n',
      exampleChars: 'きゃ しゅ ちょ',
      icon: Icons.merge_rounded,
      accentColor: Color(0xFF0277BD),
    ),
    ScriptGuideItem(
      id: 'Sokuon',
      titleID: 'Sokuon ',
      titleEN: 'Sokuon ',
      summaryID: 'Huruf kecil っ/ッ untuk jeda konsonan ganda.',
      summaryEN: 'Small っ/ッ for double consonant pauses.',
      bodyID:
          'Sokuon adalah huruf kecil っ (Hiragana) atau ッ (Katakana) yang menandakan '
          'jeda singkat sebelum konsonan berikutnya — seperti konsonan ganda.\n\n'
          'Contoh:\n'
          '• きって (kitte) = perangko\n'
          '• がっこう (gakkō) = sekolah\n'
          '• サッカー (sakkā) = sepak bola\n\n'
          'Bunyinya seperti ada "hentian" singkat di tengah kata.',
      bodyEN:
          'Sokuon is the small っ (Hiragana) or ッ (Katakana) that marks a brief pause '
          'before the next consonant — like a double consonant.\n\n'
          'Examples:\n'
          '• きって (kitte) = stamp\n'
          '• がっこう (gakkō) = school\n'
          '• サッカー (sakkā) = soccer\n\n'
          'It sounds like a short stop in the middle of the word.',
      exampleChars: 'っ ッ',
      icon: Icons.pause_circle_outline_rounded,
      accentColor: Color(0xFFAD1457),
    ),
    ScriptGuideItem(
      id: 'Chouon',
      titleID: 'Chōon',
      titleEN: 'Chōon',
      summaryID: 'Garis panjang untuk memperpanjang vokal.',
      summaryEN: 'Long vowel mark that extends a sound.',
      bodyID:
          'Chōon (ー) adalah garis horizontal panjang di Katakana yang memperpanjang '
          'bunyi vokal sebelumnya.\n\n'
          'Contoh:\n'
          '• コーヒー (kōhī) — vokal "o" dan "i" diperpanjang\n'
          '• ラーメン (rāmen) — vokal "a" diperpanjang\n'
          '• スーパー (sūpā) — vokal "u" dan "a" diperpanjang\n\n'
          'Di Hiragana, vokal panjang biasanya ditulis dengan huruf vokal tambahan, '
          'misalnya おう (ō) atau いい (ī).',
      bodyEN:
          'Chōon (ー) is a long horizontal line in Katakana that extends the preceding vowel sound.\n\n'
          'Examples:\n'
          '• コーヒー (kōhī) — "o" and "i" are lengthened\n'
          '• ラーメン (rāmen) — "a" is lengthened\n'
          '• スーパー (sūpā) — "u" and "a" are lengthened\n\n'
          'In Hiragana, long vowels are usually written with an extra vowel character, '
          'such as おう (ō) or いい (ī).',
      exampleChars: 'コー ラーメン',
      icon: Icons.horizontal_rule_rounded,
      accentColor: Color(0xFF4527A0),
    ),
  ];
}
