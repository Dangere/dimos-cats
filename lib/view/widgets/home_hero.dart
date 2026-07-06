import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/providers/screen_size_provider.dart';
import 'package:dimos_cats/view/widgets/home_hero_cat.dart';
import 'package:dimos_cats/view/widgets/shared/blob_decoration.dart';
import 'package:dimos_cats/view/widgets/shared/blob_text.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({super.key, required this.screenSize, required this.height});

  final ScreenSize screenSize;
  final double height;

  @override
  Widget build(BuildContext context) {
    final lightMode = Theme.of(context).brightness == Brightness.light;

    final bool verticalLayout = MediaQuery.of(context).size.width < height;
    // return Placeholder();
    var blobText = BlobText(
      blobVariant: 1,
      blobBody: AppLocalizations.of(context).hero_text_blob_why,
      blobTitle: AppLocalizations.of(context).why,
    );
    var blobText2 = BlobText(
      blobVariant: 0,
      blobBody: AppLocalizations.of(context).hero_text_blob_where,
      blobTitle: AppLocalizations.of(context).where,
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          // BACKGROUND IMAGE
          Positioned.fill(
            // constraints: BoxConstraints(maxHeight: height),
            child: Column(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 500),
                    child: FadeInImage(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      placeholder: MemoryImage(kTransparentImage),
                      image: AssetImage("assets/images/hero_background.jpg"),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // LayoutBuilder(
          //   builder: (context, constraints) {
          //     return Container();
          //   },
          // ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Flex(
              direction: verticalLayout ? Axis.vertical : Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 500,

                        child: blobText,
                      ),
                    ),
                  ),
                ),
                if (!verticalLayout) Spacer(flex: 1),
                // Cat
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HomeHeroCat(verticalLayout: verticalLayout),
                  ),
                ),
                if (!verticalLayout) Spacer(flex: 1),

                Flexible(
                  flex: 6,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        // height: constraints.maxHeight * 0.7,
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 500,

                        child: blobText2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
