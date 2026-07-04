import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/cats_provider.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/providers/init_provider.dart';
import 'package:dimos_cats/providers/screen_size_provider.dart';
import 'package:dimos_cats/view/dialog/dialogs.dart';
import 'package:dimos_cats/view/widgets/cats_list_sliver.dart';
import 'package:dimos_cats/view/widgets/home_hero.dart';
import 'package:dimos_cats/view/widgets/shared/app_logo.dart';
import 'package:dimos_cats/view/widgets/shared/error_panel.dart';
import 'package:dimos_cats/view/widgets/home_background.dart';
import 'package:dimos_cats/view/widgets/shared/language_toggle.dart';
import 'package:dimos_cats/view/widgets/shared/loading_screen.dart';
import 'package:dimos_cats/view/widgets/shared/theme_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  double initialScrollOffset = 600;
  bool initiationComplete = false;
  late final ScrollController controller;

  @override
  void initState() {
    controller = ScrollController(initialScrollOffset: initialScrollOffset);
    super.initState();
  }

  double animationTarge = 1;
  // List<Cat> catsTemp = List.generate(
  //   10,
  //   (index) => Cat.empty(index.toString() + "cat"),
  // );
  ScreenSize size = ScreenSize.expanded;

  Cat? viewedCat;

  /// Used to open the details dialog
  Future<void> viewCatDetails(Cat cat) async {
    if (context.mounted == false || viewedCat != null) return;

    viewedCat = cat;
    await Dialogs.petDetails(cat, context, ref, size);
    viewedCat = null;
  }

  /// Used to reopen the details dialog when screen size changes
  void reOpenDetailsOnSize(ScreenSize currentSize, ScreenSize newSize) {
    if (viewedCat == null) return;
    // If we are changing from compact to expanded/medium, or the opposite, we reopen the details dialog
    if (newSize == ScreenSize.compact && currentSize != ScreenSize.compact ||
        newSize != ScreenSize.compact && currentSize == ScreenSize.compact) {
      Cat currentViewedCat = viewedCat!.copyWith();
      Navigator.of(context).pop();

      Future.delayed(Durations.medium2, () {
        viewCatDetails(currentViewedCat);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<String>? imagePaths = ref.watch(imagePathsProvider).value;
    AsyncValue<List<Cat>> cats = ref.watch(catsProvider);
    ref.read(loggerProvider).d("Building HomePage");

    bool isInitializing = ref.watch(initProvider(context)).isLoading;

    // When initializing, we scroll to the top because we start at an offset
    if (!isInitializing && !initiationComplete) {
      initiationComplete = true;
      controller.animateTo(
        -initialScrollOffset,
        duration: Duration(milliseconds: 3000),
        curve: Curves.easeOutCubic,
      );
    }
    return LoadingScreen(
      loading: isInitializing,
      child: Scaffold(
        drawer: Drawer(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          width: 200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 12),

                  Text(AppLocalizations.of(context).language),
                  Spacer(),

                  LanguageToggle(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  SizedBox(width: 12),
                  Text(AppLocalizations.of(context).theme),
                  Spacer(),
                  ThemeToggle(),
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          // forceMaterialTransparency: true,
          centerTitle: true,
          toolbarHeight: 60,
          shape: Border(
            bottom: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant, // Outline color
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppLogo(),
              SizedBox(width: 10),
              Text(AppLocalizations.of(context).home),
              // IconButton(
              //   onPressed: () {
              //     ref.invalidate(initProvider(context));
              //   },
              //   icon: Icon(Icons.replay_outlined),
              // ),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // ref.read(screenSizeProvider.notifier).update(constraints.maxWidth);
            ref.read(loggerProvider).d("Building HomePage from layout");
            ScreenSize newSize = ref
                .read(screenSizeProvider.notifier)
                .getScreenSize(constraints.maxWidth);

            reOpenDetailsOnSize(size, newSize);

            size = newSize;
            double padding = switch (size) {
              ScreenSize.compact => MediaQuery.of(context).size.width * 0.05,
              ScreenSize.medium => MediaQuery.of(context).size.width * 0.05,
              ScreenSize.expanded => MediaQuery.of(context).size.width * 0.08,
            };

            final double heroHeight = size != ScreenSize.expanded
                ? constraints.maxHeight
                : 400;

            return Stack(
              children: [
                CustomScrollView(
                  controller: controller,
                  cacheExtent: 3500,
                  shrinkWrap: false,

                  slivers: [
                    SliverResizingHeader(
                      minExtentPrototype: const SizedBox(height: 0),
                      maxExtentPrototype: SizedBox(height: heroHeight),
                      child: HomeHero(height: heroHeight, screenSize: size),
                    ),
                    // LIST AND GRAPHIC
                    SliverStack(
                      children: [
                        // BACKGROUND GRAPHIC
                        SliverPositioned.fill(
                          child: HomeBackground(controller: controller),
                        ),

                        // LIST
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: padding,
                            vertical: size != ScreenSize.expanded
                                ? padding
                                : padding / 2,
                          ),
                          sliver: cats.when(
                            data: (cats) => CatsListSliver(
                              screenSize: size,
                              cats: cats,
                              onClick: (cat) => viewCatDetails(cat),
                            ),
                            error: (error, stackTrace) => SliverToBoxAdapter(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child: Center(
                                  child: ErrorPanel(message: error.toString()),
                                ),
                              ),
                            ),
                            loading: () => SliverToBoxAdapter(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Is there to fill the remaining space so the list expands properly when its not full
                        SliverFillRemaining(hasScrollBody: false),
                      ],
                    ),
                    // FOOTER
                    SliverToBoxAdapter(
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
