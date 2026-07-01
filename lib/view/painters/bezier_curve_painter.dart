import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BezierCurvePainter extends CustomPainter {
  final double t;
  final Color color;
  final List<Offset> normalizedPoints;

  final double strokeWidth;
  BezierCurvePainter({
    required this.t,
    required this.color,
    required this.normalizedPoints,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final points = normalizedPoints
        .map((point) => Offset(point.dx * size.width, point.dy * size.height))
        .toList();

    final path = Path()..moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      path.quadraticBezierTo(
        points[i].dx,
        points[i].dy,
        (points[i].dx + points[i + 1].dx) / 2,
        (points[i].dy + points[i + 1].dy) / 2,
      );
    }

    path.lineTo(points.last.dx, points.last.dy);

    for (final metric in path.computeMetrics()) {
      final drawn = metric.extractPath(0, metric.length * t);
      canvas.drawPath(drawn, paint);
    }

    // if (kDebugMode) {
    //   for (final point in points) {
    //     canvas.drawCircle(point, 5, paint);
    //   }
    // }
    // if (kDebugMode) {
    //   canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is BezierCurvePainter) {
      return oldDelegate.t != t;
    }
    return true;
  }
}
