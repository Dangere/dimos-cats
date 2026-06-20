import 'dart:convert';

import 'package:dimos_cats/interfaces/cats_repository.dart';
import 'package:dimos_cats/models/cat.dart';
import 'package:flutter/services.dart';

class CatsAssetRepository implements CatsRepository {
  final AssetManifest manifest;

  CatsAssetRepository(this.manifest);

  @override
  Future<List<Cat>> getCats() async {
    // Getting the cats json file from the assets
    List<String> catsJsonPath = manifest
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
    }

    return cats;
  }
}
