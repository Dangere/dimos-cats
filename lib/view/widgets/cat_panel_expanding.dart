import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/cats_provider.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/view/widgets/shared/adopt_button.dart';
import 'package:dimos_cats/view/widgets/shared/bezier_curve.dart';
import 'package:dimos_cats/view/widgets/shared/blob_decoration.dart';
import 'package:dimos_cats/view/widgets/shared/cat_tags_list.dart';
import 'package:dimos_cats/view/widgets/shared/images_displayer.dart';
import 'package:dimos_cats/view/widgets/shared/paw_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Expanding panel for medium and large screens
class CatPanelExpanding extends ConsumerStatefulWidget {
  const CatPanelExpanding(this.cat, {super.key, required this.onAdopt});
  final Cat cat;
  final VoidCallback onAdopt;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CatPanelExpandingState();
}

class _CatPanelExpandingState extends ConsumerState<CatPanelExpanding> {
  final Duration timeToExpandDuration = Duration(milliseconds: 50);
  final Duration expandingDuration = Durations.long4;

  final Duration bezierCurveTimeToExpandDuration = Duration(milliseconds: 300);
  final Duration bezierCurveDuration = Durations.long4;

  bool expand = false;
  bool expandCurve = false;

  @override
  void initState() {
    if (mounted == false) return;
    Future.delayed(timeToExpandDuration, () {
      if (mounted == false) return;

      setState(() {
        ref.read(loggerProvider).d("Expanding CatPanel");
        expand = true;
      });
    });

    Future.delayed(bezierCurveTimeToExpandDuration, () {
      if (mounted == false) return;

      setState(() {
        ref.read(loggerProvider).d("Second Expanding CatPanel");
        expandCurve = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size startingSize = const Size(340, 340);
    final Size expandedSize = const Size(500, 500);

    final isLTR = Directionality.of(context) == TextDirection.ltr;

    ref.read(loggerProvider).d("Building CatPanel");
    void onAdopt() {
      ref.read(catsProvider.notifier).adoptCat(widget.cat).onError((
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

    return AnimatedContainer(
      clipBehavior: Clip.antiAlias,
      duration: expandingDuration,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      curve: Curves.easeInBack,

      width: expand ? expandedSize.width : startingSize.width,
      height: expand ? expandedSize.height : startingSize.height,
      // This OverflowBox is needed to make the child expand beyond the normal size horizontally when its initially not expanded
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: OverflowBox(
          alignment: isLTR ? Alignment.topLeft : Alignment.topRight,

          maxWidth: expandedSize.width,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  // needed to remove two pixels from the bottom
                  height: expandedSize.height - 2,
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
                      // BLOB
                      Positioned(
                        top: -40,
                        left: isLTR ? -50 : null,
                        right: isLTR ? null : -50,
                        child: SizedBox(
                          height: 160,
                          child: BlobDecoration(flip: isLTR),
                        ),
                      ),

                      // BezierCurve BACKGROUND
                      Positioned(
                        child: TweenAnimationBuilder(
                          duration: bezierCurveDuration,
                          curve: Curves.easeInCubic,

                          tween: Tween<double>(
                            begin: 0,
                            end: expandCurve ? 1 : 0,
                          ),

                          builder:
                              (
                                BuildContext context,
                                double value,
                                Widget? child,
                              ) {
                                return BezierCurve(
                                  flip: isLTR,
                                  normalizedPoints: [
                                    Offset(-0.6, 0.3),
                                    Offset(-0.2, 0.6),

                                    // Offset(-0.2, 0.8),
                                    Offset(0.1, 0.3),

                                    // Offset(0.6, 0.2),
                                    Offset(0.8, 1.05),
                                    // Offset(1, 1),
                                    Offset(1.2, 0.8),
                                  ],
                                  t: value,
                                  size: Size(
                                    MediaQuery.of(context).size.width,
                                    700,
                                  ),
                                );
                              },
                        ),
                      ),
                      // BODY
                      ClipRRect(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),

                          child: Center(
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: ImagesDisplayer(
                                          imagePaths: List.from(
                                            widget.cat.extendedImages,
                                          )..insert(0, widget.cat.image),
                                        ),
                                      ),
                                      // SizedBox(width: 20, height: 20),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0 / 2,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // NAME
                                            SizedBox(
                                              height: 25,
                                              child: Text(
                                                widget.cat.name,
                                                textAlign: TextAlign.left,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),

                                            // DESCRIPTION
                                            Text(
                                              widget.cat.description,
                                              textAlign: TextAlign.left,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // TAGS
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 24.0 / 2,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: CatsTagList(
                                                cat: widget.cat,
                                                // height: 25,
                                              ),
                                            ),

                                            Expanded(child: Container()),
                                          ],
                                        ),
                                      ),
                                      // ADOPT BUTTON
                                      AdoptButton(onTap: onAdopt),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // CLOSE BUTTON
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: isLTR ? 5 : null,
                left: isLTR ? null : 5,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    if (mounted == false) return;
                    setState(() {
                      if (context.mounted) Navigator.pop(context);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
