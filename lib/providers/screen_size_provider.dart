import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenSizeNotifier extends Notifier<ScreenSize> {
  final double wCompact = 600;

  final double wMedium = 1024;
  ScreenSize getScreenSize(double width) {
    if (width < wCompact) {
      return ScreenSize.compact;
    }

    if (width < wMedium) {
      return ScreenSize.medium;
    }
    return ScreenSize.expanded;
  }

  @override
  ScreenSize build() {
    return ScreenSize.compact;
  }
}

final screenSizeProvider = NotifierProvider<ScreenSizeNotifier, ScreenSize>(
  ScreenSizeNotifier.new,
);

enum ScreenSize { compact, medium, expanded }
