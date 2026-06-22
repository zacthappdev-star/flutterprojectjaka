import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ppkd_b6/gen/strings.g.dart';
import 'package:ppkd_b6/providers/mission_provider.dart';
import 'package:ppkd_b6/providers/profile_provider.dart';
import 'package:ppkd_b6/screen/layar_splash.dart';
import 'package:ppkd_b6/screen/pengenalan/pilih_bahasa.dart';
import 'package:ppkd_b6/services/layanan_notifikasi.dart';
import 'package:ppkd_b6/services/layanan_pelafalan.dart';
import 'package:ppkd_b6/services/layanan_tema.dart';
import 'package:ppkd_b6/theme/tema_aplikasi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await PronunciationService.init();
  await ThemeService.init();

  final prefs = await SharedPreferences.getInstance();
  final savedLang = prefs.getString('selected_language') ?? 'id';
  LocaleSettings.setLocaleRaw(savedLang);
  AppLanguage.current = savedLang;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProfileProvider()..loadProfileData(),
        ),
        ChangeNotifierProvider(
          create: (_) => MissionProvider()..loadMissions(),
        ),
      ],
      child: TranslationProvider(child: const MyApp()),
    ),
  );
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
      locale: TranslationProvider.of(context).locale.flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: SplashScreen(),
    );
  }
}
