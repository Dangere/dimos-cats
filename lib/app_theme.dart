import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getTheme(bool darkMode) =>
      darkMode ? _darkTheme() : _lightTheme();

  static ThemeData _lightTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.almarai().fontFamily,

      colorScheme: .fromSeed(
        seedColor: Color(0xFFfaeab4),
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData _darkTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.almarai().fontFamily,

      colorScheme: .fromSeed(
        seedColor: Color(0xFFfaeab4),
        brightness: Brightness.dark,
      ),
    );
  }
}
