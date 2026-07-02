import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, required this.loading, required this.child});

  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 1, end: loading ? 1 : 0),
          curve: Curves.fastOutSlowIn,
          duration: Durations.extralong3,
          builder: (context, value, child) {
            if (value == 0) {
              return Container();
            }

            double flippedValue = 1 - value;
            return IgnorePointer(
              ignoring: !loading,
              child: Transform.translate(
                offset: Offset(
                  0,
                  flippedValue * MediaQuery.of(context).size.height,
                ),
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  child: Center(
                    child: Lottie.asset(
                      height: 100,

                      'assets/animation/cat_loading.json',
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
