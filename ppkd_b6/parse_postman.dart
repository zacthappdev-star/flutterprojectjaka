import 'dart:convert';
import 'dart:io';

void main() {
  var f = File(
    r'd:\flutterprojectjaka\ppkd_b6\lib\api3\ABSENSI PPKD B6 Latihan.postman_collection.json',
  );
  var d = jsonDecode(f.readAsStringSync());
  var out = File(
    r'd:\flutterprojectjaka\ppkd_b6\postman_responses.txt',
  ).openWrite();

  void p(List c) {
    for (var i in c) {
      if (i['item'] != null) {
        p(i['item']);
      } else {
        out.writeln('=== ${i['name']} ===');
        if (i['response'] != null && (i['response'] as List).isNotEmpty) {
          for (var r in i['response']) {
            if (r['body'] != null) {
              try {
                var j = jsonDecode(r['body']);
                // simplify base64
                if (j['data'] != null &&
                    j['data'] is Map &&
                    j['data']['profile_photo'] != null) {
                  j['data']['profile_photo'] = '...';
                }
                out.writeln(jsonEncode(j));
              } catch (e) {
                out.writeln(
                  r['body'].substring(
                    0,
                    r['body'].length > 200 ? 200 : r['body'].length,
                  ),
                );
              }
            }
          }
        }
      }
    }
  }

  p(d['item']);
  out.close();
}
