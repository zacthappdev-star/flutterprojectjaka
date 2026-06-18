import 'package:flutter/material.dart' show BuildContext, ThemeMode;
import 'package:ppkd_b6/gen/strings.g.dart';

enum AppThemeMode {
  light,
  dark;

  String get storageKey => name;

  static AppThemeMode fromStorage(String? value) {
    switch (value) {
      case 'dark':
        return AppThemeMode.dark;
      default:
        return AppThemeMode.light;
    }
  }

  ThemeMode toThemeMode() {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  String label(BuildContext context) {
    switch (this) {
      case AppThemeMode.light:
        return Translations.of(context).settings.lightTheme;
      case AppThemeMode.dark:
        return Translations.of(context).settings.darkTheme;
    }
  }
}
