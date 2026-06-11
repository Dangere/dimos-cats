import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/cat.png",
      fit: BoxFit.cover,
      width: 50,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
