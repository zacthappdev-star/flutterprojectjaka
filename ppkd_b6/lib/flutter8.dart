import 'package:flutter/material.dart';
import 'package:ppkd_b6/api/views/crypto_market.dart';
import 'package:ppkd_b6/navigator_widget.dart';
import 'package:ppkd_b6/views/list.dart';
import 'package:ppkd_b6/views/map.dart';

class Navigator8 extends StatefulWidget {
  static String routeName = '/navigator8';
  const Navigator8({super.key});

  @override
  State<Navigator8> createState() => _Navigator8State();
}

class _Navigator8State extends State<Navigator8> {
  String? selectedLevel;
  String? selectedKategori;
  bool isChecked = false;
  bool isDarkMode = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Index halaman yang aktif (bisa diubah-ubah nilainya)
  int _currentIndex = 0;

  // List Judul AppBar sesuai dengan tab yang dipilih
  final List<String> titles = ["HI KATA", 'List', "List Map", 'Crypto Model'];

  // List Halaman yang dipanggil saat tab di-klik
  final List<Widget> _pages = [
    const NavigatorWidget(),
    const HiKataPage(),
    const ListWithMap(),
    const CryptoMarketPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          titles[_currentIndex], // Judul dinamis mengikuti tab aktif
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      // Drawer hanya muncul di halaman Home (index 0)
      drawer: _currentIndex == 0
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.green),
                    child: Center(
                      child: Text(
                        "MENU",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text("Hiragana"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.translate),
                    title: const Text("Katakana"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.quiz),
                    title: const Text("Quiz"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: const Text("Progress"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.alarm),
                    title: const Text("Pengingat"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          : null,

      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType
            .fixed, // Biar background hijau ga hilang karena ada 4 item
        backgroundColor: Colors.green,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Pindah tab/halaman saat di-klik
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "List Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: "Crypto",
          ),
        ],
      ),
    );
  }
}
