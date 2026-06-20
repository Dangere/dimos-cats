import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getTheme(bool darkMode) =>
      darkMode ? _darkTheme() : _lightTheme();

  static ThemeData _lightTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.almarai().fontFamily,
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(padding: const EdgeInsets.all(12)),
      ),

      colorScheme: .fromSeed(
        seedColor: Color(0xFF92A2FF),
        primary: Color(0xFF92A2FF),
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData _darkTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.almarai().fontFamily,
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(padding: const EdgeInsets.all(12)),
      ),
      colorScheme: .fromSeed(
        seedColor: Color(0xFF92A2FF),
        primary: Color(0xFF92A2FF),

        brightness: Brightness.dark,
      ),
    );
  }
}
