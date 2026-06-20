import 'dart:async';

import 'package:dimos_cats/interfaces/cats_repository.dart';
import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/repositories/cats_asset_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Returns a list of cats from the assets
class CatsNotifier extends AsyncNotifier<List<Cat>> {
  @override
  FutureOr<List<Cat>> build() async {
    // We should.. initialize this somewhere else.., but since we only got one repository its fine
    await ref.read(assetManifestProvider.future);

    return await ref.read(catsRepositoryProvider).getCats();
  }
}

final catsProvider = AsyncNotifierProvider<CatsNotifier, List<Cat>>(
  CatsNotifier.new,
);

final catsRepositoryProvider = Provider<CatsRepository>((ref) {
  return CatsAssetRepository(ref.read(assetManifestProvider).value!);
});
