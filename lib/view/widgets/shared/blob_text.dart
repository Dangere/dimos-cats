import 'package:dimos_cats/view/widgets/shared/blob_decoration.dart';
import 'package:dimos_cats/view/widgets/shared/marquee_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BlobText extends StatelessWidget {
  const BlobText({
    super.key,
    required this.blobVariant,
    required this.blobTitle,
    required this.blobBody,
  });

  final int blobVariant;
  final String blobTitle;
  final String blobBody;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 4,
            child: ClipRRect(
              child: OverflowBox(
                fit: OverflowBoxFit.deferToChild,
                alignment: Alignment.topCenter,
                maxHeight: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      blobTitle,
                      style: Theme.of(context).textTheme.displayMedium!
                          .copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            flex: 6,
            child: Stack(
              children: [
                Positioned.fill(
                  child: BlobDecoration(index: blobVariant, fit: BoxFit.fill),
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(25.0) +
                        EdgeInsets.symmetric(horizontal: 10),
                    child: MarqueeWidget(
                      animationDuration: const Duration(seconds: 10),
                      pauseDuration: const Duration(seconds: 5),
                      direction: Axis.vertical,
                      child: Text(
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        blobBody,
                        maxLines: 50,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
