// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  var dir = Directory('lib');
  var files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  var regex = RegExp(
    r"Text\(\s*['"
    '"'
    r"]([^'"
    '"'
    r"]+)['"
    '"'
    r"]",
  );

  for (var file in files) {
    var lines = file.readAsLinesSync();
    for (var i = 0; i < lines.length; i++) {
      var line = lines[i];
      var match = regex.firstMatch(line);
      if (match != null) {
        var text = match.group(1)!;
        if (!text.startsWith('t.') &&
            !line.contains('Translations.of') &&
            text.length > 1 &&
            RegExp(r'[a-z]').hasMatch(text)) {
          print('${file.path}:${i + 1}: $text');
        }
      }
    }
  }
}
