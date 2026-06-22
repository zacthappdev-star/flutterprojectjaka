import 'dart:io';

void processFile(String filepath, String typeVal) {
  final file = File(filepath);
  String content = file.readAsStringSync();

  final regex = RegExp(r'([ \t]*)romaji:\s*(\u0027[^\u0027]+\u0027)(,?)');
  content = content.replaceAllMapped(regex, (match) {
    final indent = match.group(1)!;
    final romajiVal = match.group(2)!;
    var comma = match.group(3)!;
    if (comma.isEmpty) {
      comma = ',';
    }
    return '${indent}romaji: $romajiVal$comma\n${indent}type: \u0027$typeVal\u0027,';
  });

  file.writeAsStringSync(content);
}

void main() {
  processFile(
    r'd:\flutterprojectjaka\hikata\lib\data\data_hiragana.dart',
    'hiragana',
  );
  processFile(
    r'd:\flutterprojectjaka\hikata\lib\data\data_katakana.dart',
    'katakana',
  );
}
