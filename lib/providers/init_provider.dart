import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initProvider = FutureProvider.family<void, BuildContext>((
  ref,
  context,
) async {
  var imagesToPreload = [
    'assets/images/hero_background.jpg',
    'assets/images/hero_cat.png',
  ];

  for (var i = 0; i < imagesToPreload.length; i++) {
    if (context.mounted == false) return;
    await precacheImage(AssetImage(imagesToPreload[i]), context);
  }

  await Future.delayed(Duration(seconds: 2));
});
