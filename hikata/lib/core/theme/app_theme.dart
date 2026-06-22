import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Dark Mode Colors
  static const Color darkScaffoldBackground = Color(0xFF0D2818);
  static const Color darkCardBackground = Color(0xFF163A25);
  static const Color darkAccentGreen = Color(0xFF1E5C35);
  static const Color darkPrimaryGreen = Color(0xFF2E7D32);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFA5D6A7);
  static const Color darkTextMuted = Color(0xFF66BB6A);
  static const Color darkInputBackground = Color(0xFF163A25);
  static const Color darkInputBorder = Color(0xFF2E7D32);
  static const Color darkAppBarBackground = Color(0xFF163A25);

  // Light Mode Colors
  static const Color lightScaffoldBackground = Color(0xFFFFFFFF);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightPrimaryGreen = Color(0xFF2E7D32);
  static const Color lightHeaderGreen = Color(0xFF2E7D32);
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF2E7D32);
  static const Color lightTextMuted = Color(0xFF757575);
  static const Color lightInputBackground = Color(0xFFF1F8E9);
  static const Color lightInputBorder = Color(0xFFC8E6C9);
  static const Color lightAppBarBackground = Color(0xFF2E7D32);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: lightPrimaryGreen,
      scaffoldBackgroundColor: lightScaffoldBackground,
      colorScheme: ColorScheme.light(
        primary: lightPrimaryGreen,
        secondary: lightTextSecondary,
        surface: lightCardBackground,
        error: Colors.red,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        bodyLarge: GoogleFonts.poppins(color: lightTextPrimary),
        bodyMedium: GoogleFonts.poppins(color: lightTextPrimary),
        bodySmall: GoogleFonts.poppins(color: lightTextMuted),
        titleLarge: GoogleFonts.poppins(
          color: lightTextPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightAppBarBackground,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: lightCardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: lightBorder),
        ),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimaryGreen,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightInputBackground,
        contentPadding: EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightInputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: lightPrimaryGreen, width: 2),
        ),
        prefixIconColor: lightPrimaryGreen,
        suffixIconColor: lightPrimaryGreen,
      ),
      dividerColor: lightBorder,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkPrimaryGreen,
      scaffoldBackgroundColor: darkScaffoldBackground,
      colorScheme: ColorScheme.dark(
        primary: darkPrimaryGreen,
        secondary: darkTextSecondary,
        surface: darkCardBackground,
        error: Colors.redAccent,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        bodyLarge: GoogleFonts.poppins(color: darkTextPrimary),
        bodyMedium: GoogleFonts.poppins(color: darkTextPrimary),
        bodySmall: GoogleFonts.poppins(color: darkTextMuted),
        titleLarge: GoogleFonts.poppins(
          color: darkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkAppBarBackground,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: darkCardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide.none,
        ),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimaryGreen,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          textStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkInputBackground,
        contentPadding: EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkInputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkPrimaryGreen, width: 2),
        ),
        prefixIconColor: darkPrimaryGreen,
        suffixIconColor: darkPrimaryGreen,
      ),
      dividerColor: darkInputBorder,
    );
  }
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
