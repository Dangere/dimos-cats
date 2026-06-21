import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/providers/cats_provider.dart';
import 'package:dimos_cats/providers/screen_size_provider.dart';
import 'package:dimos_cats/view/dialog/dialogs.dart';
import 'package:dimos_cats/view/widgets/cats_list_sliver.dart';
import 'package:dimos_cats/view/widgets/shared/app_logo.dart';
import 'package:dimos_cats/view/widgets/shared/error_panel.dart';
import 'package:dimos_cats/view/widgets/shared/language_toggle.dart';
import 'package:dimos_cats/view/widgets/shared/theme_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  double animationTarge = 1;

  @override
  Widget build(BuildContext context) {
    // List<String>? imagePaths = ref.watch(imagePathsProvider).value;
    AsyncValue cats = ref.watch(catsProvider);

    return Scaffold(
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
        surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
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
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // ref.read(screenSizeProvider.notifier).update(constraints.maxWidth);

          ScreenSize size = ref
              .read(screenSizeProvider.notifier)
              .getScreenSize(constraints.maxWidth);
          double padding = switch (size) {
            ScreenSize.compact => MediaQuery.of(context).size.width * 0.05,
            ScreenSize.medium => MediaQuery.of(context).size.width * 0.05,
            ScreenSize.expanded => MediaQuery.of(context).size.width * 0.08,
          };

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.primary.withValues(
                    alpha: 0.5,
                    blue: 0.7,
                    green: 0.2,
                    red: 0.1,
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: padding / 2,
                ),
                sliver: cats.when(
                  data: (cats) => CatsListSliver(
                    screenSize: size,
                    cats: cats,
                    onClick: (cat) {
                      // If we are on expanded or medium screen, open a dialog
                      if (size == ScreenSize.expanded ||
                          size == ScreenSize.medium) {
                        Dialogs.petDetailsDialog(cat, context);
                      }
                    },
                  ),
                  error: (error, stackTrace) => SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Center(
                        child: ErrorPanel(message: error.toString()),
                      ),
                    ),
                  ),
                  loading: () => SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      // body: Column(
      //   children: [
      //     Stack(
      //       clipBehavior: Clip.none,
      //       children: [
      //         Container(
      //           height: 200,
      //           width: MediaQuery.of(context).size.width,
      //           color: Theme.of(context).colorScheme.primary,
      //         ),

      //         // TweenAnimationBuilder(
      //         //   onEnd: () {
      //         //     setState(() {
      //         //       animationTarge = animationTarge == 1.0 ? 0.0 : 1.0;
      //         //     });
      //         //   },
      //         //   tween: Tween<double>(begin: 0, end: animationTarge),
      //         //   duration: const Duration(seconds: 1),
      //         //   builder: (context, value, child) {
      //         //     return Column(
      //         //       children: [
      //         //         BezierCurve(
      //         //           normalizedPoints: [
      //         //             Offset(-.2, 0.5),
      //         //             Offset(0.4, 0.7),
      //         //             Offset(0.7, 0.2),
      //         //             Offset(0.6, 1),

      //         //             Offset(1.2, 0.5),
      //         //           ],
      //         //           t: value,
      //         //           size: Size(MediaQuery.of(context).size.width, 300),
      //         //         ),
      //         //         BezierCurve(
      //         //           normalizedPoints: [
      //         //             Offset(-.2, 0.5),
      //         //             Offset(0.6, 0.3),
      //         //             Offset(0.2, 0.8),
      //         //             Offset(0.8, 1),

      //         //             Offset(1.2, 0.5),
      //         //           ],
      //         //           t: value,
      //         //           size: Size(MediaQuery.of(context).size.width, 300),
      //         //         ),
      //         //         BezierCurve(
      //         //           normalizedPoints: [
      //         //             Offset(1.2, 0.5),

      //         //             Offset(0.6, 0.3),
      //         //             Offset(0.2, 0.8),
      //         //             Offset(0.8, 1),
      //         //             Offset(-.2, 0.5),
      //         //           ],
      //         //           t: value,
      //         //           size: Size(MediaQuery.of(context).size.width, 300),
      //         //         ),
      //         //       ],
      //         //     );
      //         //   },
      //         // ),
      //         Padding(
      //           padding: EdgeInsets.symmetric(
      //             horizontal: MediaQuery.of(context).size.width * 0.1,
      //           ),
      //           child: cats.when(
      //             data: (cats) => CatsList(
      //               cats: cats,
      //               onClick: (cat) {
      //                 Dialogs.petDetailsDialog(cat, context);
      //               },
      //             ),
      //             error: (error, stackTrace) => SizedBox(
      //               height: MediaQuery.of(context).size.height / 1.5,
      //               child: Center(child: ErrorPanel(message: error.toString())),
      //             ),
      //             loading: () => SizedBox(
      //               height: MediaQuery.of(context).size.height / 1.5,
      //               child: Center(child: CircularProgressIndicator()),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }

  // CustomScrollView _expanded(BuildContext context, AsyncValue<dynamic> cats) {
  //   return CustomScrollView(
  //     slivers: [
  //       SliverToBoxAdapter(
  //         child: Container(
  //           height: 200,
  //           width: MediaQuery.of(context).size.width,
  //           color: Theme.of(context).colorScheme.primary,
  //         ),
  //       ),

  //       SliverPadding(
  //         padding: EdgeInsets.symmetric(
  //           horizontal: MediaQuery.of(context).size.width * 0.1,
  //         ),
  //         sliver: cats.when(
  //           data: (cats) => CatsListSliver(
  //             cats: cats,
  //             onClick: (cat) {
  //               Dialogs.petDetailsDialog(cat, context);
  //             },
  //           ),
  //           error: (error, stackTrace) => SliverToBoxAdapter(
  //             child: SizedBox(
  //               height: MediaQuery.of(context).size.height / 1.5,
  //               child: Center(child: ErrorPanel(message: error.toString())),
  //             ),
  //           ),
  //           loading: () => SliverToBoxAdapter(
  //             child: SizedBox(
  //               height: MediaQuery.of(context).size.height / 1.5,
  //               child: Center(child: CircularProgressIndicator()),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // CustomScrollView _compact(BuildContext context, AsyncValue<dynamic> cats) {
  //   return CustomScrollView(
  //     slivers: [
  //       SliverToBoxAdapter(
  //         child: Container(
  //           height: 200,
  //           width: MediaQuery.of(context).size.width,
  //           color: Theme.of(context).colorScheme.primary,
  //         ),
  //       ),

  //       SliverPadding(
  //         padding: EdgeInsets.symmetric(
  //           horizontal: MediaQuery.of(context).size.width * 0.1,
  //         ),
  //         sliver: cats.when(
  //           data: (cats) => CatsListSliver(
  //             cats: cats,
  //             onClick: (cat) {
  //               Dialogs.petDetailsDialog(cat, context);
  //             },
  //           ),
  //           error: (error, stackTrace) => SliverToBoxAdapter(
  //             child: SizedBox(
  //               height: MediaQuery.of(context).size.height / 1.5,
  //               child: Center(child: ErrorPanel(message: error.toString())),
  //             ),
  //           ),
  //           loading: () => SliverToBoxAdapter(
  //             child: SizedBox(
  //               height: MediaQuery.of(context).size.height / 1.5,
  //               child: Center(child: CircularProgressIndicator()),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  // );
  // }
}
