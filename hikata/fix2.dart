import 'dart:io';

void fixFile(String filepath, String typeVal) {
  final file = File(filepath);
  String content = file.readAsStringSync();

  // Replace double types
  content = content.replaceAll(
    "type: '$typeVal',\n type: '$typeVal',",
    "type: '$typeVal',",
  );
  content = content.replaceAll(
    "type: '$typeVal',\r\n type: '$typeVal',",
    "type: '$typeVal',",
  );
  content = content.replaceAll(
    RegExp(r"type:\s*'" + typeVal + r"',\s*type:\s*'" + typeVal + r"',"),
    "type: '$typeVal',",
  );

  file.writeAsStringSync(content);
}

void main() {
  fixFile(
    r'd:\flutterprojectjaka\hikata\lib\data\data_hiragana.dart',
    'hiragana',
  );
  fixFile(
    r'd:\flutterprojectjaka\hikata\lib\data\data_katakana.dart',
    'katakana',
  );
}
