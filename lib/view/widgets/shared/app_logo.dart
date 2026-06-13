import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: MemoryImage(kTransparentImage),
      image: AssetImage("assets/images/cat.png"),
      fit: BoxFit.cover,
      width: 50,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }
}
