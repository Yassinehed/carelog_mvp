// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CareLog MVP';

  @override
  String get homeWelcome =>
      'Welcome to CareLog MVP. This application is in initial setup.';

  @override
  String get homeDashboard => 'CareLog - Dashboard';
}
