import 'dart:typed_data';

import 'package:dimos_cats/providers/images_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagesDisplayer extends ConsumerStatefulWidget {
  const ImagesDisplayer({super.key, required this.imagePaths});

  final List<String> imagePaths;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ImagesDisplayerState();
}

class _ImagesDisplayerState extends ConsumerState<ImagesDisplayer> {
  final Duration delay = const Duration(milliseconds: 5000);
  late int imageIndex = 0;
  bool isLooping = true;

  @override
  void initState() {
    Future(() async {
      while (isLooping) {
        await Future.delayed(delay);

        if (!mounted) break;
        setState(() {
          if (imageIndex >= widget.imagePaths.length - 1) {
            imageIndex = 0;
          } else {
            imageIndex++;
          }
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    isLooping = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Uint8List?> images = ref.watch(imageBulkProvider(widget.imagePaths));

    return Column(
      children: [
        // Current image being displayed
        Expanded(
          child: Hero(
            tag: widget.imagePaths[imageIndex],
            child: Container(
              color: Theme.of(context).colorScheme.outlineVariant,
              child: images[imageIndex] != null
                  ? Image.memory(
                      images[imageIndex]!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
        // Dots to show which image the displayer is at
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(widget.imagePaths.length, (index) {
                bool isSelected = index == imageIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      imageIndex = index;
                    });
                  },
                  child: CircleAvatar(
                    radius: isSelected ? 6 : 4,
                    backgroundColor: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outlineVariant,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
