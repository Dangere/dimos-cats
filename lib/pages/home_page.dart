import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/widgets/reuseable/app_logo.dart';
import 'package:dimos_cats/widgets/reuseable/language_toggle.dart';
import 'package:dimos_cats/widgets/reuseable/theme_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        title: Row(
          children: [
            AppLogo(),
            SizedBox(width: 10),
            Text(AppLocalizations.of(context).home),
          ],
        ),
        actionsPadding: const EdgeInsets.all(10),
        actions: [LanguageToggle(), ThemeToggle()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Container(color: Theme.of(context).secondaryHeaderColor),
            ),
            Wrap(
              children: List.generate(20, (index) {
                return SizedBox.square(
                  dimension: 140 + MediaQuery.of(context).size.width / 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,

                      // borderRadius: BorderRadius.only(
                      //   bottomLeft: Radius.circular(10),
                      // ),
                    ),
                    margin: const EdgeInsets.all(10),
                  ),
                );
              }),
            ),
            // Expanded(child: Column(children: [])),
          ],
        ),
      ),
    );
  }
}
