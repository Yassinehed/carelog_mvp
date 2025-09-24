import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'CareLog MVP'**
  String get appTitle;

  /// No description provided for @homeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to CareLog MVP. This application is in initial setup.'**
  String get homeWelcome;

  /// No description provided for @homeDashboard.
  ///
  /// In en, this message translates to:
  /// **'CareLog - Dashboard'**
  String get homeDashboard;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enterEmail;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get enterPassword;

  /// No description provided for @passwordMinChars.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinChars;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @resetEmailSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Email sent!'**
  String get resetEmailSentTitle;

  /// No description provided for @resetEmailSentMessage.
  ///
  /// In en, this message translates to:
  /// **'We have sent an email to {email} with instructions to reset your password.'**
  String resetEmailSentMessage(Object email);

  /// No description provided for @resetCheckSpam.
  ///
  /// In en, this message translates to:
  /// **'Also check your spam folder if you don\'t see the email.'**
  String get resetCheckSpam;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you instructions to reset your password.'**
  String get resetPasswordDescription;

  /// No description provided for @sendResetEmail.
  ///
  /// In en, this message translates to:
  /// **'Send reset email'**
  String get sendResetEmail;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @sendAgain.
  ///
  /// In en, this message translates to:
  /// **'Send again'**
  String get sendAgain;

  /// No description provided for @accessDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Access Denied'**
  String get accessDeniedTitle;

  /// No description provided for @accessDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Admin access only'**
  String get accessDeniedMessage;

  /// No description provided for @adminDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboardTitle;

  /// No description provided for @readOnlyUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Read-only mode updated successfully'**
  String get readOnlyUpdatedSuccess;

  /// No description provided for @simulateActivatedMessage.
  ///
  /// In en, this message translates to:
  /// **'✅ Simulation activated: Budget exceeded - System in read-only'**
  String get simulateActivatedMessage;

  /// No description provided for @simulateError.
  ///
  /// In en, this message translates to:
  /// **'❌ Simulation error: {error}'**
  String simulateError(Object error);

  /// No description provided for @resetSimulationSuccess.
  ///
  /// In en, this message translates to:
  /// **'✅ Simulation deactivated: System restored'**
  String get resetSimulationSuccess;

  /// No description provided for @resetSimulationError.
  ///
  /// In en, this message translates to:
  /// **'❌ Reset error: {error}'**
  String resetSimulationError(Object error);

  /// No description provided for @forceMaintenanceSuccess.
  ///
  /// In en, this message translates to:
  /// **'✅ Forced maintenance mode activated'**
  String get forceMaintenanceSuccess;

  /// No description provided for @forceError.
  ///
  /// In en, this message translates to:
  /// **'❌ Error: {error}'**
  String forceError(Object error);

  /// No description provided for @systemStatusNormal.
  ///
  /// In en, this message translates to:
  /// **'System Operational'**
  String get systemStatusNormal;

  /// No description provided for @systemStatusMaintenance.
  ///
  /// In en, this message translates to:
  /// **'System in Maintenance Mode'**
  String get systemStatusMaintenance;

  /// No description provided for @systemMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message: {message}'**
  String systemMessageLabel(Object message);

  /// No description provided for @lastUpdatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {datetime}'**
  String lastUpdatedLabel(Object datetime);

  /// No description provided for @adminControlsTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Controls'**
  String get adminControlsTitle;

  /// No description provided for @adminToggleButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Toggle Read-Only'**
  String get adminToggleButtonLabel;

  /// No description provided for @adminNote.
  ///
  /// In en, this message translates to:
  /// **'Note: This button calls the Cloud Function to reset read-only mode.'**
  String get adminNote;

  /// No description provided for @systemStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'System Statistics'**
  String get systemStatsTitle;

  /// No description provided for @systemStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'System Status'**
  String get systemStatusLabel;

  /// No description provided for @modeLabel.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get modeLabel;

  /// No description provided for @simulatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Simulation Budget'**
  String get simulatedLabel;

  /// No description provided for @forcedLabel.
  ///
  /// In en, this message translates to:
  /// **'Forced Maintenance'**
  String get forcedLabel;

  /// No description provided for @normalLabel.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normalLabel;

  /// No description provided for @cloudFunctionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Cloud Functions'**
  String get cloudFunctionsLabel;

  /// No description provided for @cloudFunctionsPending.
  ///
  /// In en, this message translates to:
  /// **'To Deploy'**
  String get cloudFunctionsPending;

  /// No description provided for @budgetAlertLabel.
  ///
  /// In en, this message translates to:
  /// **'Budget Alert'**
  String get budgetAlertLabel;

  /// No description provided for @budgetSimulationActive.
  ///
  /// In en, this message translates to:
  /// **'Simulation Active'**
  String get budgetSimulationActive;

  /// No description provided for @securityRulesLabel.
  ///
  /// In en, this message translates to:
  /// **'Security Rules'**
  String get securityRulesLabel;

  /// No description provided for @securityRulesActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get securityRulesActive;

  /// No description provided for @testingHeader.
  ///
  /// In en, this message translates to:
  /// **'Budget Simulation & Testing'**
  String get testingHeader;

  /// No description provided for @testingInfo.
  ///
  /// In en, this message translates to:
  /// **'Tools to test the cost control system without spending real money:'**
  String get testingInfo;

  /// No description provided for @testingInstructions.
  ///
  /// In en, this message translates to:
  /// **'1. Click \"Simulate Budget Exceeded\" to enable read-only\n2. Check home buttons are disabled\n3. Check that maintenance banner appears\n4. Use \"Restore Normal\" to go back to normal state'**
  String get testingInstructions;

  /// No description provided for @simulationControlsLabel.
  ///
  /// In en, this message translates to:
  /// **'Simulation Controls:'**
  String get simulationControlsLabel;

  /// No description provided for @simulateButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Simulate Budget\nExceeded'**
  String get simulateButtonLabel;

  /// No description provided for @restoreButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Restore\nNormal'**
  String get restoreButtonLabel;

  /// No description provided for @forceMaintenanceButton.
  ///
  /// In en, this message translates to:
  /// **'Force Maintenance Mode'**
  String get forceMaintenanceButton;

  /// No description provided for @systemInSimulation.
  ///
  /// In en, this message translates to:
  /// **'System in Simulation'**
  String get systemInSimulation;

  /// No description provided for @systemNormal.
  ///
  /// In en, this message translates to:
  /// **'System Normal'**
  String get systemNormal;

  /// No description provided for @simulateButtonShort.
  ///
  /// In en, this message translates to:
  /// **'Simulate Budget Exceeded'**
  String get simulateButtonShort;

  /// No description provided for @restoreButtonShort.
  ///
  /// In en, this message translates to:
  /// **'Restore Normal'**
  String get restoreButtonShort;

  /// No description provided for @readOnlyTooltip.
  ///
  /// In en, this message translates to:
  /// **'System is in maintenance mode. Operation not available.'**
  String get readOnlyTooltip;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String genericError(Object error);

  /// No description provided for @signalementListTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get signalementListTitle;

  /// No description provided for @signalementNotLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Error: User not logged in'**
  String get signalementNotLoggedIn;

  /// No description provided for @signalementError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String signalementError(Object error);

  /// No description provided for @signalementCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Report created successfully!'**
  String get signalementCreatedSuccess;

  /// No description provided for @signalementUnexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error: {error}'**
  String signalementUnexpectedError(Object error);

  /// No description provided for @signalementCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'New Report'**
  String get signalementCreateTitle;

  /// No description provided for @signalementTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Report Type'**
  String get signalementTypeLabel;

  /// No description provided for @signalementSeverityLabel.
  ///
  /// In en, this message translates to:
  /// **'Severity'**
  String get signalementSeverityLabel;

  /// No description provided for @signalementDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get signalementDescriptionLabel;

  /// No description provided for @signalementDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue in detail...'**
  String get signalementDescriptionHint;

  /// No description provided for @signalementDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get signalementDescriptionRequired;

  /// No description provided for @signalementDescriptionMin.
  ///
  /// In en, this message translates to:
  /// **'Description must be at least 10 characters'**
  String get signalementDescriptionMin;

  /// No description provided for @signalementCreating.
  ///
  /// In en, this message translates to:
  /// **'Creating...'**
  String get signalementCreating;

  /// No description provided for @signalementCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create Report'**
  String get signalementCreateButton;

  /// No description provided for @signalementType_qualityIssue.
  ///
  /// In en, this message translates to:
  /// **'Quality issue'**
  String get signalementType_qualityIssue;

  /// No description provided for @signalementType_machineFailure.
  ///
  /// In en, this message translates to:
  /// **'Machine failure'**
  String get signalementType_machineFailure;

  /// No description provided for @signalementType_materialIssue.
  ///
  /// In en, this message translates to:
  /// **'Material issue'**
  String get signalementType_materialIssue;

  /// No description provided for @signalementType_processIssue.
  ///
  /// In en, this message translates to:
  /// **'Process issue'**
  String get signalementType_processIssue;

  /// No description provided for @signalementType_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get signalementType_other;

  /// No description provided for @severity_low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get severity_low;

  /// No description provided for @severity_medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get severity_medium;

  /// No description provided for @severity_high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get severity_high;

  /// No description provided for @severity_critical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get severity_critical;

  /// No description provided for @ofOrderCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'New Production Order'**
  String get ofOrderCreateTitle;

  /// No description provided for @clientLabel.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get clientLabel;

  /// No description provided for @clientHint.
  ///
  /// In en, this message translates to:
  /// **'Client name...'**
  String get clientHint;

  /// No description provided for @clientRequired.
  ///
  /// In en, this message translates to:
  /// **'Client is required'**
  String get clientRequired;

  /// No description provided for @clientMinLength.
  ///
  /// In en, this message translates to:
  /// **'Client name must be at least 2 characters'**
  String get clientMinLength;

  /// No description provided for @productLabel.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get productLabel;

  /// No description provided for @productHint.
  ///
  /// In en, this message translates to:
  /// **'Product name...'**
  String get productHint;

  /// No description provided for @productRequired.
  ///
  /// In en, this message translates to:
  /// **'Product is required'**
  String get productRequired;

  /// No description provided for @productMinLength.
  ///
  /// In en, this message translates to:
  /// **'Product name must be at least 2 characters'**
  String get productMinLength;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// No description provided for @quantityHint.
  ///
  /// In en, this message translates to:
  /// **'Quantity to produce...'**
  String get quantityHint;

  /// No description provided for @quantityRequired.
  ///
  /// In en, this message translates to:
  /// **'Quantity is required'**
  String get quantityRequired;

  /// No description provided for @quantityPositive.
  ///
  /// In en, this message translates to:
  /// **'Quantity must be a positive number'**
  String get quantityPositive;

  /// No description provided for @quantityMax.
  ///
  /// In en, this message translates to:
  /// **'Quantity cannot exceed 10,000'**
  String get quantityMax;

  /// No description provided for @descriptionOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get descriptionOptionalLabel;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Enter material description'**
  String get descriptionHint;

  /// No description provided for @ofOrderCreating.
  ///
  /// In en, this message translates to:
  /// **'Creating...'**
  String get ofOrderCreating;

  /// No description provided for @ofOrderCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create Production Order'**
  String get ofOrderCreateButton;

  /// No description provided for @ofOrderCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Production order created successfully!'**
  String get ofOrderCreatedSuccess;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @adminDashboardTooltip.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboardTooltip;

  /// No description provided for @quickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActionsTitle;

  /// No description provided for @materialsLabel.
  ///
  /// In en, this message translates to:
  /// **'Materials'**
  String get materialsLabel;

  /// No description provided for @signalementsLabel.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get signalementsLabel;

  /// No description provided for @ofOrdersLabel.
  ///
  /// In en, this message translates to:
  /// **'Production Orders'**
  String get ofOrdersLabel;

  /// No description provided for @adminDashboardShort.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboardShort;

  /// No description provided for @materialStatisticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Material Statistics'**
  String get materialStatisticsTitle;

  /// No description provided for @materialsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Materials'**
  String get materialsPageTitle;

  /// No description provided for @materialsTab_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get materialsTab_all;

  /// No description provided for @materialsTab_lowStock.
  ///
  /// In en, this message translates to:
  /// **'Low Stock'**
  String get materialsTab_lowStock;

  /// No description provided for @materialsTab_outOf_stock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get materialsTab_outOf_stock;

  /// No description provided for @materialsTab_alerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get materialsTab_alerts;

  /// No description provided for @createMaterialTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Material'**
  String get createMaterialTitle;

  /// No description provided for @createMaterial_success.
  ///
  /// In en, this message translates to:
  /// **'Material created successfully'**
  String get createMaterial_success;

  /// No description provided for @createMaterial_error.
  ///
  /// In en, this message translates to:
  /// **'Error creating material: {error}'**
  String createMaterial_error(Object error);

  /// No description provided for @referenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get referenceLabel;

  /// No description provided for @referenceHint.
  ///
  /// In en, this message translates to:
  /// **'Enter material reference'**
  String get referenceHint;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter material name'**
  String get nameHint;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get typeLabel;

  /// No description provided for @unitOfMeasureLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit of Measure'**
  String get unitOfMeasureLabel;

  /// No description provided for @minimumStockLabel.
  ///
  /// In en, this message translates to:
  /// **'Minimum Stock'**
  String get minimumStockLabel;

  /// No description provided for @minimumStockHint.
  ///
  /// In en, this message translates to:
  /// **'Enter minimum stock level'**
  String get minimumStockHint;

  /// No description provided for @maximumStockLabel.
  ///
  /// In en, this message translates to:
  /// **'Maximum Stock'**
  String get maximumStockLabel;

  /// No description provided for @maximumStockHint.
  ///
  /// In en, this message translates to:
  /// **'Enter maximum stock level'**
  String get maximumStockHint;

  /// No description provided for @reorderPointLabel.
  ///
  /// In en, this message translates to:
  /// **'Reorder Point'**
  String get reorderPointLabel;

  /// No description provided for @reorderPointHint.
  ///
  /// In en, this message translates to:
  /// **'Enter reorder point'**
  String get reorderPointHint;

  /// No description provided for @unitPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get unitPriceLabel;

  /// No description provided for @unitPriceHint.
  ///
  /// In en, this message translates to:
  /// **'Enter unit price'**
  String get unitPriceHint;

  /// No description provided for @createMaterialButton.
  ///
  /// In en, this message translates to:
  /// **'Create Material'**
  String get createMaterialButton;

  /// No description provided for @stockStatus_out.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get stockStatus_out;

  /// No description provided for @stockStatus_low.
  ///
  /// In en, this message translates to:
  /// **'Low Stock'**
  String get stockStatus_low;

  /// No description provided for @stockStatus_in.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get stockStatus_in;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @referencePrefix.
  ///
  /// In en, this message translates to:
  /// **'Reference: {ref}'**
  String referencePrefix(Object ref);

  /// No description provided for @stockPrefix.
  ///
  /// In en, this message translates to:
  /// **'Stock: {stock} {uom}'**
  String stockPrefix(Object stock, Object uom);

  /// No description provided for @typeLabelUpper.
  ///
  /// In en, this message translates to:
  /// **'{type}'**
  String typeLabelUpper(Object type);

  /// No description provided for @stockFraction.
  ///
  /// In en, this message translates to:
  /// **'{current}/{maximum}'**
  String stockFraction(Object current, Object maximum);

  /// No description provided for @materialStats_totalMaterials.
  ///
  /// In en, this message translates to:
  /// **'Total Materials'**
  String get materialStats_totalMaterials;

  /// No description provided for @materialStats_activeMaterials.
  ///
  /// In en, this message translates to:
  /// **'Active Materials'**
  String get materialStats_activeMaterials;

  /// No description provided for @materialStats_inStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get materialStats_inStock;

  /// No description provided for @materialStats_lowStock.
  ///
  /// In en, this message translates to:
  /// **'Low Stock'**
  String get materialStats_lowStock;

  /// No description provided for @materialStats_outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get materialStats_outOfStock;

  /// No description provided for @materialStats_expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get materialStats_expired;

  /// No description provided for @materialStats_expiringSoon.
  ///
  /// In en, this message translates to:
  /// **'Expiring Soon'**
  String get materialStats_expiringSoon;

  /// No description provided for @materialStats_totalValue.
  ///
  /// In en, this message translates to:
  /// **'Total Value'**
  String get materialStats_totalValue;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Login error'**
  String get loginError;

  /// No description provided for @loginErrorDetailed.
  ///
  /// In en, this message translates to:
  /// **'Login error: {error}'**
  String loginErrorDetailed(Object error);

  /// No description provided for @signupError.
  ///
  /// In en, this message translates to:
  /// **'Sign up error'**
  String get signupError;

  /// No description provided for @signupErrorDetailed.
  ///
  /// In en, this message translates to:
  /// **'Sign up error: {error}'**
  String signupErrorDetailed(Object error);

  /// No description provided for @type_consumable.
  ///
  /// In en, this message translates to:
  /// **'Consumable'**
  String get type_consumable;

  /// No description provided for @type_durable.
  ///
  /// In en, this message translates to:
  /// **'Durable'**
  String get type_durable;

  /// No description provided for @type_service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get type_service;

  /// No description provided for @uom_pieces.
  ///
  /// In en, this message translates to:
  /// **'Pieces'**
  String get uom_pieces;

  /// No description provided for @uom_kg.
  ///
  /// In en, this message translates to:
  /// **'Kilograms'**
  String get uom_kg;

  /// No description provided for @uom_liters.
  ///
  /// In en, this message translates to:
  /// **'Liters'**
  String get uom_liters;

  /// No description provided for @uom_meters.
  ///
  /// In en, this message translates to:
  /// **'Meters'**
  String get uom_meters;

  /// No description provided for @ofOrdersPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Production Orders'**
  String get ofOrdersPageTitle;

  /// No description provided for @retryLabel.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryLabel;

  /// No description provided for @noOfOrdersFound.
  ///
  /// In en, this message translates to:
  /// **'No production orders found'**
  String get noOfOrdersFound;

  /// No description provided for @orderPrefix.
  ///
  /// In en, this message translates to:
  /// **'Order #{id}'**
  String orderPrefix(Object id);

  /// No description provided for @createdLabel.
  ///
  /// In en, this message translates to:
  /// **'Created: {datetime}'**
  String createdLabel(Object datetime);

  /// No description provided for @updatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Updated: {datetime}'**
  String updatedLabel(Object datetime);

  /// No description provided for @materialDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Material {id}'**
  String materialDetailTitle(Object id);

  /// No description provided for @materialDetailComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Material Detail Page - Coming Soon'**
  String get materialDetailComingSoon;

  /// No description provided for @ofOrderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order # {id}'**
  String ofOrderNumber(Object id);

  /// No description provided for @ofOrderClient.
  ///
  /// In en, this message translates to:
  /// **'Client: {client}'**
  String ofOrderClient(Object client);

  /// No description provided for @ofOrderProduct.
  ///
  /// In en, this message translates to:
  /// **'Product: {product}'**
  String ofOrderProduct(Object product);

  /// No description provided for @ofOrderQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity: {quantity}'**
  String ofOrderQuantity(Object quantity);

  /// No description provided for @ofOrderDescription.
  ///
  /// In en, this message translates to:
  /// **'Description: {description}'**
  String ofOrderDescription(Object description);

  /// No description provided for @ofOrderCreated.
  ///
  /// In en, this message translates to:
  /// **'Created: {datetime}'**
  String ofOrderCreated(Object datetime);

  /// No description provided for @ofOrderUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated: {datetime}'**
  String ofOrderUpdated(Object datetime);

  /// No description provided for @ofOrderStatus_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get ofOrderStatus_unknown;

  /// No description provided for @ofOrderStatus_materialReception.
  ///
  /// In en, this message translates to:
  /// **'Material Reception'**
  String get ofOrderStatus_materialReception;

  /// No description provided for @ofOrderStatus_materialPreparation.
  ///
  /// In en, this message translates to:
  /// **'Material Preparation'**
  String get ofOrderStatus_materialPreparation;

  /// No description provided for @ofOrderStatus_productionCoupe.
  ///
  /// In en, this message translates to:
  /// **'Production - Coupe'**
  String get ofOrderStatus_productionCoupe;

  /// No description provided for @ofOrderStatus_productionProd.
  ///
  /// In en, this message translates to:
  /// **'Production - Prod'**
  String get ofOrderStatus_productionProd;

  /// No description provided for @ofOrderStatus_productionTest.
  ///
  /// In en, this message translates to:
  /// **'Production - Test'**
  String get ofOrderStatus_productionTest;

  /// No description provided for @ofOrderStatus_control.
  ///
  /// In en, this message translates to:
  /// **'Control'**
  String get ofOrderStatus_control;

  /// No description provided for @ofOrderStatus_shipment.
  ///
  /// In en, this message translates to:
  /// **'Shipment'**
  String get ofOrderStatus_shipment;

  /// No description provided for @ofOrderStatus_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get ofOrderStatus_completed;

  /// No description provided for @ofOrderStatus_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get ofOrderStatus_cancelled;

  /// No description provided for @exportPdfButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Esporta PDF'**
  String get exportPdfButtonLabel;
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
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
