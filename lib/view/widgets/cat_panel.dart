import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/providers/images_provider.dart';
import 'package:dimos_cats/providers/screen_size_provider.dart';
import 'package:dimos_cats/view/widgets/shared/cat_tags_list.dart';
import 'package:dimos_cats/view/widgets/shared/error_panel.dart';
import 'package:dimos_cats/view/widgets/shared/paw_decoration.dart';
import 'package:dimos_cats/view/widgets/shared/paw_placer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Panel to display a cat, and when used to display the details page, it automatically blurs itself
/// And when its in view it reveals itself
class CatPanel extends ConsumerStatefulWidget {
  const CatPanel(
    this.cat, {
    super.key,
    required this.onClick,
    required this.screenSize,
  });
  final Future<void> Function() onClick;
  final Cat cat;
  final ScreenSize screenSize;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CatPanelState();
}

class _CatPanelState extends ConsumerState<CatPanel> {
  bool isMinimized = false;
  bool wasViewed = false;

  double viewThreshold = 0.3;
  double offsetBeforeReveal = 50;

  final PawController pawController = PawController();
  @override
  void dispose() {
    pawController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(loggerProvider).d("Building CatPanel");

    AsyncValue catImage = ref.watch(imageDataProvider(widget.cat.image));
    final isLTR = Directionality.of(context) == TextDirection.ltr;
    // return PawPlacer(
    //   initialOffset: MediaQuery.of(context).size.width,
    //   child: SizedBox(child: Container(color: Colors.blue)),
    // );

    Widget _body = ClipRRect(
      borderRadius: BorderRadius.circular(30),

      child: FrostedPanel(
        frost: isMinimized,
        child: GestureDetector(
          onTap: () async {
            if (isMinimized) return;

            setState(() {
              isMinimized = true;
            });
            await widget.onClick();

            setState(() {
              isMinimized = false;
            });
          },
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              // PAW
              Positioned(
                bottom: -40,
                right: isLTR ? -30 : null,
                left: isLTR ? null : -30,
                child: SizedBox(
                  height: 160,
                  child: PawDecoration(flip: !isLTR),
                ),
              ),

              // BODY
              Center(
                child: FractionallySizedBox(
                  alignment: Alignment.center,

                  widthFactor: 0.85,
                  heightFactor: 0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 2,
                        child: Hero(
                          tag: widget.cat.image,
                          child: ClipRRect(
                            child: Container(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                              child: catImage.when(
                                data: (data) => data != null
                                    ? Image.memory(data, fit: BoxFit.cover)
                                    : const Center(child: Icon(Icons.image)),
                                error: (error, stackTrace) =>
                                    ErrorPanel(message: error.toString()),
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      SizedBox(
                        height: 25,
                        child: Text(
                          widget.cat.name,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(flex: 1),
                      // TAGS
                      Row(
                        children: [
                          Expanded(
                            child: CatsTagList(cat: widget.cat, height: 25),
                          ),
                        ],
                      ),

                      // ADOPT BUTTON
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return VisibilityDetector(
      key: Key(widget.cat.name),
      onVisibilityChanged: (info) {
        bool placePanel = info.visibleFraction > viewThreshold;

        if (placePanel != wasViewed) {
          if (placePanel)
            pawController.placeChild();
          else
            pawController.removeChild();

          wasViewed = placePanel;
        }
      },
      child: PawPlacer(
        controller: pawController,
        initialOffset: MediaQuery.of(context).size.width,

        child: _body,
      ),
    );
  }
}

class FrostedPanel extends StatelessWidget {
  const FrostedPanel({super.key, required this.child, required this.frost});

  final Widget child;
  final bool frost;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!frost)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              // child: child,
            ),
          ),
        if (frost)
          Positioned.fill(
            child: LiquidGlassLens(
              style: LiquidGlassStyle(
                shape: LiquidGlassShape.squircle(
                  cornerRadius: 30,
                  lightIntensity: 1,
                  borderWidth: 1,
                  borderColor: Theme.of(context).colorScheme.outlineVariant,
                  // lightColor: Theme.of(context).colorScheme.primary,
                ),
                refraction: LiquidGlassRefraction(
                  distortion: 0.5,
                  distortionWidth: 30,
                  chromaticAberration: 0.03,
                  magnification: 0.9,
                ),
              ),
            ),
          ),
        child,
      ],
    );
  }
}
