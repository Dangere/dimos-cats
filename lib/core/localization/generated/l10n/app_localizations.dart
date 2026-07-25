import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Dimo\'s Cats'**
  String get home;

  /// No description provided for @home_hero.
  ///
  /// In en, this message translates to:
  /// **'Hi im Dimo'**
  String get home_hero;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @adopt.
  ///
  /// In en, this message translates to:
  /// **'Adopt'**
  String get adopt;

  /// No description provided for @why.
  ///
  /// In en, this message translates to:
  /// **'Why?'**
  String get why;

  /// No description provided for @where.
  ///
  /// In en, this message translates to:
  /// **'Where?'**
  String get where;

  /// No description provided for @hero_text_blob_why.
  ///
  /// In en, this message translates to:
  /// **'For the last 6+ years me and my family have been rescuing and taking care of cats around our area in Egypt, Giza. However, because we are just a small family relaying only on our personal income, taking care of over 15 cats monthly has became impossible, that\'s why we kindly ask you to consider adoption if you\'re in the need of a cat!'**
  String get hero_text_blob_why;

  /// No description provided for @hero_text_blob_where.
  ///
  /// In en, this message translates to:
  /// **'Since we are just a family, we can only help delivering cats in Giza and the surrounding area, if you, or someone you know, wants a cat, we can help you find it and pick it up in Giza'**
  String get hero_text_blob_where;

  /// No description provided for @cant_adopt.
  ///
  /// In en, this message translates to:
  /// **'Can\'t adopt and still wanna help?'**
  String get cant_adopt;

  /// No description provided for @cant_adopt1.
  ///
  /// In en, this message translates to:
  /// **'Telling your Egyptian friends about the site and encouraging them to adopt is always welcomed! (*^▽^*)'**
  String get cant_adopt1;

  /// No description provided for @contact_me.
  ///
  /// In en, this message translates to:
  /// **'Contact me!'**
  String get contact_me;

  /// No description provided for @contact_description.
  ///
  /// In en, this message translates to:
  /// **'This site was made by a developer in Cairo, the same person taking care of these cats and the person you will (hopefully) adopt from, if you\'re interested in more details or work opportunities:'**
  String get contact_description;

  /// No description provided for @footer.
  ///
  /// In en, this message translates to:
  /// **'Dimo\'s Cats hosts a list of cats personally rescued and taken care of by Dimo and his family over multiple years, and that are up for adoption in Egypt, Giza'**
  String get footer;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @medical_history.
  ///
  /// In en, this message translates to:
  /// **'Medical History'**
  String get medical_history;

  /// No description provided for @tag_years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get tag_years;

  /// No description provided for @tag_months.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get tag_months;

  /// No description provided for @tag_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get tag_male;

  /// No description provided for @tag_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get tag_female;

  /// No description provided for @tag_big.
  ///
  /// In en, this message translates to:
  /// **'Big'**
  String get tag_big;

  /// No description provided for @tag_fluffy.
  ///
  /// In en, this message translates to:
  /// **'Fluffy'**
  String get tag_fluffy;

  /// No description provided for @tag_cuddly.
  ///
  /// In en, this message translates to:
  /// **'Cuddly'**
  String get tag_cuddly;

  /// No description provided for @tag_bites.
  ///
  /// In en, this message translates to:
  /// **'Bites'**
  String get tag_bites;

  /// No description provided for @tag_friendly.
  ///
  /// In en, this message translates to:
  /// **'Friendly'**
  String get tag_friendly;

  /// No description provided for @tag_moody.
  ///
  /// In en, this message translates to:
  /// **'Moody'**
  String get tag_moody;

  /// No description provided for @tag_playful.
  ///
  /// In en, this message translates to:
  /// **'Playful'**
  String get tag_playful;

  /// No description provided for @tag_shy.
  ///
  /// In en, this message translates to:
  /// **'Shy'**
  String get tag_shy;

  /// No description provided for @tag_lazy.
  ///
  /// In en, this message translates to:
  /// **'Lazy'**
  String get tag_lazy;

  /// No description provided for @tag_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get tag_active;

  /// No description provided for @tag_goofy.
  ///
  /// In en, this message translates to:
  /// **'Goofy'**
  String get tag_goofy;

  /// No description provided for @tag_sweet.
  ///
  /// In en, this message translates to:
  /// **'Sweet'**
  String get tag_sweet;

  /// No description provided for @tag_caring.
  ///
  /// In en, this message translates to:
  /// **'Caring'**
  String get tag_caring;

  /// No description provided for @tag_loving.
  ///
  /// In en, this message translates to:
  /// **'Loving'**
  String get tag_loving;

  /// No description provided for @tag_talkative.
  ///
  /// In en, this message translates to:
  /// **'Talkative'**
  String get tag_talkative;

  /// No description provided for @tag_social.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get tag_social;

  /// No description provided for @tag_lean.
  ///
  /// In en, this message translates to:
  /// **'Lean'**
  String get tag_lean;

  /// No description provided for @tag_medicalAttention.
  ///
  /// In en, this message translates to:
  /// **'Medical Attention'**
  String get tag_medicalAttention;

  /// No description provided for @tag_deaf.
  ///
  /// In en, this message translates to:
  /// **'Deaf'**
  String get tag_deaf;

  /// No description provided for @tag_anxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get tag_anxious;

  /// No description provided for @tag_small.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get tag_small;

  /// No description provided for @tag_neutered.
  ///
  /// In en, this message translates to:
  /// **'Neutered'**
  String get tag_neutered;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
