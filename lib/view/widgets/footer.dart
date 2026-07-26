import 'package:auto_size_text/auto_size_text.dart';
import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/providers/screen_size_provider.dart';
import 'package:dimos_cats/view/widgets/shared/app_logo.dart';
import 'package:dimos_cats/view/widgets/shared/marquee_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, required this.screenSize});

  final ScreenSize screenSize;

  @override
  Widget build(BuildContext context) {
    double padding = screenSize == ScreenSize.compact ? 10 : 20;

    String email = "dimo.dev@hotmail.com";

    void onCopyEmail() {
      Clipboard.setData(ClipboardData(text: email));
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Copied to clipboard (ﾉ*ФωФ)ﾉ !")),
      );
    }

    return Container(
      height: screenSize == ScreenSize.compact ? 400 : 220,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Flex(
                // spacing: 10,
                direction: screenSize == ScreenSize.compact
                    ? Axis.vertical
                    : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              AppLogo(),
                              SizedBox(width: 5),

                              Text(
                                // minFontSize: 18,
                                AppLocalizations.of(context).home,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),

                          Expanded(
                            child: MarqueeWidget(
                              direction: Axis.vertical,
                              child: Text(
                                AppLocalizations.of(context).footer,

                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                Text(
                                  AppLocalizations.of(context).contact_me,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: MarqueeWidget(
                              direction: Axis.vertical,
                              // Add email here
                              child: Text.rich(
                                TextSpan(
                                  text: AppLocalizations.of(
                                    context,
                                  ).contact_description,

                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,

                                  children: [
                                    TextSpan(
                                      text: " $email",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = onCopyEmail,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: padding / 2,
              ),
              child: FractionallySizedBox(
                // heightFactor: 0.9,
                // widthFactor: 0.2,
                child: Text(
                  "© 2026 · Built with Flutter",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
