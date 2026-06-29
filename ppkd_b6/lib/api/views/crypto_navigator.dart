import 'package:flutter/material.dart';
import 'package:ppkd_b6/api/views/crypto_home_page.dart';
import 'package:ppkd_b6/api/views/crypto_market.dart';

class CryptoNavigator extends StatefulWidget {
  static const String routeName = '/crypto-navigator';

  const CryptoNavigator({super.key});

  @override
  State<CryptoNavigator> createState() => _CryptoNavigatorState();
}

class _CryptoNavigatorState extends State<CryptoNavigator> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    CryptoHomePage(
      onNavigateToMarket: () {
        setState(() {
          _currentIndex = 1;
        });
      },
    ),
    const CryptoMarketPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F14), // Base background
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF2A2D36), // Subtle border
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Color(0xFF38D782), // Accent green
          unselectedItemColor: Color(0xFF7A7D8E), // Inactive gray
          backgroundColor: Color(0xFF14161F), // Dark bar
          elevation: 0,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: "Market",
            ),
          ],
        ),
      ),
    );
  }
}
