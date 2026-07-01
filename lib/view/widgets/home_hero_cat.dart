import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/view/clippers/mask_widget_clipper.dart';
import 'package:dimos_cats/view/widgets/shared/image_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeHeroCat extends ConsumerStatefulWidget {
  const HomeHeroCat({super.key, required this.verticalLayout});

  final bool verticalLayout;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeHeroCatState();
}

class _HomeHeroCatState extends ConsumerState<HomeHeroCat> {
  @override
  Widget build(BuildContext context) {
    ref.read(loggerProvider).d("Building HomeHeroCat");

    double verticalLayoutCatSize =
        300 * (MediaQuery.of(context).size.height / 800);

    return ClipPath(
      // Applying the widget's mask clipper here too because otherwise there would be an extra row of pixels not clipped from the stack
      clipper: MaskWidgetClipper(),
      child: SizedBox(
        height: 300,
        // width: 300,
        child: FractionallySizedBox(
          heightFactor: 1.6,
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              // fit: StackFit.expand,
              children: [
                // Container(height: 200),
                Positioned.fill(
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage("assets/images/hero_cat_blob.png"),

                    fit: BoxFit.fill,
                  ),
                ),
                if (widget.verticalLayout)
                  Positioned.fill(
                    child: ImageMask(
                      // visualize: true,
                      maskAssetPath: "assets/images/hero_cat_mask.png",
                      child: Align(
                        alignment: AlignmentGeometry.bottomCenter,
                        child: SizedBox(
                          height: verticalLayoutCatSize,
                          child: Stack(
                            alignment: AlignmentGeometry.topCenter,
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Positioned(
                                top: 0,
                                height: verticalLayoutCatSize,
                                child: SizedBox(
                                  height: verticalLayoutCatSize,
                                  child: FadeInImage(
                                    placeholder: MemoryImage(kTransparentImage),

                                    image: AssetImage(
                                      "assets/images/hero_cat.png",
                                    ),
                                    // image: AssetImage("assets/images/hero_background.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (!widget.verticalLayout)
                  Positioned.fill(
                    child: ImageMask(
                      // visualize: true,
                      maskAssetPath: "assets/images/hero_cat_mask.png",
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 230,
                          // height: 300,
                          child: FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),

                            image: AssetImage("assets/images/hero_cat.png"),
                            // image: AssetImage("assets/images/hero_background.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
