// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Dimo\'s Cats';

  @override
  String get home_hero => 'Hi im Dimo';

  @override
  String get home_description_1 =>
      'These are cats that me and my family rescued over the last 7 years';

  @override
  String get home_description_2 => '';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';
}
