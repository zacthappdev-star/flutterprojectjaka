import 'package:flutter/material.dart';
import 'package:ppkd_b6/flutter8.dart'; // File Navigator8 lu
import 'package:ppkd_b6/local/database/preference_handler.dart';
import 'package:ppkd_b6/loginn.dart';
import 'package:ppkd_b6/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 183, 58, 58),
        ),
        useMaterial3: true,
      ),
      initialRoute: TampilanLogin.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        TampilanLogin.routeName: (context) => TampilanLogin(),
        Navigator8.routeName: (context) => Navigator8(),
      },
    );
  }
}
