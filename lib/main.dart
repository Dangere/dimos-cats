import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/models/preferences.dart';
import 'package:dimos_cats/view/pages/home_page.dart';
import 'package:dimos_cats/providers/preferences_provider.dart';
import 'package:dimos_cats/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() async {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Preferences preferences = ref.watch(preferencesProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: preferences.locale,
      title: "Dimo's Cats",
      theme: AppTheme.getTheme(preferences.darkMode),
      home: const HomePage(),
    );
  }
}
