import 'dart:ui' as ui;

import 'package:dimos_cats/view/clippers/mask_widget_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

/// Takes a path of an image to use as a mask and applies it to the child
class ImageMask extends StatefulWidget {
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
  State<ImageMask> createState() => _ImageMaskState();
}

class _ImageMaskState extends State<ImageMask> {
  ui.Image? loadedImage;

  @override
  void initState() {
    loadUiImage(widget.maskAssetPath).then((value) {
      setState(() {
        loadedImage = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MaskWidgetClipper(),
      child: loadedImage == null
          ? Container()
          : ShaderMask(
              blendMode: widget.visualize
                  ? BlendMode.saturation
                  : BlendMode.dstIn,
              shaderCallback: (bounds) {
                // use the height and width from the constrains to make a matrix for the image to fit the screen

                final heightScale = bounds.height / loadedImage!.height;
                final widthScale = bounds.width / loadedImage!.width;

                final Matrix4 matrix = Matrix4.identity()
                  ..translateByVector3(
                    vm.Vector3(
                      bounds.width * (1 - widget.scale) / 2,
                      bounds.height * (1 - widget.scale) / 2,
                      0,
                    ),
                  )
                  ..scaleByVector3(
                    vm.Vector3(
                      widthScale * widget.scale,
                      heightScale * widget.scale,
                      1,
                    ),
                  );

                return ImageShader(
                  loadedImage!,
                  TileMode.decal,
                  TileMode.decal,
                  matrix.storage,
                );
              },
              child: widget.child,
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
