import 'dart:ui' as ui;

import 'package:dimos_cats/view/clippers/mask_widget_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

/// Takes a path of an image to use as a mask and applies it to the child
class ImageMask extends StatelessWidget {
  const ImageMask({
    super.key,
    required this.maskAssetPath,
    required this.child,
    this.visualize = false,
    this.scale = 1,
  });

  final String maskAssetPath;
  final Widget child;
  final bool visualize;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MaskWidgetClipper(),
      child: FutureBuilder(
        future: loadUiImage(maskAssetPath),
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) return child;

          final myUiImage = asyncSnapshot.data!;
          return ShaderMask(
            blendMode: visualize ? BlendMode.saturation : BlendMode.dstIn,
            shaderCallback: (bounds) {
              // use the height and width from the constrains to make a matrix for the image to fit the screen

              final heightScale = bounds.height / myUiImage.height;
              final widthScale = bounds.width / myUiImage.width;

              final Matrix4 matrix = Matrix4.identity()
                ..translateByVector3(
                  vm.Vector3(
                    bounds.width * (1 - scale) / 2,
                    bounds.height * (1 - scale) / 2,
                    0,
                  ),
                )
                ..scaleByVector3(
                  vm.Vector3(widthScale * scale, heightScale * scale, 1),
                );

              return ImageShader(
                myUiImage,
                TileMode.decal,
                TileMode.decal,
                matrix.storage,
              );
            },
            child: child,
          );
        },
      ),
    );
  }

  Future<ui.Image> loadUiImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }
}
