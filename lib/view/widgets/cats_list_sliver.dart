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

  final Future<void> Function(Cat cat) onClick;
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

    int crossAxisCount = switch (screenSize) {
      ScreenSize.compact => 1,
      ScreenSize.medium => 2,
      ScreenSize.expanded => 3,
    };

    // if we have one item in the crossAxisCount, we return null, which will randomize the placement direction from left to right
    // if we have two items per row we return left for the first and right for the second
    // if we have three items per row we return left for the first, center for the second and right for the third
    AxisDirection? placementDirection(int index, int crossAxisCount) {
      if (crossAxisCount == 1) return null;
      if (crossAxisCount == 2) {
        return index % 2 == 0 ? AxisDirection.left : AxisDirection.right;
      }
      if (crossAxisCount == 3) {
        return index % 3 == 0
            ? AxisDirection.left
            : index % 3 == 1
            ? AxisDirection.right
            : AxisDirection.right;
      }
      return null;
    }

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
          placementDirection: placementDirection(index, crossAxisCount),
          screenSize: screenSize,
          cats[index],
          onClick: () => onClick(cats[index]),
        );
      },
    );
  }
}
