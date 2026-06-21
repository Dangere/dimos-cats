import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class BlobDecoration extends StatelessWidget {
  const BlobDecoration({
    super.key,
    this.flip = false,
    this.index = 0,
    this.fit = BoxFit.cover,
  });

  final bool flip;
  final int index;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: flip,
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: AssetImage("assets/images/blob$index.png"),

        fit: fit,
        width: null,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
