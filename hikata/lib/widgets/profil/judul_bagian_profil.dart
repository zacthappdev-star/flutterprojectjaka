import 'package:flutter/material.dart';

class JudulBagianProfil extends StatelessWidget {
  final String title;
  const JudulBagianProfil({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}
