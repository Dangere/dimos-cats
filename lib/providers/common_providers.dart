import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final cacheManagerProvider = Provider.autoDispose<CacheManager>((ref) {
  return DefaultCacheManager();
});

final assetManifestProvider = FutureProvider<AssetManifest>((ref) async {
  return await AssetManifest.loadFromAssetBundle(rootBundle);
});

final loggerProvider = Provider<Logger>((ref) {
  return Logger(
    printer: PrettyPrinter(
      methodCount: 0, // Number of method calls to be displayed
      // errorMethodCount: 0, // Number of method calls if stacktrace is provided
      lineLength: 40, // Width of the output (minimal)
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      // noBoxingByDefault: true, // THIS removes the rounded borders/lines
    ),
  );
});
