import 'package:flutter/material.dart';

/// Clipper for the mask widget that adds extra height on the top of the widget along with subtracting a row of pixels at the bottom to remove an artifact
class MaskWidgetClipper extends CustomClipper<Path> {
  MaskWidgetClipper();

  @override
  Path getClip(Size size) {
    double extraHeight = 500;

    var path = Path();
    // Start at top-left (excluding the clipped region)
    path.moveTo(0, -extraHeight);
    // Draw straight to top-right
    path.lineTo(size.width, -extraHeight);
    // Draw straight to bottom-right
    path.lineTo(size.width, size.height - 1);
    // Draw straight to bottom-left
    path.lineTo(0, size.height - 1);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
