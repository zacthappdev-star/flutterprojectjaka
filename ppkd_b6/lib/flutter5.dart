import 'package:flutter/material.dart';

class Hikata1 extends StatefulWidget {
  const Hikata1({super.key});
  @override
  State<Hikata1> createState() => _Hikata1State();
}

class _Hikata1State extends State<Hikata1> {
  int nilaiGesture = 10;
  bool like = false;
  bool perkenalkan = false;
  bool deskripsi = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("HI KATA"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Center(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              setState(() {
                perkenalkan = !perkenalkan;
              });
            },
            child: Text(
              perkenalkan ? "Hallo Saya Pengguna Baru" : "Mari Berlatih",
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 15),
          IconButton(
            onPressed: () {
              setState(() {
                like = !like;
              });
            },
            icon: Icon(Icons.favorite, color: like ? Colors.red : Colors.black),
          ),
          Text(
            like ? "Menyukai" : "Tidak Suka",
            style: TextStyle(color: Colors.blue),
          ),
          SizedBox(height: 15),
          TextButton(
            onPressed: () {
              setState(() {
                deskripsi = !deskripsi;
              });
            },
            child: Text(
              "Informasi Tambahan",
              style: TextStyle(fontSize: 20, color: Colors.purple),
            ),
          ),
          if (deskripsi)
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "HI KATA adalah aplikasi pembelajaran "
                "huruf Hiragana dan Katakana "
                "untuk pemula.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          InkWell(
            splashColor: Colors.red,
            onTap: () {
              debugPrint("JAPAN");
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Image.asset("assets/images/Japan.png", height: 100),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                nilaiGesture++;
                debugPrint("Hiragana");
              });
            },
            onDoubleTap: () {
              setState(() {
                nilaiGesture += 2;
                debugPrint("Katakana");
              });
            },
            onLongPress: () {
              setState(() {
                nilaiGesture += 3;
                debugPrint("Kanji");
              });
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Image.asset("assets/images/Japan.png", height: 100),
            ),
          ),
          Text(nilaiGesture.toString(), style: TextStyle(fontSize: 15)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            nilaiGesture--;
            debugPrint("Hiragana");
          });
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}
