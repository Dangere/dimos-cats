import 'dart:typed_data';
import 'dart:ui';

import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/images_provider.dart';
import 'package:dimos_cats/view/widgets/shared/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dialogs {
  static Future<bool?> petDetailsDialog(Cat cat, BuildContext context) async {
    if (context.mounted == false) return null;
    Navigator.push(
      context,
      TransparentPageRoute(builder: (context) => PetDetails(cat: cat)),
    );
    return null;
  }
}

class PetDetails extends ConsumerWidget {
  const PetDetails({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Uint8List? mainPicture = ref.watch(imageDataProvider(cat.image)).value;
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: false ? 15.0 : 0.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,

      builder: (BuildContext context, double value, Widget? child) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: value, sigmaY: value),

          child: Dialog(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),

            backgroundColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: cat.image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 300,
                          maxWidth: 300,
                        ),
                        child: mainPicture == null
                            ? const Center(child: AppLogo())
                            : Image.memory(mainPicture, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Hero(
                    tag: cat.name,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        cat.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TransparentPageRoute<T> extends PageRouteBuilder<T> {
  TransparentPageRoute({required WidgetBuilder builder, super.settings})
    : super(
        fullscreenDialog: true,
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
}
