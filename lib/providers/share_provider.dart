import 'package:dimos_cats/models/enums/platform_share.dart';
import 'package:dimos_cats/providers/firebase_analytics_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// Class used to open social medias to share or copy the link to the site
class SharesNotifier extends Notifier<void> {
  final String _whatsappUrl = "https://wa.me/?text=";
  final String _facebookUrl = "https://www.facebook.com/sharer/sharer.php?u=";

  final String _text =
      "If you're in Giza, Check out this site to adopt a lovely cat ( •̀ ω •́ )y! ${Uri.base}";

  Future<void> shareTo(PlatformShare platform) async {
    ref.read(firebaseAnalyticsProvider.notifier).logShareAttempt(platform);
    final encodedText = Uri.encodeComponent(_text);
    final encodedUrl = Uri.encodeComponent(Uri.base.toString());

    bool failedToShare = false;
    print("object");

    switch (platform) {
      case PlatformShare.whatsapp:
        if (!await launchUrl(Uri.parse(_whatsappUrl + encodedText))) {
          failedToShare = true;
        }
        break;
      case PlatformShare.facebook:
        if (!await launchUrl(Uri.parse(_facebookUrl + encodedUrl))) {
          failedToShare = true;
        }
        break;
    }

    if (failedToShare) return Future.error("Failed to share to $platform");
  }

  void copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: _text));
  }

  @override
  void build() {}
}

final sharesProvider = NotifierProvider<SharesNotifier, void>(
  SharesNotifier.new,
);
