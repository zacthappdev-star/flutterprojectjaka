import 'package:flutter/material.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

class ThemedGradientScaffold extends StatelessWidget {
  final Widget body;
  const ThemedGradientScaffold({super.key, required this.body});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: context.hiKata.backgroundGradient),
        child: body,
      ),
    );
  }
}
