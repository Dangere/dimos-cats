import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/providers/images_provider.dart';
import 'package:dimos_cats/view/widgets/shared/bezier_curve.dart';
import 'package:dimos_cats/view/widgets/shared/blob_decoration.dart';
import 'package:dimos_cats/view/widgets/shared/cat_tags_list.dart';
import 'package:dimos_cats/view/widgets/shared/error_panel.dart';
import 'package:dimos_cats/view/widgets/shared/images_displayer.dart';
import 'package:dimos_cats/view/widgets/shared/paw_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Expanding screen for compact screens
class CatPanelScreen extends ConsumerStatefulWidget {
  const CatPanelScreen(this.cat, {super.key, required this.onAdopt});
  final Cat cat;
  final VoidCallback onAdopt;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CatPanelScreenState();
}

class _CatPanelScreenState extends ConsumerState<CatPanelScreen> {
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

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double startingHeight = MediaQuery.of(context).size.height * 0.4;
    final double expandedHeight = MediaQuery.of(context).size.height * 0.7;

    AsyncValue catImage = ref.watch(imageDataProvider(widget.cat.image));

    final isLTR = Directionality.of(context) == TextDirection.ltr;

    ref.read(loggerProvider).d("Building CatPanel");

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        AnimatedContainer(
          clipBehavior: Clip.antiAlias,
          duration: expandingDuration,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          curve: Curves.easeInBack,

          // width: expand ? expandedSize.width : normalSize.width,
          height: expand ? expandedHeight : startingHeight,
          // This OverflowBox is needed to make the child expand beyond the normal size horizontally when its initially not expanded
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                // needed to remove two pixels from the bottom
                height: expandedHeight - 2,
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
                      bottom: 0,
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
                                  Offset(-0.4, 1),

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
                                  expandedHeight,
                                ),
                              );
                            },
                      ),
                    ),

                    // BODY
                    // if (false)
                    ClipRRect(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),

                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            // PICTURE AND NAME AND DESCRIPTION
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ImagesDisplayer(
                                        imagePaths: List.from(
                                          widget.cat.extendedImages,
                                        )..insert(0, widget.cat.image),
                                      ),
                                    ),
                                    // SizedBox(width: 20, height: 20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 24.0 / 2,
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),

                                          // DESCRIPTION
                                          Text(
                                            widget.cat.description,
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // TAGS AND ADOPT
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
                                      ],
                                    ),
                                  ),
                                  // ADOPT BUTTON
                                  SizedBox(
                                    width: 250,
                                    height: 60,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withValues(alpha: 0.5),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        AppLocalizations.of(context).adopt,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              fontSize: 26,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onPrimary,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // CLOSE BUTTON
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
