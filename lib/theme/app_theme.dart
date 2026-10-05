import 'package:flutter/material.dart';

/// Uni-Sphere unified theme system.
/// Implements the exact university palette requested and matches the PDF aesthetics:
/// - Primary Dark Navy: #03045E
/// - Primary Blue:      #0077B6
/// - Cyan:              #00B4D8
/// - Light Cyan:        #90E0EF
/// - Very Light Cyan:   #CAF0F8
/// - Warm sand/cream background matching the PDF
class AppTheme {
  // Brand color palette
  static const Color primaryDarkNavy = Color(0xFF03045E);
  static const Color primaryBlue = Color(0xFF0077B6);
  static const Color cyan = Color(0xFF00B4D8);
  static const Color lightCyan = Color(0xFF90E0EF);
  static const Color veryLightCyan = Color(0xFFCAF0F8);

  // Background and surface colors matching the PDF
  static const Color backgroundLight = Color(0xFFF7F5F0);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceWarm = Color(0xFFEFECE6);
  static const Color cardBorder = Color(0xFFE7E3DC);

  // Typography colors
  static const Color textDark = Color(0xFF1E1E24);
  static const Color textSecondary = Color(0xFF76716B);
  static const Color textMuted = Color(0xFFA8A29E);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Accent & status colors from the PDF
  static const Color accentMaroon = Color(0xFF38182F);
  static const Color accentBurgundy = Color(0xFF4A1E35);
  static const Color urgentRed = Color(0xFFE63946);
  static const Color urgentRedLight = Color(0xFFFFECEF);
  static const Color safeGreen = Color(0xFF2A9D8F);
  static const Color safeGreenLight = Color(0xFFE8F6F3);
  static const Color warningAmber = Color(0xFFE76F51);
  static const Color warningAmberLight = Color(0xFFFFF2ED);
  static const Color infoBlueLight = Color(0xFFE8F4F8);

  // Radii
  static const double cardRadius = 22.0;
  static const double smallRadius = 12.0;
  static const double pillRadius = 30.0;

  // Soft shadows
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: const Color(0x0D1C1917),
      blurRadius: 18,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: const Color(0x0A000000),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  // Gradients for course cards & banners
  static const LinearGradient darkCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2A1B28), Color(0xFF3E2338), Color(0xFF03045E)],
  );

  static const LinearGradient blueCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF283B8B), Color(0xFF0077B6), Color(0xFF00B4D8)],
  );

  static const LinearGradient primaryNavyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDarkNavy, primaryBlue],
  );

  // Light Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundLight,
      primaryColor: primaryDarkNavy,
      colorScheme: const ColorScheme.light(
        primary: primaryDarkNavy,
        secondary: primaryBlue,
        tertiary: cyan,
        surface: surfaceWhite,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textDark,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDarkNavy,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(pillRadius),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDarkNavy,
          side: const BorderSide(color: cardBorder, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(pillRadius),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(pillRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(pillRadius),
          borderSide: const BorderSide(color: cardBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(pillRadius),
          borderSide: const BorderSide(color: primaryBlue, width: 1.5),
        ),
        hintStyle: const TextStyle(color: textMuted, fontSize: 14),
      ),
    );
  }

  // Dark Theme Configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF12141C),
      primaryColor: cyan,
      colorScheme: const ColorScheme.dark(
        primary: cyan,
        secondary: lightCyan,
        tertiary: veryLightCyan,
        surface: Color(0xFF1E2230),
        onPrimary: primaryDarkNavy,
        onSecondary: primaryDarkNavy,
        onSurface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF12141C),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E2230),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
      ),
    );
  }
}
