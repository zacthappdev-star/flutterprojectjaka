import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:ppkd_b6/models/mode_tema_aplikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  ThemeService._();
  static const _prefKey = 'app_theme_mode';
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
    ThemeMode.light,
  );
  static AppThemeMode _mode = AppThemeMode.light;
  static AppThemeMode get mode => _mode;
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _mode = AppThemeMode.fromStorage(prefs.getString(_prefKey));
    themeModeNotifier.value = _mode.toThemeMode();
  }

  static Future<void> setMode(AppThemeMode mode) async {
    if (_mode == mode) return;
    _mode = mode;
    themeModeNotifier.value = mode.toThemeMode();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, mode.storageKey);
    debugPrint('ThemeService: mode → ${mode.name}');
  }
}
