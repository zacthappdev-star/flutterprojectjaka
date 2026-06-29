import 'package:flutter/material.dart';

class Nextslide2 extends StatelessWidget {
  final String email, password;

  const Nextslide2({super.key, required this.password, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text(email), Text(password)]));
  }
}
