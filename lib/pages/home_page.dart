import 'package:dimos_cats/core/localization/generated/l10n/app_localizations.dart';
import 'package:dimos_cats/models/cat.dart';
import 'package:dimos_cats/providers/images_provider.dart';
import 'package:dimos_cats/widgets/cats_list.dart';
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
    List<String>? imagePaths = ref.watch(imagePathsProvider).value;
    print(imagePaths);

    return Scaffold(
      drawer: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        width: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 12),

                Text(AppLocalizations.of(context).language),
                Spacer(),

                LanguageToggle(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                SizedBox(width: 12),
                Text(AppLocalizations.of(context).theme),
                Spacer(),
                ThemeToggle(),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppLogo(),
            SizedBox(width: 10),
            Text(AppLocalizations.of(context).home),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: Container(color: Theme.of(context).secondaryHeaderColor),
            ),
            if (imagePaths != null)
              CatsList(
                cats: imagePaths
                    .map(
                      (e) => Cat(
                        name: 'Cat',
                        gender: false,
                        birthDate: DateTime.now(),
                        image: e,
                        description: 'This a cat',
                        extendedImages: [],
                        extendedDescriptions: [],
                      ),
                    )
                    .toList(),
              ),
            // Expanded(child: Column(children: [])),
          ],
        ),
      ),
    );
  }
}
