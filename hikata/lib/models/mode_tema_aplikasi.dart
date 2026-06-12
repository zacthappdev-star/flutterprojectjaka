import 'package:flutter/material.dart' show ThemeMode;

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

  String label(bool isID) {
    switch (this) {
      case AppThemeMode.light:
        return isID ? 'Terang' : 'Light';
      case AppThemeMode.dark:
        return isID ? 'Gelap' : 'Dark';
    }
  }
}
