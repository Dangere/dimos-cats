import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/common_providers.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Firebase analytics provider to log events
class FirebaseAnalyticsNotifier extends Notifier<void> {
  final FirebaseAnalytics instance = FirebaseAnalytics.instance;

  final bool debugMode = kDebugMode;

  void logCatProfileOpened(Cat cat) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'cat_profile_opened',
      parameters: {'cat_name': cat.name, 'debug_mode': debugMode ? 1 : 0},
    );
    ref.read(loggerProvider).d("Opened cat profile");
  }

  void logCatAdoptPressed(Cat cat) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'cat_adopt_pressed',
      parameters: {'cat_name': cat.name, 'debug_mode': debugMode ? 1 : 0},
    );
    ref.read(loggerProvider).d("Clicked cat adopt");
  }

  @override
  build() {}
}

final firebaseAnalyticsProvider =
    NotifierProvider<FirebaseAnalyticsNotifier, void>(
      FirebaseAnalyticsNotifier.new,
    );
