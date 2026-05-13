import 'package:flutter/material.dart';

class Tugas4 extends StatelessWidget {
  const Tugas4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,

        leading: Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset("assets/images/leaves.png"),
        ),

        centerTitle: true,

        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.black,
        ),

        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 21, vertical: 7),

          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 19, 217, 231),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: const Color.fromARGB(255, 1, 106, 177),
              width: 3,
            ),
          ),
          child: Text(
            "HI KATA",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 34, 1, 28),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Nama Lengkap",
              filled: true,
              fillColor: Colors.grey[100],
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Masukkan Email",
              filled: true,
              fillColor: Colors.grey[100],
              prefixIcon: const Icon(Icons.mail),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: true,
            obscuringCharacter: "*",
            decoration: InputDecoration(
              hintText: "Masukkan Password",
              filled: true,
              fillColor: Colors.grey[100],
              prefixIcon: const Icon(Icons.key),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: true,
            obscuringCharacter: "*",
            decoration: InputDecoration(
              hintText: "Ulangi Password",
              filled: true,
              fillColor: Colors.grey[100],
              prefixIcon: const Icon(Icons.key),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.notification_add),
            title: Text("Belajar Hiragana"),
            subtitle: Text("Mengenali huruf"),
            trailing: Icon(Icons.ac_unit_sharp),
          ),

          ListTile(
            leading: Icon(Icons.notification_add),
            title: Text("Belajar Katakana"),
            subtitle: Text("Mengenali Huruf"),
            trailing: Icon(Icons.ac_unit_sharp),
          ),

          ListTile(
            leading: Icon(Icons.read_more),
            title: Text("Belajar Hiragana"),
            subtitle: Text("Latihan Huruf"),
            trailing: Icon(Icons.ac_unit_sharp),
          ),
          ListTile(
            leading: Icon(Icons.read_more_outlined),
            title: Text("Belajar Katakana"),
            subtitle: Text("Latihan Huruf"),
            trailing: Icon(Icons.ac_unit_sharp),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Ujian Soal"),
            subtitle: Text("Latihan Soal"),
            trailing: Icon(Icons.ac_unit_sharp),
          ),
        ],
      ),
    );
  }
}
