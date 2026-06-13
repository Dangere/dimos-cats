import 'package:dimos_cats/models/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier for [Preferences] that is used to toggle dark mode and locale
class PreferencesNotifier extends Notifier<Preferences> {
  void toggleDarkMode() {
    state = state.copyWith(darkMode: !state.darkMode);
  }

  void toggleLocale() {
    if (state.locale == const Locale('en')) {
      state = state.copyWith(locale: const Locale('ar'));
    } else {
      state = state.copyWith(locale: const Locale('en'));
    }
  }

  @override
  build() {
    return Preferences.defaults();
  }
}

final preferencesProvider = NotifierProvider<PreferencesNotifier, Preferences>(
  PreferencesNotifier.new,
);
