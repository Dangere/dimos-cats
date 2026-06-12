import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cacheManagerProvider = Provider.autoDispose<CacheManager>((ref) {
  return DefaultCacheManager();
});
