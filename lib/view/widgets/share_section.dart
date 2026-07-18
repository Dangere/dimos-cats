import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/models/enums/platform_share.dart';
import 'package:dimos_cats/providers/share_provider.dart';
import 'package:dimos_cats/view/widgets/shared/blob_decoration.dart';
import 'package:dimos_cats/view/widgets/shared/image_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class ShareSection extends ConsumerWidget {
  const ShareSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double verticalLayoutCatSize =
        200 * (MediaQuery.of(context).size.height / 750);

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

    return SizedBox(
      height: 550,
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(20.0),

        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: BlobDecoration(
                index: 2,
                color: Theme.of(context).colorScheme.surface,
                fit: BoxFit.fill,
              ),
            ),
            Positioned.fill(
              child: ImageMask(
                // visualize: true,
                maskAssetPath: "assets/images/blob2.png",
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
                  ],
                ),
              ),
            ),

            Positioned.fill(
              child: FractionallySizedBox(
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
                        style: Theme.of(context).textTheme.headlineLarge!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),

                      const Spacer(flex: 1),
                      // Description
                      Text(
                        AppLocalizations.of(context).cant_adopt1,
                        textAlign: TextAlign.center,

                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Spacer(flex: 2),

                      // Share buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image(
                              height: 50,
                              image: const AssetImage(
                                "assets/images/icons/whatsapp.png",
                              ),
                            ),
                            onPressed: () => onShare(PlatformShare.whatsapp),
                          ),
                          IconButton(
                            icon: Image(
                              height: 50,
                              filterQuality: FilterQuality.high,
                              isAntiAlias: true,

                              image: const AssetImage(
                                "assets/images/icons/facebook.png",
                              ),
                            ),
                            onPressed: () => onShare(PlatformShare.facebook),
                          ),
                          IconButton(
                            icon: Image(
                              height: 50,
                              isAntiAlias: true,
                              filterQuality: FilterQuality.high,
                              image: const AssetImage(
                                "assets/images/icons/discord.png",
                              ),
                            ),
                            onPressed: onCopyToClipboard,
                          ),
                          IconButton(
                            icon: Image(
                              height: 40,
                              image: const AssetImage(
                                "assets/images/icons/copy.png",
                              ),
                            ),
                            onPressed: onCopyToClipboard,
                          ),
                        ],
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
