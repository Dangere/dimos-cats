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
    this.placementDirection,
    required this.controller,
  });

  final Widget child;

  /// Only applies when placementDirection is null
  final bool randomizeDirection;
  final AxisDirection? placementDirection;
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

    super.initState();
  }

  void placeChild(bool place) async {
    if (place == childPlaced) return;
    if (!mounted) return;
    setState(() {
      childPlaced = place;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double pawWidth = 400;
    final double pawHeight = 666;

    // double valuePercentage = 0.7;
    return TweenAnimationBuilder(
      duration: widget.duration,
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: childPlaced ? 0 : 2),

      builder: (context, value, child) {
        double valueForChild = (value - 1).clamp(0, 1);
        double valueForPaw = (value <= 1 ? (value - 1) : (1 - value));

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Child
            Transform.translate(
              offset: Offset(
                widget.initialOffset * valueForChild * (flipDirection ? -1 : 1),
                0,
              ),
              child: widget.child,
            ),

            Positioned(
              right: widget.placementDirection == AxisDirection.right
                  ? 0
                  : null,
              left: widget.placementDirection == AxisDirection.left ? 0 : null,
              top: widget.placementDirection == AxisDirection.up ? 0 : null,
              bottom: widget.placementDirection == AxisDirection.down
                  ? 0
                  : null,
              child: Icon(Icons.architecture_outlined),
            ),
            // Paw, pushed to the off bounds
            Positioned(
              height: pawHeight / 1.7,
              width: pawWidth / 1.7,

              child: Center(
                child: Transform.translate(
                  offset: Offset(
                    ((widget.initialOffset * -valueForPaw) + 200) *
                        (flipDirection ? -1 : 1),
                    0,
                  ),

                  child: Container(
                    clipBehavior: Clip.none,
                    child: Transform.flip(
                      flipY: !flipDirection,
                      child: Transform.rotate(
                        angle: flipDirection ? pi / 2 : 3 / 2 * pi,
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
