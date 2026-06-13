import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/providers/images_provider.dart';
import 'package:dimos_cats/view/widgets/shared/app_logo.dart';
import 'package:dimos_cats/view/widgets/shared/error_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatPanel extends ConsumerWidget {
  const CatPanel(this.cat, {super.key, required this.onClick});
  final Cat cat;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue catImage = ref.watch(imageDataProvider(cat.image));
    ref.read(loggerProvider).d("Building CatPanel");
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        width: 140 + MediaQuery.of(context).size.width / 10,
        child: Container(
          margin: const EdgeInsets.all(10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: cat.image,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: catImage.when(
                      data: (data) => data != null
                          ? Image.memory(data, fit: BoxFit.cover)
                          : const Center(child: AppLogo()),
                      error: (error, stackTrace) =>
                          ErrorPanel(message: error.toString()),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ),
              Hero(
                tag: cat.name,
                child: Text(
                  cat.name,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                cat.description,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
