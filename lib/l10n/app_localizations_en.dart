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

  @override
  String get loginTitle => 'Login';

  @override
  String get enterEmail => 'Please enter your email';

  @override
  String get enterValidEmail => 'Please enter a valid email';

  @override
  String get enterPassword => 'Please enter your password';

  @override
  String get passwordMinChars => 'Password must be at least 6 characters';

  @override
  String get signIn => 'Sign in';

  @override
  String get signUp => 'Sign up';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get resetEmailSentTitle => 'Email sent!';

  @override
  String resetEmailSentMessage(Object email) {
    return 'We have sent an email to $email with instructions to reset your password.';
  }

  @override
  String get resetCheckSpam =>
      'Also check your spam folder if you don\'t see the email.';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get resetPasswordDescription =>
      'Enter your email address and we\'ll send you instructions to reset your password.';

  @override
  String get sendResetEmail => 'Send reset email';

  @override
  String get backToLogin => 'Back to login';

  @override
  String get sendAgain => 'Send again';

  @override
  String get accessDeniedTitle => 'Access Denied';

  @override
  String get accessDeniedMessage => 'Admin access only';

  @override
  String get adminDashboardTitle => 'Admin Dashboard';

  @override
  String get readOnlyUpdatedSuccess => 'Read-only mode updated successfully';

  @override
  String get simulateActivatedMessage =>
      '✅ Simulation activated: Budget exceeded - System in read-only';

  @override
  String simulateError(Object error) {
    return '❌ Simulation error: $error';
  }

  @override
  String get resetSimulationSuccess =>
      '✅ Simulation deactivated: System restored';

  @override
  String resetSimulationError(Object error) {
    return '❌ Reset error: $error';
  }

  @override
  String get forceMaintenanceSuccess => '✅ Forced maintenance mode activated';

  @override
  String forceError(Object error) {
    return '❌ Error: $error';
  }

  @override
  String get systemStatusNormal => 'System Operational';

  @override
  String get systemStatusMaintenance => 'System in Maintenance Mode';

  @override
  String systemMessageLabel(Object message) {
    return 'Message: $message';
  }

  @override
  String lastUpdatedLabel(Object datetime) {
    return 'Last updated: $datetime';
  }

  @override
  String get adminControlsTitle => 'Admin Controls';

  @override
  String get adminToggleButtonLabel => 'Toggle Read-Only';

  @override
  String get adminNote =>
      'Note: This button calls the Cloud Function to reset read-only mode.';

  @override
  String get systemStatsTitle => 'System Statistics';

  @override
  String get systemStatusLabel => 'System Status';

  @override
  String get modeLabel => 'Mode';

  @override
  String get simulatedLabel => 'Simulation Budget';

  @override
  String get forcedLabel => 'Forced Maintenance';

  @override
  String get normalLabel => 'Normal';

  @override
  String get cloudFunctionsLabel => 'Cloud Functions';

  @override
  String get cloudFunctionsPending => 'To Deploy';

  @override
  String get budgetAlertLabel => 'Budget Alert';

  @override
  String get budgetSimulationActive => 'Simulation Active';

  @override
  String get securityRulesLabel => 'Security Rules';

  @override
  String get securityRulesActive => 'Active';

  @override
  String get testingHeader => 'Budget Simulation & Testing';

  @override
  String get testingInfo =>
      'Tools to test the cost control system without spending real money:';

  @override
  String get testingInstructions =>
      '1. Click \"Simulate Budget Exceeded\" to enable read-only\n2. Check home buttons are disabled\n3. Check that maintenance banner appears\n4. Use \"Restore Normal\" to go back to normal state';

  @override
  String get simulationControlsLabel => 'Simulation Controls:';

  @override
  String get simulateButtonLabel => 'Simulate Budget\nExceeded';

  @override
  String get restoreButtonLabel => 'Restore\nNormal';

  @override
  String get forceMaintenanceButton => 'Force Maintenance Mode';

  @override
  String get systemInSimulation => 'System in Simulation';

  @override
  String get systemNormal => 'System Normal';

  @override
  String get simulateButtonShort => 'Simulate Budget Exceeded';

  @override
  String get restoreButtonShort => 'Restore Normal';

  @override
  String get readOnlyTooltip =>
      'System is in maintenance mode. Operation not available.';

  @override
  String genericError(Object error) {
    return 'Error: $error';
  }

  @override
  String get signalementListTitle => 'Reports';

  @override
  String get signalementNotLoggedIn => 'Error: User not logged in';

  @override
  String signalementError(Object error) {
    return 'Error: $error';
  }

  @override
  String get signalementCreatedSuccess => 'Report created successfully!';

  @override
  String signalementUnexpectedError(Object error) {
    return 'Unexpected error: $error';
  }

  @override
  String get signalementCreateTitle => 'New Report';

  @override
  String get signalementTypeLabel => 'Report Type';

  @override
  String get signalementSeverityLabel => 'Severity';

  @override
  String get signalementDescriptionLabel => 'Description';

  @override
  String get signalementDescriptionHint => 'Describe the issue in detail...';

  @override
  String get signalementDescriptionRequired => 'Description is required';

  @override
  String get signalementDescriptionMin =>
      'Description must be at least 10 characters';

  @override
  String get signalementCreating => 'Creating...';

  @override
  String get signalementCreateButton => 'Create Report';

  @override
  String get signalementType_qualityIssue => 'Quality issue';

  @override
  String get signalementType_machineFailure => 'Machine failure';

  @override
  String get signalementType_materialIssue => 'Material issue';

  @override
  String get signalementType_processIssue => 'Process issue';

  @override
  String get signalementType_other => 'Other';

  @override
  String get severity_low => 'Low';

  @override
  String get severity_medium => 'Medium';

  @override
  String get severity_high => 'High';

  @override
  String get severity_critical => 'Critical';

  @override
  String get ofOrderCreateTitle => 'New Production Order';

  @override
  String get clientLabel => 'Client';

  @override
  String get clientHint => 'Client name...';

  @override
  String get clientRequired => 'Client is required';

  @override
  String get clientMinLength => 'Client name must be at least 2 characters';

  @override
  String get productLabel => 'Product';

  @override
  String get productHint => 'Product name...';

  @override
  String get productRequired => 'Product is required';

  @override
  String get productMinLength => 'Product name must be at least 2 characters';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get quantityHint => 'Quantity to produce...';

  @override
  String get quantityRequired => 'Quantity is required';

  @override
  String get quantityPositive => 'Quantity must be a positive number';

  @override
  String get quantityMax => 'Quantity cannot exceed 10,000';

  @override
  String get descriptionOptionalLabel => 'Description (Optional)';

  @override
  String get descriptionHint => 'Enter material description';

  @override
  String get ofOrderCreating => 'Creating...';

  @override
  String get ofOrderCreateButton => 'Create Production Order';

  @override
  String get ofOrderCreatedSuccess => 'Production order created successfully!';

  @override
  String get logout => 'Logout';

  @override
  String get adminDashboardTooltip => 'Admin Dashboard';

  @override
  String get quickActionsTitle => 'Quick Actions';

  @override
  String get materialsLabel => 'Materials';

  @override
  String get signalementsLabel => 'Reports';

  @override
  String get ofOrdersLabel => 'Production Orders';

  @override
  String get adminDashboardShort => 'Admin Dashboard';

  @override
  String get materialStatisticsTitle => 'Material Statistics';

  @override
  String get materialsPageTitle => 'Materials';

  @override
  String get materialsTab_all => 'All';

  @override
  String get materialsTab_lowStock => 'Low Stock';

  @override
  String get materialsTab_outOf_stock => 'Out of Stock';

  @override
  String get materialsTab_alerts => 'Alerts';

  @override
  String get createMaterialTitle => 'Create Material';

  @override
  String get createMaterial_success => 'Material created successfully';

  @override
  String createMaterial_error(Object error) {
    return 'Error creating material: $error';
  }

  @override
  String get referenceLabel => 'Reference';

  @override
  String get referenceHint => 'Enter material reference';

  @override
  String get nameLabel => 'Name';

  @override
  String get nameHint => 'Enter material name';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get typeLabel => 'Type';

  @override
  String get unitOfMeasureLabel => 'Unit of Measure';

  @override
  String get minimumStockLabel => 'Minimum Stock';

  @override
  String get minimumStockHint => 'Enter minimum stock level';

  @override
  String get maximumStockLabel => 'Maximum Stock';

  @override
  String get maximumStockHint => 'Enter maximum stock level';

  @override
  String get reorderPointLabel => 'Reorder Point';

  @override
  String get reorderPointHint => 'Enter reorder point';

  @override
  String get unitPriceLabel => 'Unit Price';

  @override
  String get unitPriceHint => 'Enter unit price';

  @override
  String get createMaterialButton => 'Create Material';

  @override
  String get stockStatus_out => 'Out of Stock';

  @override
  String get stockStatus_low => 'Low Stock';

  @override
  String get stockStatus_in => 'In Stock';

  @override
  String get statusLabel => 'Status';

  @override
  String referencePrefix(Object ref) {
    return 'Reference: $ref';
  }

  @override
  String stockPrefix(Object stock, Object uom) {
    return 'Stock: $stock $uom';
  }

  @override
  String typeLabelUpper(Object type) {
    return '$type';
  }

  @override
  String stockFraction(Object current, Object maximum) {
    return '$current/$maximum';
  }

  @override
  String get materialStats_totalMaterials => 'Total Materials';

  @override
  String get materialStats_activeMaterials => 'Active Materials';

  @override
  String get materialStats_inStock => 'In Stock';

  @override
  String get materialStats_lowStock => 'Low Stock';

  @override
  String get materialStats_outOfStock => 'Out of Stock';

  @override
  String get materialStats_expired => 'Expired';

  @override
  String get materialStats_expiringSoon => 'Expiring Soon';

  @override
  String get materialStats_totalValue => 'Total Value';

  @override
  String get loginError => 'Login error';

  @override
  String loginErrorDetailed(Object error) {
    return 'Login error: $error';
  }

  @override
  String get signupError => 'Sign up error';

  @override
  String signupErrorDetailed(Object error) {
    return 'Sign up error: $error';
  }

  @override
  String get type_consumable => 'Consumable';

  @override
  String get type_durable => 'Durable';

  @override
  String get type_service => 'Service';

  @override
  String get uom_pieces => 'Pieces';

  @override
  String get uom_kg => 'Kilograms';

  @override
  String get uom_liters => 'Liters';

  @override
  String get uom_meters => 'Meters';

  @override
  String get ofOrdersPageTitle => 'Production Orders';

  @override
  String get retryLabel => 'Retry';

  @override
  String get noOfOrdersFound => 'No production orders found';

  @override
  String orderPrefix(Object id) {
    return 'Order #$id';
  }

  @override
  String createdLabel(Object datetime) {
    return 'Created: $datetime';
  }

  @override
  String updatedLabel(Object datetime) {
    return 'Updated: $datetime';
  }

  @override
  String materialDetailTitle(Object id) {
    return 'Material $id';
  }

  @override
  String get materialDetailComingSoon => 'Material Detail Page - Coming Soon';

  @override
  String ofOrderNumber(Object id) {
    return 'Order # $id';
  }

  @override
  String ofOrderClient(Object client) {
    return 'Client: $client';
  }

  @override
  String ofOrderProduct(Object product) {
    return 'Product: $product';
  }

  @override
  String ofOrderQuantity(Object quantity) {
    return 'Quantity: $quantity';
  }

  @override
  String ofOrderDescription(Object description) {
    return 'Description: $description';
  }

  @override
  String ofOrderCreated(Object datetime) {
    return 'Created: $datetime';
  }

  @override
  String ofOrderUpdated(Object datetime) {
    return 'Updated: $datetime';
  }

  @override
  String get ofOrderStatus_unknown => 'Unknown';

  @override
  String get ofOrderStatus_materialReception => 'Material Reception';

  @override
  String get ofOrderStatus_materialPreparation => 'Material Preparation';

  @override
  String get ofOrderStatus_productionCoupe => 'Production - Coupe';

  @override
  String get ofOrderStatus_productionProd => 'Production - Prod';

  @override
  String get ofOrderStatus_productionTest => 'Production - Test';

  @override
  String get ofOrderStatus_control => 'Control';

  @override
  String get ofOrderStatus_shipment => 'Shipment';

  @override
  String get ofOrderStatus_completed => 'Completed';

  @override
  String get ofOrderStatus_cancelled => 'Cancelled';

  @override
  String get exportPdfButtonLabel => 'Esporta PDF';

  @override
  String get supervisorDashboardTitle => 'Supervisor Dashboard';

  @override
  String get kpi_production_label => 'Production';

  @override
  String get kpi_alerts_label => 'Alerts';

  @override
  String get kpi_operators_label => 'Operators';

  @override
  String get kpi_avg_time_label => 'Avg Time';

  @override
  String get filter_reset => 'Reset';

  @override
  String get noActiveOf => 'No active OF';

  @override
  String get accessDeniedSupervisor => 'Supervisor and admin access only';

  @override
  String get prioritiesUpdated => 'Priorities updated';

  @override
  String assignOperatorForZone(Object zone) {
    return 'Assign an operator for zone: $zone';
  }

  @override
  String get assignDialogCalculating => 'Calculating...';

  @override
  String get zoneLabel => 'Zone';

  @override
  String workloadLabel(Object w) {
    return 'Workload: $w';
  }

  @override
  String get errorLabel => 'Error';
}
