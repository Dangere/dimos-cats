import 'dart:ui_web' as ui_web;

import 'package:dimos_cats/providers/common_providers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ImagesProvider extends Notifier<void> {
//   Future<List<String>> getAllAssetImages({
//     String path = 'assets/images/',
//   }) async {
//     final AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(
//       rootBundle,
//     );

//     final List<String> imagePaths = assetManifest
//         .listAssets()
//         .where((String key) => key.startsWith(path))
//         .where(
//           (String key) =>
//               key.endsWith('.png') ||
//               key.endsWith('.jpg') ||
//               key.endsWith('.jpeg') ||
//               key.endsWith('.webp'),
//         )
//         .toList();

//     return imagePaths;
//   }

//   @override
//   build() {}
// }

// final imagesProvider = NotifierProvider.autoDispose<ImagesProvider, void>(
//   ImagesProvider.new,
// );

final imagePathsProvider = FutureProvider<List<String>>((ref) async {
  final AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(
    rootBundle,
  );

  return assetManifest
      .listAssets()
      .where((String key) => key.startsWith("assets/images/cats/test/"))
      .where(
        (String key) =>
            key.endsWith('.png') ||
            key.endsWith('.jpg') ||
            key.endsWith('.jpeg') ||
            key.endsWith('.webp'),
      )
      .toList();
});

final imageDataProvider = FutureProvider.family<Uint8List, String>((
  ref,
  path,
) async {
  String assetUrl = ui_web.assetManager.getAssetUrl(path);
  var file = await ref.read(cacheManagerProvider).getSingleFile(assetUrl);

  return await file.readAsBytes();
});
