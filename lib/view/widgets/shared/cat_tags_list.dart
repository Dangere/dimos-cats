import 'package:dimos_cats/models/cat.dart';
import 'package:flutter/material.dart';

class CatsTagList extends StatelessWidget {
  const CatsTagList({super.key, required this.cat});

  final Cat cat;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      alignment: Alignment.topLeft,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        clipBehavior: Clip.hardEdge,
        children: cat.tags
            .map(
              (tag) => Container(
                height: 20,
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
