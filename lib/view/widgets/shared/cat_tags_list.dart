import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/models/enums/cat_tag.dart';
import 'package:flutter/material.dart';

class CatsTagList extends StatelessWidget {
  const CatsTagList({super.key, required this.cat, this.height});

  final double? height;

  final Cat cat;
  @override
  Widget build(BuildContext context) {
    List<CatTag> tags = List.from(cat.tags);

    tags.addAll(cat.tags);
    tags.addAll(cat.tags);
    final isLTR = Directionality.of(context) == TextDirection.ltr;

    return Container(
      height: height,
      alignment: isLTR ? Alignment.topLeft : Alignment.topRight,

      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        clipBehavior: Clip.hardEdge,
        children: tags
            .map(
              (tag) => Container(
                // height: height,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    "Tets",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );

    // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    // child: Row(
    //   children: cat.tags
    //       .map(
    //         (tag) => Flexible(
    //           child: Container(
    //             margin: const EdgeInsets.all(5),
    //             padding: const EdgeInsets.all(5),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(40),
    //               border: Border.all(color: Colors.black),
    //             ),
    //             child: Center(
    //               child: Container(
    //                 color: Colors.red,
    //                 child: Text(
    //                   tag.name,
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       )
    //       .toList(),
    // ),
  }
}
