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
