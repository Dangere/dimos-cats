import 'dart:typed_data';

import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/images_provider.dart';
import 'package:dimos_cats/view/widgets/cat_panel.dart';
import 'package:dimos_cats/view/widgets/shared/app_logo.dart';
import 'package:dimos_cats/view/widgets/shared/cat_tags_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dialogs {
  static Future<void> contentDialog(
    Widget content,
    BuildContext context,
  ) async {
    if (context.mounted == false) return;
    Navigator.push(
      context,
      TransparentPageRoute(builder: (context) => content),
    );
  }

  static Future<bool?> petDetailsDialog(Cat cat, BuildContext context) async {
    if (context.mounted == false) return null;
    Navigator.push(
      context,
      // TransparentPageRoute(builder: (context) => PetDetails(cat: cat)),
      TransparentPageRoute(
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: CatPanel(cat, onClick: () {}, shouldExpand: true),
        ),
      ),
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
      tween: Tween<double>(begin: 0, end: 15),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInExpo,

      builder: (BuildContext context, double value, Widget? child) {
        return Dialog(
          // constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: 400,

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
                  CatsTagList(cat: cat),
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
