import 'dart:math';

import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/view/widgets/shared/bezier_curve.dart';
import 'package:dimos_cats/view/widgets/shared/blob_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

/// This widget will fill the entire background and will be animated on scroll and propagate the needed children to fill the background

class HomeBackground extends ConsumerStatefulWidget {
  const HomeBackground({super.key, required this.controller});

  final ScrollController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeBackgroundState();
}

class _HomeBackgroundState extends ConsumerState<HomeBackground> {
  // int offset = 0;
  // int maxOffset = 0;

  void _onScroll() {
    // int newOffset = widget.controller.offset.truncate();
    // if (offset != newOffset) {
    //   setState(() {
    //     offset = newOffset;
    //   });
    // }
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (widget.controller.hasClients) {
    //     maxOffset = widget.controller.position.maxScrollExtent.truncate();
    //   }
    // });
    // widget.controller.addListener(() => _onScroll());

    super.initState();
  }

  @override
  void dispose() {
    // widget.controller.removeListener(() => _onScroll());

    // TODO: implement dispose
    super.dispose();
  }

  // Presets for curves
  List<Offset> curvesPresets(int index) {
    List<List<Offset>> presets = [
      [
        Offset(-0.2, 0),
        Offset(0.1, 0.1),

        // Offset(0.6, 0.2),
        Offset(0.8, 1.3),
        // Offset(1, 1),
        Offset(1.2, 1),
      ],

      [
        Offset(-0.2, 0.8),
        Offset(0.3, 0.8),

        // Offset(0.6, 0.2),
        Offset(0.3, 0.22),
        Offset(0.7, 0.5),

        // Offset(1, 1),
        Offset(1.6, 1.5),
      ],
      [
        Offset(-0.7, 0.3),
        Offset(0.3, 1),

        // Offset(0.6, 0.2),
        // Offset(0.5, 0.),
        Offset(0.9, 0.4),

        // Offset(1, 1),
        Offset(1.2, 1),
      ],

      [
        Offset(-0.2, 0.8),
        Offset(0.5, 0.8),

        // Offset(0.6, 0.2),
        Offset(0.3, 0.1),
        // Offset(1, 1),
        Offset(1.6, 0.2),
      ],
    ];
    int loopedIndex = index % presets.length;

    return presets[loopedIndex];
  }

  List<bool> curvesState = [];

  @override
  Widget build(BuildContext context) {
    final curvesFillDuration = const Duration(milliseconds: 1200);
    final curvesFillCurve = Curves.easeInOutQuad;
    final int heightOfCurve = 400;
    final double visibilityPercentage = 0.1;

    final int heightOfBlob = 160;

    // double percentage = offset / maxOffset;
    // print(
    //   "Max offset:" +
    //       maxOffset.toString() +
    //       " Offset:" +
    //       offset.toString() +
    //       " Percentage:" +
    //       percentage.toString(),
    // );

    return LayoutBuilder(
      builder: (context, constraints) {
        ref.read(loggerProvider).d("Building HomeBackground");

        int amountOfCurvesToDisplay = (constraints.maxHeight / heightOfCurve)
            .toInt();

        int amountOfBlobsToDisplay =
            ((constraints.maxHeight / heightOfBlob) / 2).toInt();

        // Updating curves length based on the amount of curves to display
        if (curvesState.length != amountOfCurvesToDisplay) {
          curvesState = List.generate(
            amountOfCurvesToDisplay,
            (index) => false,
          );
        }

        return Stack(
          children: [
            // First const blob
            Positioned(
              top: -40,
              left: -50,
              child: SizedBox(height: 160, child: BlobDecoration(flip: true)),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  for (int i = 0; i < amountOfBlobsToDisplay - 3; i++)
                    Transform(
                      alignment: Alignment.center,
                      // makes a transform that moves the blob and gives it a random rotation using the i index
                      transform: Matrix4.identity()
                        ..translateByVector3(
                          vm.Vector3(
                            (i % 2 == 0 ? 1 : -1) *
                                MediaQuery.of(context).size.width /
                                2,
                            0,
                            0,
                          ),
                        )
                        ..rotateZ(i * 0.1 * pi)
                        ..scaleByVector3(
                          vm.Vector3(0.8, 1.3, 1.3) * (i % 3 == 1 ? 0.9 : 1.2),
                        ),
                      child: SizedBox(
                        height: 160,
                        child: BlobDecoration(
                          flip: i % 2 == 0,
                          index: i % 2 == 1 ? 0 : 1,
                        ),
                      ),
                    ),
                  Container(),
                ],
              ),
            ),
            // Last const blob
            Positioned(
              // :  0,
              bottom: -40,
              right: -50,
              child: SizedBox(height: 160, child: BlobDecoration(index: 1)),
            ),
            // Curves
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < amountOfCurvesToDisplay; i++)
                  VisibilityDetector(
                    key: Key(i.toString()),
                    onVisibilityChanged: (info) {
                      bool isVisible =
                          info.visibleFraction >= visibilityPercentage;

                      if (curvesState[i] != isVisible) {
                        setState(() {
                          curvesState[i] = isVisible;
                        });
                      }
                    },
                    // child: Text(i.toString()),
                    child: TweenAnimationBuilder(
                      duration: curvesFillDuration,
                      curve: curvesFillCurve,
                      tween: Tween<double>(
                        begin: 0,
                        end: curvesState[i] ? 1 : 0,
                      ),
                      builder: (context, value, child) {
                        return value == 0
                            ? Container(height: heightOfCurve.toDouble())
                            : BezierCurve(
                                flip: i % 2 == 0,
                                normalizedPoints: curvesPresets(i),
                                t: value,
                                size: Size(
                                  MediaQuery.of(context).size.width,
                                  heightOfCurve.toDouble(),
                                ),
                              );
                      },
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
