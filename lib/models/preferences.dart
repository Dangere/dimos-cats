import 'package:flutter/material.dart';

class Preferences {
  final bool darkMode;
  final Locale locale;

  Preferences({required this.darkMode, required this.locale});

  factory Preferences.defaults() {
    return Preferences(darkMode: false, locale: Locale('en'));
  }

  Preferences copyWith({bool? darkMode, Locale? locale}) {
    return Preferences(
      darkMode: darkMode ?? this.darkMode,
      locale: locale ?? this.locale,
    );
  }
}
