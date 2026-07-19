import 'dart:math' as math;

import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/models/enums/platform_share.dart';
import 'package:dimos_cats/providers/share_provider.dart';
import 'package:dimos_cats/view/widgets/shared/blob_decoration.dart';
import 'package:dimos_cats/view/widgets/shared/image_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ShareSection extends ConsumerStatefulWidget {
  const ShareSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShareSectionState();
}

class _ShareSectionState extends ConsumerState<ShareSection> {
  double targetEndAnimation = 1;

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    double verticalLayoutCatSize =
        200 * (MediaQuery.of(context).size.height / 900);

    void onShare(PlatformShare platform) {
      ref.read(sharesProvider.notifier).shareTo(platform).onError((
        error,
        stackTrace,
      ) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        }
      });
    }

    void onCopyToClipboard() {
      ref.read(sharesProvider.notifier).copyToClipboard();
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Copied to clipboard (ﾉ*ФωФ)ﾉ !")),
        );
      }
    }

    void playExpandAnimation() {
      setState(() {
        targetEndAnimation = 1;
      });
    }

    void resetAnimation() {
      setState(() {
        targetEndAnimation = 0.05;
      });
    }

    return SizedBox(
      height: 550,
      child: VisibilityDetector(
        key: const Key("shareSection"),
        onVisibilityChanged: (info) {
          bool isInView = info.visibleFraction > 0.2;
          if (isVisible != isInView) {
            isVisible = isInView;
            if (isVisible) {
              playExpandAnimation();
            } else {
              resetAnimation();
            }
          }
        },
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.all(20.0),

          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              // Positioned.fill(
              //   child: BlobDecoration(
              //     index: 2,
              //     color: Theme.of(context).colorScheme.primary,
              //     fit: BoxFit.fill,
              //   ),
              // ),
              Positioned.fill(
                child: TweenAnimationBuilder(
                  onEnd: () {
                    // setState(() {
                    //   targetAnimation = targetAnimation == 0 ? 1 : 0;
                    // });
                  },
                  tween: Tween<double>(begin: 0.05, end: targetEndAnimation),
                  duration: const Duration(seconds: 2),
                  curve: Curves.bounceOut,

                  child: Container(
                    color: Theme.of(context).colorScheme.onPrimary,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: -10,
                          right: MediaQuery.of(context).size.width * 0.1,
                          child: Lottie.asset(
                            height: verticalLayoutCatSize,

                            'assets/animation/cat_loading.json',
                          ),
                        ),
                        FractionallySizedBox(
                          heightFactor: 0.8,
                          widthFactor: 0.9,
                          child: Container(
                            // color: Colors.red,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Spacer(flex: 2),
                                // Title
                                Text(
                                  AppLocalizations.of(context).cant_adopt,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                ),

                                const Spacer(flex: 1),
                                // Description
                                Text(
                                  AppLocalizations.of(context).cant_adopt1,
                                  textAlign: TextAlign.center,

                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                ),
                                const Spacer(flex: 2),

                                // Share buttons
                                ShareButtons(
                                  onCopyToClipboard: onCopyToClipboard,
                                  onShare: onShare,
                                ),
                                const Spacer(flex: 2),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  builder: (context, value, child) {
                    print(value);
                    return ImageMask(
                      scale: value,
                      // visualize: true,
                      maskAssetPath: "assets/images/blob2.png",
                      child: child!,
                    );
                  },
                ),
              ),

              // Positioned.fill(
              //   child:
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareButtons extends StatefulWidget {
  const ShareButtons({
    super.key,
    required this.onShare,
    required this.onCopyToClipboard,
  });

  final Function(PlatformShare) onShare;
  final VoidCallback onCopyToClipboard;

  @override
  State<ShareButtons> createState() => _ShareButtonsState();
}

class _ShareButtonsState extends State<ShareButtons> {
  double targetAnimation = 4;

  bool playAnimation = false;

  @override
  Widget build(BuildContext context) {
    double calculateValue(double x, int index) {
      double value = x.clamp(index, index + 1) - index.toDouble();

      // math.pi makes a full half-circle wave from 0 -> 1 -> 0
      return math.sin(value * math.pi);
    }

    print("Building share buttons");
    // int highlightPeriodMs = 1000;
    return TweenAnimationBuilder(
      onEnd: () {
        setState(() {
          targetAnimation = targetAnimation == 0 ? 4 : 0;
        });
      },
      duration: Duration(seconds: 3),
      curve: Curves.linearToEaseOut,
      tween: Tween<double>(begin: 0, end: targetAnimation),
      builder: (context, value, child) {
        double firstButtonValue = calculateValue(value, 0);
        double secondButtonValue = calculateValue(value, 1);

        double thirdButtonValue = calculateValue(value, 2);
        double forthButtonValue = calculateValue(value, 3);
        // print(value);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, -10 * firstButtonValue),
              child: IconButton(
                icon: Image(
                  height: 50,
                  image: const AssetImage("assets/images/icons/whatsapp.png"),
                ),
                onPressed: () => widget.onShare(PlatformShare.whatsapp),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -10 * secondButtonValue),

              child: IconButton(
                icon: Image(
                  height: 50,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,

                  image: const AssetImage("assets/images/icons/facebook.png"),
                ),
                onPressed: () => widget.onShare(PlatformShare.facebook),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -10 * thirdButtonValue),

              child: IconButton(
                icon: Image(
                  height: 50,
                  isAntiAlias: true,
                  filterQuality: FilterQuality.high,
                  image: const AssetImage("assets/images/icons/discord.png"),
                ),
                onPressed: widget.onCopyToClipboard,
              ),
            ),
            Transform.translate(
              offset: Offset(0, -10 * forthButtonValue),

              child: IconButton(
                icon: Image(
                  height: 40,
                  image: const AssetImage("assets/images/icons/copy.png"),
                ),
                onPressed: widget.onCopyToClipboard,
              ),
            ),
          ],
        );
      },
    );
  }
}
