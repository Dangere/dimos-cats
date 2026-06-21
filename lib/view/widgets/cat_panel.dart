import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/providers/images_provider.dart';
import 'package:dimos_cats/providers/screen_size_provider.dart';
import 'package:dimos_cats/view/widgets/shared/app_logo.dart';
import 'package:dimos_cats/view/widgets/shared/cat_tags_list.dart';
import 'package:dimos_cats/view/widgets/shared/error_panel.dart';
import 'package:dimos_cats/view/widgets/shared/paw_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatPanel extends ConsumerWidget {
  const CatPanel(
    this.cat, {
    super.key,
    required this.onClick,
    required this.screenSize,
  });
  final VoidCallback onClick;
  final Cat cat;
  final ScreenSize screenSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue catImage = ref.watch(imageDataProvider(cat.image));
    ref.read(loggerProvider).d("Building CatPanel");
    final isLTR = Directionality.of(context) == TextDirection.ltr;

    double sizeFactor = switch (screenSize) {
      ScreenSize.compact => .5,
      ScreenSize.medium => 0.75,
      ScreenSize.expanded => 1,
    };

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        // height: normalSize.height,
        // width: normalSize.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: GestureDetector(
          onTap: onClick,
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
                          tag: cat.image,
                          child: ClipRRect(
                            // borderRadius: BorderRadius.circular(10),
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
                      Spacer(flex: 1),
                      Hero(
                        tag: cat.name,
                        child: SizedBox(
                          height: 25,
                          child: Text(
                            cat.name,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      // TAGS
                      Row(
                        children: [
                          Expanded(child: CatsTagList(cat: cat, height: 25)),
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
  }
}
