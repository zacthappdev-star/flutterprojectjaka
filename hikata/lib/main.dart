import 'package:flutter/material.dart';
import 'package:ppkd_b6/screen/layar_splash.dart';
import 'package:ppkd_b6/services/layanan_notifikasi.dart';
import 'package:ppkd_b6/services/layanan_pelafalan.dart';
import 'package:ppkd_b6/services/layanan_tema.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await PronunciationService.init();
  await ThemeService.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    ThemeService.themeModeNotifier.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    ThemeService.themeModeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() => setState(() {});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hi Kata App',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: ThemeService.themeModeNotifier.value,
      home: SplashScreen(),
    );
  }
}
