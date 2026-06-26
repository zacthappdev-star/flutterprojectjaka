import 'package:flutter/material.dart';

@immutable
class HiKataColors extends ThemeExtension<HiKataColors> {
  final LinearGradient backgroundGradient;
  final Color cardBackground;
  final Color textPrimary;
  final Color textMuted;
  final Color textOnCardSubtitle;
  final Color lightBackground;
  final Color softMint;
  final Color navBarBackground;
  final Color fieldFill;
  final Color tableCardBgHiragana;
  final Color tableCardBgKatakana;
  final Color progressTrack;
  final Color divider;
  final Color tabIndicator;
  final Color navLencanaKuis;
  final Color navLencanaProgres;

  const HiKataColors({
    required this.backgroundGradient,
    required this.cardBackground,
    required this.textPrimary,
    required this.textMuted,
    required this.textOnCardSubtitle,
    required this.lightBackground,
    required this.softMint,
    required this.navBarBackground,
    required this.fieldFill,
    required this.tableCardBgHiragana,
    required this.tableCardBgKatakana,
    required this.progressTrack,
    required this.divider,
    required this.tabIndicator,
    required this.navLencanaKuis,
    required this.navLencanaProgres,
  });

  static const light = HiKataColors(
    backgroundGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF43A047)],
      stops: [0.0, 0.5, 1.0],
    ),
    cardBackground: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF1B5E20),
    textMuted: Color(0xFF78909C),
    textOnCardSubtitle: Color(0xFF757575),
    lightBackground: Color(0xFFE8F5E9),
    softMint: Color(0xFFC8E6C9),
    navBarBackground: Color(0xFFFFFFFF),
    fieldFill: Color(0xFFF1F8E9),
    tableCardBgHiragana: Color(0xFFE8F5E9),
    tableCardBgKatakana: Color(0xFFE8F5E9),
    progressTrack: Color(0xFFE8E8E8),
    divider: Color(0xFFE0E0E0),
    tabIndicator: Color(0xFFFFFFFF),
    navLencanaKuis: Color(0xFFFFF3E0),
    navLencanaProgres: Color(0xFFE8EAF6),
  );

  static const dark = HiKataColors(
    backgroundGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF0D1510), Color(0xFF162820), Color(0xFF1F3528)],
      stops: [0.0, 0.5, 1.0],
    ),
    cardBackground: Color(0xFF1E2D24),
    textPrimary: Color(0xFFE4EDE6),
    textMuted: Color(0xFFA8B8AA),
    textOnCardSubtitle: Color(0xFFB8C8BA),
    lightBackground: Color(0xFF243529),
    softMint: Color(0xFF2E4A38),
    navBarBackground: Color(0xFF152019),
    fieldFill: Color(0xFF243529),
    tableCardBgHiragana: Color(0xFF243529),
    tableCardBgKatakana: Color(0xFF243529),
    progressTrack: Color(0xFF354539),
    divider: Color(0xFF3A4A40),
    tabIndicator: Color(0xFF2E4A38),
    navLencanaKuis: Color(0xFF3D2E1F),
    navLencanaProgres: Color(0xFF2A2D45),
  );

  @override
  HiKataColors copyWith({
    LinearGradient? backgroundGradient,
    Color? cardBackground,
    Color? textPrimary,
    Color? textMuted,
    Color? textOnCardSubtitle,
    Color? lightBackground,
    Color? softMint,
    Color? navBarBackground,
    Color? fieldFill,
    Color? tableCardBgHiragana,
    Color? tableCardBgKatakana,
    Color? progressTrack,
    Color? divider,
    Color? tabIndicator,
    Color? navLencanaKuis,
    Color? navLencanaProgres,
  }) {
    return HiKataColors(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      cardBackground: cardBackground ?? this.cardBackground,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      textOnCardSubtitle: textOnCardSubtitle ?? this.textOnCardSubtitle,
      lightBackground: lightBackground ?? this.lightBackground,
      softMint: softMint ?? this.softMint,
      navBarBackground: navBarBackground ?? this.navBarBackground,
      fieldFill: fieldFill ?? this.fieldFill,
      tableCardBgHiragana: tableCardBgHiragana ?? this.tableCardBgHiragana,
      tableCardBgKatakana: tableCardBgKatakana ?? this.tableCardBgKatakana,
      progressTrack: progressTrack ?? this.progressTrack,
      divider: divider ?? this.divider,
      tabIndicator: tabIndicator ?? this.tabIndicator,
      navLencanaKuis: navLencanaKuis ?? this.navLencanaKuis,
      navLencanaProgres: navLencanaProgres ?? this.navLencanaProgres,
    );
  }

  @override
  HiKataColors lerp(ThemeExtension<HiKataColors>? other, double t) {
    if (other is! HiKataColors) return this;
    return t < 0.5 ? this : other;
  }
}

extension HiKataThemeX on BuildContext {
  HiKataColors get hiKata =>
      Theme.of(this).extension<HiKataColors>() ?? HiKataColors.light;
}

class AppThemes {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryGreen,
      brightness: Brightness.light,
    ),
    extensions: [HiKataColors.light],
    scaffoldBackgroundColor: Colors.transparent,
  );

  static ThemeData get dark {
    const colors = HiKataColors.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreen,
        brightness: Brightness.dark,
        surface: colors.cardBackground,
        onSurface: colors.textPrimary,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: colors.textPrimary),
        bodyMedium: TextStyle(color: colors.textPrimary),
        bodySmall: TextStyle(color: colors.textMuted),
        titleLarge: TextStyle(color: colors.textPrimary),
        titleMedium: TextStyle(color: colors.textPrimary),
        titleSmall: TextStyle(color: colors.textPrimary),
        labelLarge: TextStyle(color: colors.textPrimary),
      ),
      dividerColor: colors.divider,
      extensions: [HiKataColors.dark],
      scaffoldBackgroundColor: Colors.transparent,
    );
  }
}

class AppColors {
  // Primary Greens
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color secondaryGreen = Color(0xFF43A047);
  static const Color lightBackground = Color(0xFFE8F5E9);
  static const Color softMint = Color(0xFFC8E6C9);
  static const Color accent = Color(0xFF81C784);
  static const Color accentLight = Color(0xFFA5D6A7);
  static const Color katakanaOrange = Color(0xFFEB8C10);
  static const Color katakanaBlue = Color(0xFF1A237E);
  static const Color katakanaBlueLight = Color(0xFFE8EAF6);

  // Gradient
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF43A047)],
    stops: [0.0, 0.5, 1.0],
  );

  static LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF1F8E9)],
  );

  static LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
  );

  // Text Colors
  static const Color textPrimary = Color(0xFF1B5E20);
  static const Color textSecondary = Color(0xFF4CAF50);
  static const Color textMuted = Color(0xFF78909C);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Surface
  static Color cardWhite = Color(0xFFFFFFFF);
  static Color fieldFill = Color(0xFFF1F8E9);
  static Color dividerColor = Color(0xFFB0BEC5);
}

class AppTextStyles {
  static String fontFamily = 'Poppins';

  static TextStyle appTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColors.textWhite,
    letterSpacing: 4,
  );

  static TextStyle appSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Color(0xCCFFFFFF),
    letterSpacing: 0.5,
  );

  static TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle cardSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
    letterSpacing: 1,
  );

  static TextStyle labelText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle linkText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryGreen,
  );

  static TextStyle mutedText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );
}

class AppDecorations {
  static BoxDecoration cardDecorationOf(BuildContext context) {
    final colors = context.hiKata;
    final gelap = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: colors.cardBackground,
      borderRadius: BorderRadius.circular(28),
      boxShadow: [
        BoxShadow(
          color: AppColors.primaryGreen.withValues(alpha: gelap ? 0.06 : 0.15),
          blurRadius: 30,
          spreadRadius: 0,
          offset: Offset(0, 15),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: gelap ? 0.2 : 0.08),
          blurRadius: 10,
          spreadRadius: 0,
          offset: Offset(0, 5),
        ),
      ],
    );
  }

  static BoxDecoration get cardDecoration => BoxDecoration(
    color: AppColors.cardWhite,
    borderRadius: BorderRadius.circular(28),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryGreen.withValues(alpha: 0.15),
        blurRadius: 30,
        spreadRadius: 0,
        offset: Offset(0, 15),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 10,
        spreadRadius: 0,
        offset: Offset(0, 5),
      ),
    ],
  );

  static InputDecoration fieldDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) => InputDecoration(
    hintText: hint,
    hintStyle: AppTextStyles.mutedText,
    prefixIcon: Icon(icon, color: AppColors.secondaryGreen, size: 20),
    suffixIcon: suffix,
    filled: true,
    fillColor: AppColors.fieldFill,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFDCEDC8), width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.secondaryGreen, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFE53935), width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFE53935), width: 2),
    ),
  );

  static BoxDecoration get gradientButton => BoxDecoration(
    gradient: AppColors.buttonGradient,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryGreen.withValues(alpha: 0.4),
        blurRadius: 15,
        offset: Offset(0, 6),
      ),
    ],
  );

  static BoxDecoration get socialButton => BoxDecoration(
    color: AppColors.cardWhite,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Color(0xFFDCEDC8), width: 1.5),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 8,
        offset: Offset(0, 3),
      ),
    ],
  );
}
