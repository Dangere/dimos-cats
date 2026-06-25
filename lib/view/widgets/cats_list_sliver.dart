import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/providers/screen_size_provider.dart';
import 'package:dimos_cats/view/widgets/cat_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatsListSliver extends ConsumerWidget {
  const CatsListSliver({
    super.key,
    required this.cats,
    required this.onClick,
    required this.screenSize,
  });

  final void Function(Cat cat) onClick;
  final List<Cat> cats;
  final ScreenSize screenSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(loggerProvider).d("Building CatsList");

    double spacing = switch (screenSize) {
      ScreenSize.compact => 25,
      ScreenSize.medium => 30,
      ScreenSize.expanded => 35,
    };
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: switch (screenSize) {
          ScreenSize.compact => 1,
          ScreenSize.medium => 2,
          ScreenSize.expanded => 3,
        },
        childAspectRatio: 352 / 315,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: cats.length,

      itemBuilder: (context, index) {
        // return Container();
        return CatPanel(
          screenSize: screenSize,
          cats[index],
          onClick: () {
            onClick(cats[index]);
          },
        );
      },
    );
  }
}
