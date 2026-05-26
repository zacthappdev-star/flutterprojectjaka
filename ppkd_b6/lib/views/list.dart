import 'package:flutter/material.dart';

class HiKataPage extends StatefulWidget {
  const HiKataPage({super.key});
  @override
  State<HiKataPage> createState() => _HiKataPageState();
}

class _HiKataPageState extends State<HiKataPage> {
  final List<String> kategori = [
    "Hiragana",
    "Katakana",
    "Kosakata",
    "Quiz",
    "Progress",
    "Alarm Belajar",
    "Latihan Menulis",
    "Percakapan",
    "Grammar Dasar",
    "Ranking",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HI KATA")),
      body: ListView.builder(
        itemCount: kategori.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(kategori[index]));
        },
      ),
    );
  }
}
