import 'package:flutter/material.dart';

/// This widget will fill the entire background and will be animated on scroll and propagate the needed children to fill the background
class HomeBackgroundScrollAnimation extends StatefulWidget {
  const HomeBackgroundScrollAnimation({super.key});

  @override
  State<HomeBackgroundScrollAnimation> createState() =>
      _HomeBackgroundScrollAnimationState();
}

class _HomeBackgroundScrollAnimationState
    extends State<HomeBackgroundScrollAnimation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: Container(color: Colors.transparent))],
    );
  }
}
