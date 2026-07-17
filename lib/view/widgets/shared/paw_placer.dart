import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PawController {
  final StreamController<void> _placeChildStream = StreamController.broadcast();
  final StreamController<void> _removeChildStream =
      StreamController.broadcast();

  Stream<void> get placeChildStream => _placeChildStream.stream;
  Stream<void> get removeChildStream => _removeChildStream.stream;

  bool childPlaced = false;

  void dispose() {
    _placeChildStream.close();
  }

  void placeChild() {
    childPlaced = true;
    _placeChildStream.add(null);
  }

  void removeChild() {
    childPlaced = false;
    _removeChildStream.add(null);
  }
}

class PawPlacer extends StatefulWidget {
  const PawPlacer({
    super.key,
    required this.child,
    this.randomizeDirection = true,
    this.initialOffset = 0,
    this.duration = Durations.long4,
    required this.placementDirection,
    required this.placementDelay,
    required this.controller,
  });

  final Widget child;

  /// Only applies when placementDirection is null
  final bool randomizeDirection;
  final AxisDirection placementDirection;
  final Duration placementDelay;
  final double initialOffset;
  final Duration duration;

  final PawController controller;

  @override
  State<PawPlacer> createState() => _PawPlacerState();
}

class _PawPlacerState extends State<PawPlacer> {
  late bool childPlaced;

  bool flipDirection = false;

  @override
  void initState() {
    if (widget.randomizeDirection) flipDirection = Random().nextBool();
    childPlaced = widget.controller.childPlaced;
    widget.controller.placeChildStream.listen((event) {
      placeChild(true);
    });
    widget.controller.removeChildStream.listen((event) {
      placeChild(false);
    });
    // Future.microtask(() async {
    //   while (true) {
    //     await Future.delayed(
    //       Duration(seconds: 3),
    //       () => placeChild(!childPlaced),
    //     );
    //   }
    // });

    super.initState();
  }

  void placeChild(bool place) async {
    if (place == childPlaced) return;
    if (!mounted) return;

    if (place) await Future.delayed(widget.placementDelay);
    setState(() {
      childPlaced = place;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double pawWidth = 400;
    final double pawHeight = 666;
    final double pawExtraOffset = 200;

    // double valuePercentage = 0.7;
    return TweenAnimationBuilder(
      duration: widget.duration,
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: childPlaced ? 0 : 2),

      builder: (context, value, child) {
        double valueForChild = (value - 1).clamp(0, 1);
        double valueForPaw = (value <= 1 ? (value - 1) : (1 - value));

        Offset childOffset = Offset(0, 0);
        Offset pawOffset = Offset(0, 0);
        switch (widget.placementDirection) {
          case AxisDirection.up:
            childOffset = Offset(0, -widget.initialOffset * valueForChild);
            pawOffset = Offset(
              0,
              (widget.initialOffset * valueForPaw) + pawExtraOffset,
            );
            break;
          case AxisDirection.down:
            childOffset = Offset(0, widget.initialOffset * valueForChild);
            pawOffset = Offset(
              0,
              (-widget.initialOffset * valueForPaw) + pawExtraOffset,
            );
            break;
          case AxisDirection.left:
            childOffset = Offset(-widget.initialOffset * valueForChild, 0);
            pawOffset = Offset(
              (widget.initialOffset * valueForPaw) - pawExtraOffset,
              0,
            );
            break;
          case AxisDirection.right:
            childOffset = Offset(widget.initialOffset * valueForChild, 0);
            pawOffset = Offset(
              (-widget.initialOffset * valueForPaw) + pawExtraOffset,
              0,
            );
            break;
        }

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Child
            Transform.translate(offset: childOffset, child: widget.child),

            // if (childPlaced)
            //   Positioned.fill(child: Container(color: Colors.red)),

            // Paw, pushed to the off bounds
            Positioned(
              height: pawHeight / 1.7,
              width: pawWidth / 1.7,
              // top: 0,
              // right: -100,
              // bottom: -200,
              // bottom: 0,
              // top: 0,
              child: Center(
                child: Transform.translate(
                  offset: pawOffset,

                  // right: -widget.initialOffset * valuePercentage,
                  // top: 0,
                  // bottom: 0,
                  child: Container(
                    clipBehavior: Clip.none,
                    // color: Colors.red,
                    child: Transform.flip(
                      flipY: widget.placementDirection == AxisDirection.right,
                      flipX: widget.placementDirection == AxisDirection.up,

                      child: Transform.rotate(
                        angle: widget.placementDirection == AxisDirection.left
                            ? pi / 2
                            : 3 / 2 * pi,
                        child: Center(
                          child: SizedBox(
                            height: pawHeight,
                            width: pawWidth,
                            child: FadeInImage(
                              height: pawHeight,
                              width: pawWidth,
                              placeholder: MemoryImage(kTransparentImage),
                              image: AssetImage("assets/images/reach_paw.png"),

                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// class _PawPlacerState extends State<PawPlacer> {
//   @override
//   Widget build(BuildContext context) {
//     assert(widget.value >= 0 && widget.value <= 2);

//     final double pawWidth = 400;
//     final double pawHeight = 666;

//     final double pawExtraOffset = 200;

//     double valueForChild = (widget.value - 1).clamp(0, 1);
//     double valueForPaw = (widget.value <= 1
//         ? (widget.value - 1)
//         : (1 - widget.value));

//     Offset childOffset = Offset(0, 0);
//     Offset pawOffset = Offset(0, 0);
//     switch (widget.direction) {
//       case AxisDirection.up:
//         childOffset = Offset(0, -widget.initialOffset * valueForChild);
//         pawOffset = Offset(
//           0,
//           (widget.initialOffset * valueForPaw) + pawExtraOffset,
//         );
//         break;
//       case AxisDirection.down:
//         childOffset = Offset(0, widget.initialOffset * valueForChild);
//         pawOffset = Offset(
//           0,
//           (-widget.initialOffset * valueForPaw) + pawExtraOffset,
//         );
//         break;
//       case AxisDirection.left:
//         childOffset = Offset(-widget.initialOffset * valueForChild, 0);
//         pawOffset = Offset(
//           (widget.initialOffset * valueForPaw) - pawExtraOffset,
//           0,
//         );
//         break;
//       case AxisDirection.right:
//         childOffset = Offset(widget.initialOffset * valueForChild, 0);
//         pawOffset = Offset(
//           (-widget.initialOffset * valueForPaw) + pawExtraOffset,
//           0,
//         );
//         break;
//     }

//     // valueForPaw = 0;

//     return Stack(
//       clipBehavior: Clip.none,
//       alignment: Alignment.center,
//       children: [
//         // Child
//         Transform.translate(offset: childOffset, child: widget.child),

//         // Paw, pushed to the off bounds
//         Positioned(
//           height: pawHeight / 1.7,
//           width: pawWidth / 1.7,

//           child: Center(
//             child: Transform.translate(
//               offset: pawOffset,

//               child: Container(
//                 clipBehavior: Clip.none,
//                 child: Transform.flip(
//                   flipY: widget.direction == AxisDirection.right,
//                   flipX: widget.direction == AxisDirection.up,

//                   child: Transform.rotate(
//                     angle: widget.direction == AxisDirection.left
//                         ? pi / 2
//                         : 3 / 2 * pi,
//                     child: Center(
//                       child: SizedBox(
//                         height: pawHeight,
//                         width: pawWidth,
//                         child: FadeInImage(
//                           height: pawHeight,
//                           width: pawWidth,
//                           placeholder: MemoryImage(kTransparentImage),
//                           image: AssetImage("assets/images/reach_paw.png"),

//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
