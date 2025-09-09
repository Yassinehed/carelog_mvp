// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'CareLog MVP';

  @override
  String get homeWelcome =>
      'Bienvenue dans CareLog MVP. Cette application est en configuration initiale.';

  @override
  String get homeDashboard => 'CareLog - Tableau de bord';
}
