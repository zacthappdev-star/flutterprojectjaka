import 'package:flutter/material.dart';
import 'package:ppkd_b6/navigator_widget.dart';
import 'package:ppkd_b6/views/list.dart';
import 'package:ppkd_b6/views/listwithmodel.dart';
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
  int _currentIndex = 0;
  final List<String> titles = ["HI KATA", 'List', "List Map", 'List Model'];
  final List<Widget> _pages = [
    const NavigatorWidget(),
    // const HiTentang(),
    const HiKataPage(),
    const ListWithMap(),
    const ListWithModels(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Hi Kata",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      drawer: _currentIndex == 0
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
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
                    leading: Icon(Icons.language),
                    title: Text("Hiragana"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.translate),
                    title: Text("Katakana"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.quiz),
                    title: Text("Quiz"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.bar_chart),
                    title: Text("Progress"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.alarm),
                    title: Text("Pengingat"),
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
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.green,
            label: "Home",
          ),
          // BottomNavigationBarItem(icon: Icon(Icons.person), label: "Tentang"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "List Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_agenda),
            label: "List Model",
          ),
        ],
      ),
    );
  }
}
