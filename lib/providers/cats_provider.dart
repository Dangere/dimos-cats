import 'dart:async';
import 'dart:convert';

import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Returns a list of cats from the assets
class CatsNotifier extends AsyncNotifier<List<Cat>> {
  @override
  FutureOr<List<Cat>> build() async {
    // Getting the cats json file from the assets
    List<String> catsJsonPath = (await ref.read(assetManifestProvider.future))
        .listAssets()
        .where((String key) => key.startsWith("assets/cats/"))
        .where((String key) => key.endsWith('.json'))
        .toList();

    List<Cat> cats = List.empty(growable: true);

    // Decoding the json file and populating the default assets path for the images
    for (var jsonPath in catsJsonPath) {
      final String response = await rootBundle.loadString(jsonPath);
      cats.add(
        Cat.fromJson(
          jsonDecode(response),
          imageRootPath: "assets/images/cats/",
        ),
      );
      print(cats.last.extendedImages);
    }
    return cats;
  }
}

final catsProvider = AsyncNotifierProvider<CatsNotifier, List<Cat>>(
  CatsNotifier.new,
);
