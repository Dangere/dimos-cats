import 'package:dimos_cats/view/painters/bezier_curve_painter.dart';
import 'package:flutter/material.dart';

class BezierCurve extends StatelessWidget {
  const BezierCurve({
    super.key,
    required this.t,
    required this.normalizedPoints,
    required this.size,
    this.flip = false,
  });

  final double t;
  final List<Offset> normalizedPoints;
  final Size size;
  final bool flip;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: size,
          willChange: true,
          painter: BezierCurvePainter(
            strokeWidth: 14,
            normalizedPoints: flip
                ? normalizedPoints.map((e) {
                    return Offset(1 - e.dx, e.dy);
                  }).toList()
                : normalizedPoints,
            t: t,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
