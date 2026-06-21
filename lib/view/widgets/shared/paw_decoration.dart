import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PawDecoration extends StatelessWidget {
  const PawDecoration({super.key, this.flip = false});

  final bool flip;

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: flip,
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: AssetImage("assets/images/paw.png"),
        fit: BoxFit.cover,
        width: null,
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
    );
  }
}
