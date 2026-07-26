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
        onSwipeRight();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    isLooping = false;
    super.dispose();
  }

  void onSwipeRight() {
    setState(() {
      if (imageIndex >= widget.imagePaths.length - 1) {
        imageIndex = 0;
      } else {
        imageIndex++;
      }
    });
  }

  void onSwipeLeft() {
    setState(() {
      if (imageIndex <= 0) {
        imageIndex = widget.imagePaths.length - 1;
      } else {
        imageIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Uint8List?> images = ref.watch(imageBulkProvider(widget.imagePaths));
    final isLTR = Directionality.of(context) == TextDirection.ltr;

    return Column(
      children: [
        // Current image being displayed
        Expanded(
          child: Hero(
            tag: widget.imagePaths[imageIndex],
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                // Primary velocity > 0 means swiping right, < 0 means swiping left
                if (details.primaryVelocity! > 0) {
                  isLooping = false;
                  onSwipeLeft();
                } else if (details.primaryVelocity! < 0) {
                  isLooping = false;
                  onSwipeRight();
                }
              },
              child: Stack(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    child: images[imageIndex] != null
                        ? Image.memory(
                            images[imageIndex]!,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ),
                  // Right arrow
                  Positioned(
                    right: isLTR ? 0 : null,
                    left: isLTR ? null : 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        // color: Colors.deepOrange,
                        child: IconButton(
                          onPressed: () {
                            onSwipeRight();
                          },
                          icon: Icon(Icons.arrow_forward_ios),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  // Left arrow
                  Positioned(
                    left: isLTR ? 0 : null,
                    right: isLTR ? null : 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        // color: Colors.deepOrange,
                        child: IconButton(
                          onPressed: () {
                            onSwipeLeft();
                          },
                          icon: Transform.flip(
                            flipX: true,
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Dots to show which image the displayer is at
        SizedBox(
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Spacer(),
              ...List.generate(widget.imagePaths.length, (index) {
                bool isSelected = index == imageIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      imageIndex = index;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: isSelected ? 6 : 3,
                        backgroundColor: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                  ),
                );
              }),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
