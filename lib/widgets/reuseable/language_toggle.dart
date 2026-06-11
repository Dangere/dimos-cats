import 'package:dimos_cats/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageToggle extends ConsumerWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(preferencesProvider.notifier).toggleLocale();
      },
      icon: Row(children: [Text("EN|عربي")]),
    );
  }
}
