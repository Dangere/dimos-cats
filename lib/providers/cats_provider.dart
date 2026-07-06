import 'dart:async';

import 'package:dimos_cats/interfaces/cats_repository.dart';
import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:dimos_cats/providers/firebase_analytics_provider.dart';
import 'package:dimos_cats/repositories/cats_asset_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// Returns a list of cats from the assets
class CatsNotifier extends AsyncNotifier<List<Cat>> {
  final String adoptUrl = "https://tally.so/r/MeyK6X?cat_name=";

  /// Method used to send the user to the adopt form
  Future<void> adoptCat(Cat cat) async {
    ref.read(firebaseAnalyticsProvider.notifier).logCatAdoptPressed(cat);
    if (!await launchUrl(Uri.parse(adoptUrl + cat.name))) {
      return Future.error("Failed to launch url");
    }
  }

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
