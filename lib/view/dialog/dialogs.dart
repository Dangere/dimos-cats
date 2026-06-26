import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/firebase_analytics_provider.dart';
import 'package:dimos_cats/providers/images_provider.dart'
    show imageDataProvider;
import 'package:dimos_cats/providers/screen_size_provider.dart';
import 'package:dimos_cats/view/widgets/cat_panel_expanding.dart';
import 'package:dimos_cats/view/widgets/cat_panel_screen.dart';
import 'package:dimos_cats/view/widgets/shared/error_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dialogs {
  static Future<bool?> petDetails(
    Cat cat,
    BuildContext context,
    WidgetRef ref,
    ScreenSize screenSize,
  ) async {
    if (context.mounted == false) return null;

    bool compactScreen = screenSize == ScreenSize.compact;

    ref.read(firebaseAnalyticsProvider.notifier).logCatProfileOpened(cat);

    await Navigator.push(
      context,
      TransparentPageRoute(
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(0),

          backgroundColor: Colors.transparent,
          child: !compactScreen
              ? CatPanelExpanding(cat, onAdopt: () {})
              : CatPanelScreen(cat, onAdopt: () {}),
        ),
      ),
    );

    return null;
  }

  static Future<bool?> petDetailsScreen(Cat cat, BuildContext context) async {
    if (context.mounted == false) return null;
    await Navigator.push(
      context,
      // TransparentPageRoute(builder: (context) => PetDetails(cat: cat)),
      TransparentPageRoute(
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: CatPanelExpanding(cat, onAdopt: () {}),
        ),
      ),
    );
    return null;
  }
}

class TransparentPageRoute<T> extends PageRouteBuilder<T> {
  TransparentPageRoute({required WidgetBuilder builder, super.settings})
    : super(
        fullscreenDialog: true,
        opaque: false,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
}
