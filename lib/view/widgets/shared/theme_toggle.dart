import 'package:dimos_cats/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(preferencesProvider.notifier).toggleDarkMode();
      },
      icon: const Icon(Icons.dark_mode),
    );
  }
}
