import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Loads an image from the assets folder
final imageDataProvider = FutureProvider.family<Uint8List?, String>((
  ref,
  path,
) async {
  try {
    final ByteData data = await rootBundle.load(path);

    final Uint8List bytes = data.buffer.asUint8List();
    return bytes;
  } catch (e) {
    return null;
  }
});

/// Takes a list of paths and returns a list of nulls that update to Uint8List when image it loaded
class ImageBulkNotifier extends Notifier<List<Uint8List?>> {
  ImageBulkNotifier(this.paths);
  final List<String> paths;
  @override
  List<Uint8List?> build() {
    Future(() async {
      final results = List<Uint8List?>.filled(paths.length, null);
      for (var i = 0; i < paths.length; i++) {
        results[i] = await ref.read(imageDataProvider(paths[i]).future);
        state = List.of(results);
      }
    });

    List<Uint8List?> initialList = List<Uint8List?>.filled(paths.length, null);

    initialList[0] = ref.read(imageDataProvider(paths[0])).value;

    return initialList;
  }
}

final imageBulkProvider =
    NotifierProvider.family<ImageBulkNotifier, List<Uint8List?>, List<String>>(
      ImageBulkNotifier.new,
    );
