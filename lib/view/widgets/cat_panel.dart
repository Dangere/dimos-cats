import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/providers/images_provider.dart';
import 'package:dimos_cats/view/widgets/shared/app_logo.dart';
import 'package:dimos_cats/view/widgets/shared/bezier_curve.dart';
import 'package:dimos_cats/view/widgets/shared/cat_tags_list.dart';
import 'package:dimos_cats/view/widgets/shared/error_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatPanel extends ConsumerStatefulWidget {
  const CatPanel(
    this.cat, {
    super.key,
    required this.onClick,
    this.shouldExpand = false,
  });
  final Cat cat;
  final VoidCallback onClick;
  final bool shouldExpand;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CatPanelState();
}

class _CatPanelState extends ConsumerState<CatPanel> {
  final Duration timeToExpandDuration = Duration(milliseconds: 50);
  final Duration timeToExpandDuration1 = Duration(milliseconds: 500);

  final Duration expandingDuration = Durations.long4;
  final Duration expandingDuration1 = Durations.extralong4;

  bool expand = false;
  bool expand1 = false;

  @override
  void initState() {
    if (widget.shouldExpand) {
      if (mounted == false) return;
      Future.delayed(timeToExpandDuration, () {
        if (mounted == false) return;

        setState(() {
          ref.read(loggerProvider).d("Expanding CatPanel");
          expand = true;
        });
      });

      Future.delayed(timeToExpandDuration1, () {
        if (mounted == false) return;

        setState(() {
          ref.read(loggerProvider).d("Second Expanding CatPanel");
          expand1 = true;
        });
      });
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size normalSize = const Size(350, 315);
    final Size expandedSize = const Size(500, 550);

    AsyncValue catImage = ref.watch(imageDataProvider(widget.cat.image));
    ref.read(loggerProvider).d("Building CatPanel");
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
      width: expand ? expandedSize.width : normalSize.width,
      height: expand ? expandedSize.height : normalSize.height,
      child: GestureDetector(
        onTap: widget.onClick,
        // This widget is important because when the "shouldExpand" is true, the widget will be first be closed then expanded, but when its closed it overflow so this is the solution
        child: OverflowBox(
          alignment: Alignment.topLeft,
          maxHeight: widget.shouldExpand
              ? expandedSize.height
              : normalSize.height,
          maxWidth: widget.shouldExpand ? expandedSize.width : normalSize.width,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // BezierCurve BACKGROUND
              if (widget.shouldExpand)
                TweenAnimationBuilder(
                  duration: expandingDuration1,
                  curve: Curves.easeOutCubic,
                  tween: Tween<double>(begin: 0, end: expand1 ? 1 : 0),

                  builder: (BuildContext context, double value, Widget? child) {
                    return BezierCurve(
                      normalizedPoints: [
                        Offset(-.2, 1),
                        Offset(0.4, 0.7),
                        Offset(0.7, 0.2),
                        Offset(0.6, 1),

                        Offset(1.2, 0),
                      ],
                      t: value,
                      size: Size(MediaQuery.of(context).size.width, 700),
                    );
                  },
                ),
              // BODY
              ClipRRect(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),

                  child: Column(
                    children: [
                      Flex(
                        direction: widget.shouldExpand
                            ? Axis.horizontal
                            : Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedSize(
                            duration: expandingDuration,
                            curve: Curves.easeInBack,
                            child: SizedBox(
                              height: widget.shouldExpand ? 260 : 190,
                              width: widget.shouldExpand ? 260 : 300,
                              child: Hero(
                                tag: widget.cat.image,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: catImage.when(
                                    data: (data) => data != null
                                        ? Image.memory(data, fit: BoxFit.cover)
                                        : const Center(child: AppLogo()),
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
                          SizedBox(width: 20, height: 20),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // NAME
                              Hero(
                                tag: widget.cat.name,
                                child: SizedBox(
                                  height: 25,
                                  child: Text(
                                    widget.cat.name,
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              // DESCRIPTION
                              if (widget.shouldExpand)
                                Text(
                                  widget.cat.description,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // TAGS
                      Row(
                        children: [
                          Expanded(child: CatsTagList(cat: widget.cat)),

                          if (widget.shouldExpand) Expanded(child: Container()),
                        ],
                      ),
                      // ADOPT BUTTON
                      if (widget.shouldExpand) ...[
                        Spacer(),
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                            ),
                            onPressed: () {},
                            child: Text(
                              AppLocalizations.of(context).adopt,
                              style: Theme.of(context).textTheme.titleMedium!
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
                    ],
                  ),
                ),
              ),

              // CLOSE BUTTON
              if (widget.shouldExpand)
                Positioned(
                  top: 0,
                  right: 0,
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
