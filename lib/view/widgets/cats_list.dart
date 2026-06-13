import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/view/dialog/dialogs.dart';
import 'package:dimos_cats/view/widgets/cat_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatsList extends ConsumerWidget {
  const CatsList({super.key, required this.cats});

  final List<Cat> cats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(loggerProvider).d("Building CatsList");

    return Wrap(
      textDirection: TextDirection.ltr,
      children: [
        for (var cat in cats)
          CatPanel(
            cat,
            onClick: () {
              Dialogs.petDetailsDialog(cat, context);
            },
          ),
      ],
    );
  }
}
