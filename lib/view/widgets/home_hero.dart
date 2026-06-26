import 'package:dimos_cats/providers/screen_size_provider.dart';
import 'package:dimos_cats/view/widgets/shared/blob_decoration.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({super.key, required this.screenSize});

  final ScreenSize screenSize;

  @override
  Widget build(BuildContext context) {
    final lightMode = Theme.of(context).brightness == Brightness.light;
    // return Placeholder();

    return Stack(
      children: [
        Positioned.fill(
          child: FadeInImage(
            width: double.infinity,
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            placeholder: MemoryImage(kTransparentImage),
            image: AssetImage("assets/images/hero_background.jpg"),
          ),
        ),

        // SizedBox(height: 200, child: const Placeholder()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SizedBox(height: 370, width: 370)],
        ),
      ],
    );
  }
}
