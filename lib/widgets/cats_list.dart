import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/images_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatsList extends ConsumerWidget {
  const CatsList({super.key, required this.cats});

  final List<Cat> cats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget catPanel(Cat cat) => SizedBox(
      width: 140 + MediaQuery.of(context).size.width / 10,
      child: Container(
        margin: const EdgeInsets.all(10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FutureBuilder(
                  future: ref.read(imageDataProvider(cat.image).future),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
                      return Image.memory(
                        asyncSnapshot.data!,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            Text(
              cat.name,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleMedium,
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
    );

    return Wrap(
      textDirection: TextDirection.ltr,
      children: [for (var cat in cats) catPanel(cat)],
    );
  }
}
