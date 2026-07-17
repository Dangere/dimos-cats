import 'dart:math';

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
    final isLTR = Directionality.of(context) == TextDirection.ltr;

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
    // if we have three items per row we return left for the first, right for the second and right for the third
    AxisDirection? placementDirection(int index, int crossAxisCount) {
      if (crossAxisCount == 1) return null;

      AxisDirection? dir;

      if (crossAxisCount == 2) {
        dir = index % 2 == 0 ? AxisDirection.left : AxisDirection.right;
      }
      if (crossAxisCount == 3) {
        dir = index % 3 == 0
            ? AxisDirection.left
            : index % 3 == 1
            ? AxisDirection.right
            : AxisDirection.right;
      }

      if (isLTR) {
        return dir;
      } else {
        return dir == AxisDirection.left
            ? AxisDirection.right
            : AxisDirection.left;
      }
    }

    // if we have one item in the crossAxisCount, random small delay
    // if we have two items per row we return left two random delays
    // if we have three items per row,random small delay for the first, a small delay for the second and bigger delay for the third
    Duration placementDelay(int index, int crossAxisCount) {
      Random random = Random(index);

      int smallRandomDelayMaxMs = 100;
      int bigRandomDelayBaseMs = 200;

      int bigRandomDelayMaxMs = 100;

      if (crossAxisCount == 1 || crossAxisCount == 2) {
        return Duration(milliseconds: random.nextInt(smallRandomDelayMaxMs));
      }

      if (crossAxisCount == 3) {
        return index % 3 == 0
            ? Duration(milliseconds: random.nextInt(smallRandomDelayMaxMs))
            : index % 3 == 1
            ? Duration(milliseconds: random.nextInt(smallRandomDelayMaxMs))
            : Duration(
                milliseconds:
                    random.nextInt(bigRandomDelayMaxMs) + bigRandomDelayBaseMs,
              );
      }

      return Duration.zero;
    }

    Duration placementDuration() {
      return switch (screenSize) {
        ScreenSize.compact => Duration(milliseconds: 400),

        ScreenSize.medium => Duration(milliseconds: 600),

        ScreenSize.expanded => Duration(milliseconds: 800),
      };
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
          placementDuration: placementDuration(),
          placementDelay: placementDelay(index, crossAxisCount),
          placementDirection: placementDirection(index, crossAxisCount),
          screenSize: screenSize,
          cats[index],
          onClick: () => onClick(cats[index]),
        );
      },
    );
  }
}
