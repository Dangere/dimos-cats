import 'package:dimos_cats/view/widgets/shared/blob_decoration.dart';
import 'package:dimos_cats/view/widgets/shared/marquee_widget.dart';
import 'package:flutter/material.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 3,
            child: Text(
              blobTitle,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          // SizedBox(height: 10),
          Expanded(
            flex: 6,
            child: Stack(
              // fit: StackFit.expand,
              // fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: BlobDecoration(index: blobVariant, fit: BoxFit.fill),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: MarqueeWidget(
                      direction: Axis.vertical,
                      child: Text(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        blobBody,
                        maxLines: 10,
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
