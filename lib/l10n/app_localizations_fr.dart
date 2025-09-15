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

  @override
  String get loginTitle => 'Connexion';

  @override
  String get enterEmail => 'Veuillez entrer votre email';

  @override
  String get enterValidEmail => 'Veuillez entrer un email valide';

  @override
  String get enterPassword => 'Veuillez entrer votre mot de passe';

  @override
  String get passwordMinChars =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get signIn => 'Se connecter';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get forgotPassword => 'Mot de passe oublié?';

  @override
  String get resetEmailSentTitle => 'Email envoyé!';

  @override
  String resetEmailSentMessage(Object email) {
    return 'Nous avons envoyé un email à $email avec les instructions pour réinitialiser le mot de passe.';
  }

  @override
  String get resetCheckSpam =>
      'Vérifiez aussi le dossier spam si vous ne voyez pas l\'email.';

  @override
  String get resetPasswordTitle => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordDescription =>
      'Entrez votre adresse email et nous vous enverrons les instructions pour réinitialiser votre mot de passe.';

  @override
  String get sendResetEmail => 'Envoyer l\'email de réinitialisation';

  @override
  String get backToLogin => 'Retour à la connexion';

  @override
  String get sendAgain => 'Envoyer à nouveau';

  @override
  String get accessDeniedTitle => 'Accès refusé';

  @override
  String get accessDeniedMessage => 'Accès réservé aux administrateurs';

  @override
  String get adminDashboardTitle => 'Tableau de bord administrateur';

  @override
  String get readOnlyUpdatedSuccess =>
      'Mode lecture seule mis à jour avec succès';

  @override
  String get simulateActivatedMessage =>
      '✅ Simulation activée : Budget dépassé - Système en lecture seule';

  @override
  String simulateError(Object error) {
    return '❌ Erreur de simulation : $error';
  }

  @override
  String get resetSimulationSuccess =>
      '✅ Simulation désactivée : Système restauré';

  @override
  String resetSimulationError(Object error) {
    return '❌ Erreur de réinitialisation : $error';
  }

  @override
  String get forceMaintenanceSuccess => '✅ Mode maintenance forcée activé';

  @override
  String forceError(Object error) {
    return '❌ Erreur : $error';
  }

  @override
  String get systemStatusNormal => 'Système opérationnel';

  @override
  String get systemStatusMaintenance => 'Système en mode maintenance';

  @override
  String systemMessageLabel(Object message) {
    return 'Message : $message';
  }

  @override
  String lastUpdatedLabel(Object datetime) {
    return 'Dernière mise à jour : $datetime';
  }

  @override
  String get adminControlsTitle => 'Contrôles administrateur';

  @override
  String get adminToggleButtonLabel => 'Basculer lecture seule';

  @override
  String get adminNote =>
      'Remarque : Ce bouton appelle la Cloud Function pour réinitialiser le mode lecture seule.';

  @override
  String get systemStatsTitle => 'Statistiques du système';

  @override
  String get systemStatusLabel => 'État du système';

  @override
  String get modeLabel => 'Mode';

  @override
  String get simulatedLabel => 'Simulation de budget';

  @override
  String get forcedLabel => 'Maintenance forcée';

  @override
  String get normalLabel => 'Normal';

  @override
  String get cloudFunctionsLabel => 'Cloud Functions';

  @override
  String get cloudFunctionsPending => 'À déployer';

  @override
  String get budgetAlertLabel => 'Alerte budget';

  @override
  String get budgetSimulationActive => 'Simulation active';

  @override
  String get securityRulesLabel => 'Règles de sécurité';

  @override
  String get securityRulesActive => 'Actives';

  @override
  String get testingHeader => 'Simulation de budget et tests';

  @override
  String get testingInfo =>
      'Outils pour tester le système de contrôle des coûts sans dépenser d\'argent réel :';

  @override
  String get testingInstructions =>
      '1. Cliquez sur \"Simuler Budget Dépassé\" pour activer la lecture seule\n2. Vérifiez que les boutons de la page d\'accueil sont désactivés\n3. Vérifiez que la bannière de maintenance apparaît\n4. Utilisez \"Restaurer Normal\" pour revenir à l\'état normal';

  @override
  String get simulationControlsLabel => 'Contrôles de simulation :';

  @override
  String get simulateButtonLabel => 'Simuler Budget\nDépassé';

  @override
  String get restoreButtonLabel => 'Restaurer\nNormal';

  @override
  String get forceMaintenanceButton => 'Forcer le mode maintenance';

  @override
  String get systemInSimulation => 'Système en simulation';

  @override
  String get systemNormal => 'Système normal';

  @override
  String get simulateButtonShort => 'Simuler Budget Dépassé';

  @override
  String get restoreButtonShort => 'Restaurer Normal';

  @override
  String get readOnlyTooltip =>
      'Le système est en mode maintenance. Opération non disponible.';

  @override
  String genericError(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get signalementListTitle => 'Signalements';

  @override
  String get signalementNotLoggedIn => 'Erreur : Utilisateur non connecté';

  @override
  String signalementError(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get signalementCreatedSuccess => 'Signalement créé avec succès !';

  @override
  String signalementUnexpectedError(Object error) {
    return 'Erreur inattendue : $error';
  }

  @override
  String get signalementCreateTitle => 'Nouveau signalement';

  @override
  String get signalementTypeLabel => 'Type de signalement';

  @override
  String get signalementSeverityLabel => 'Sévérité';

  @override
  String get signalementDescriptionLabel => 'Description';

  @override
  String get signalementDescriptionHint => 'Décrivez le problème en détail...';

  @override
  String get signalementDescriptionRequired => 'La description est obligatoire';

  @override
  String get signalementDescriptionMin =>
      'La description doit contenir au moins 10 caractères';

  @override
  String get signalementCreating => 'Création...';

  @override
  String get signalementCreateButton => 'Créer le signalement';

  @override
  String get signalementType_qualityIssue => 'Problème de qualité';

  @override
  String get signalementType_machineFailure => 'Panne machine';

  @override
  String get signalementType_materialIssue => 'Problème matériel';

  @override
  String get signalementType_processIssue => 'Problème de processus';

  @override
  String get signalementType_other => 'Autre';

  @override
  String get severity_low => 'Faible';

  @override
  String get severity_medium => 'Moyen';

  @override
  String get severity_high => 'Élevé';

  @override
  String get severity_critical => 'Critique';

  @override
  String get ofOrderCreateTitle => 'Nouvel ordre de production';

  @override
  String get clientLabel => 'Client';

  @override
  String get clientHint => 'Nom du client...';

  @override
  String get clientRequired => 'Le client est obligatoire';

  @override
  String get clientMinLength =>
      'Le nom du client doit contenir au moins 2 caractères';

  @override
  String get productLabel => 'Produit';

  @override
  String get productHint => 'Nom du produit...';

  @override
  String get productRequired => 'Le produit est obligatoire';

  @override
  String get productMinLength =>
      'Le nom du produit doit contenir au moins 2 caractères';

  @override
  String get quantityLabel => 'Quantité';

  @override
  String get quantityHint => 'Quantité à produire...';

  @override
  String get quantityRequired => 'La quantité est obligatoire';

  @override
  String get quantityPositive => 'La quantité doit être un nombre positif';

  @override
  String get quantityMax => 'La quantité ne peut pas dépasser 10 000';

  @override
  String get descriptionOptionalLabel => 'Description (Optionnel)';

  @override
  String get descriptionHint => 'Entrez la description du matériel';

  @override
  String get ofOrderCreating => 'Création...';

  @override
  String get ofOrderCreateButton => 'Créer ordre de production';

  @override
  String get ofOrderCreatedSuccess => 'Ordre de production créé avec succès !';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get adminDashboardTooltip => 'Tableau de bord administrateur';

  @override
  String get quickActionsTitle => 'Actions rapides';

  @override
  String get materialsLabel => 'Matériaux';

  @override
  String get signalementsLabel => 'Signalements';

  @override
  String get ofOrdersLabel => 'Ordres de production';

  @override
  String get adminDashboardShort => 'Tableau administrateur';

  @override
  String get materialStatisticsTitle => 'Statistiques Matériels';

  @override
  String get materialsPageTitle => 'Matériaux';

  @override
  String get materialsTab_all => 'Tous';

  @override
  String get materialsTab_lowStock => 'Stock faible';

  @override
  String get materialsTab_outOf_stock => 'Rupture de stock';

  @override
  String get materialsTab_alerts => 'Alertes';

  @override
  String get createMaterialTitle => 'Créer Matériel';

  @override
  String get createMaterial_success => 'Matériel créé avec succès';

  @override
  String createMaterial_error(Object error) {
    return 'Erreur lors de la création du matériel : $error';
  }

  @override
  String get referenceLabel => 'Référence';

  @override
  String get referenceHint => 'Entrez la référence du matériel';

  @override
  String get nameLabel => 'Nom';

  @override
  String get nameHint => 'Entrez le nom du matériel';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get typeLabel => 'Type';

  @override
  String get unitOfMeasureLabel => 'Unité de mesure';

  @override
  String get minimumStockLabel => 'Stock minimum';

  @override
  String get minimumStockHint => 'Entrez le niveau de stock minimum';

  @override
  String get maximumStockLabel => 'Stock maximum';

  @override
  String get maximumStockHint => 'Entrez le niveau de stock maximum';

  @override
  String get reorderPointLabel => 'Point de réapprovisionnement';

  @override
  String get reorderPointHint => 'Entrez le point de réapprovisionnement';

  @override
  String get unitPriceLabel => 'Prix unitaire';

  @override
  String get unitPriceHint => 'Entrez le prix unitaire';

  @override
  String get createMaterialButton => 'Créer le matériel';

  @override
  String get stockStatus_out => 'Rupture de stock';

  @override
  String get stockStatus_low => 'Stock faible';

  @override
  String get stockStatus_in => 'En stock';

  @override
  String get statusLabel => 'Statut';

  @override
  String referencePrefix(Object ref) {
    return 'Référence : $ref';
  }

  @override
  String stockPrefix(Object stock, Object uom) {
    return 'Stock : $stock $uom';
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
  String get materialStats_totalMaterials => 'Total des matériaux';

  @override
  String get materialStats_activeMaterials => 'Matériaux actifs';

  @override
  String get materialStats_inStock => 'En stock';

  @override
  String get materialStats_lowStock => 'Stock faible';

  @override
  String get materialStats_outOfStock => 'Rupture de stock';

  @override
  String get materialStats_expired => 'Périmé';

  @override
  String get materialStats_expiringSoon => 'Périmant bientôt';

  @override
  String get materialStats_totalValue => 'Valeur totale';

  @override
  String get loginError => 'Erreur de connexion';

  @override
  String loginErrorDetailed(Object error) {
    return 'Erreur de connexion : $error';
  }

  @override
  String get signupError => 'Erreur d\'inscription';

  @override
  String signupErrorDetailed(Object error) {
    return 'Erreur d\'inscription : $error';
  }

  @override
  String get type_consumable => 'Consommable';

  @override
  String get type_durable => 'Durable';

  @override
  String get type_service => 'Service';

  @override
  String get uom_pieces => 'Pièces';

  @override
  String get uom_kg => 'Kilogrammes';

  @override
  String get uom_liters => 'Litres';

  @override
  String get uom_meters => 'Mètres';

  @override
  String get ofOrdersPageTitle => 'Ordres de production';

  @override
  String get retryLabel => 'Réessayer';

  @override
  String get noOfOrdersFound => 'Aucun ordre de production trouvé';

  @override
  String orderPrefix(Object id) {
    return 'Ordre #$id';
  }

  @override
  String createdLabel(Object datetime) {
    return 'Créé : $datetime';
  }

  @override
  String updatedLabel(Object datetime) {
    return 'Mis à jour : $datetime';
  }

  @override
  String materialDetailTitle(Object id) {
    return 'Matériel $id';
  }

  @override
  String get materialDetailComingSoon =>
      'Page de détail du matériel - Bientôt disponible';

  @override
  String ofOrderNumber(Object id) {
    return 'Ordre # $id';
  }

  @override
  String ofOrderClient(Object client) {
    return 'Client : $client';
  }

  @override
  String ofOrderProduct(Object product) {
    return 'Produit : $product';
  }

  @override
  String ofOrderQuantity(Object quantity) {
    return 'Quantité : $quantity';
  }

  @override
  String ofOrderDescription(Object description) {
    return 'Description : $description';
  }

  @override
  String ofOrderCreated(Object datetime) {
    return 'Créé : $datetime';
  }

  @override
  String ofOrderUpdated(Object datetime) {
    return 'Mis à jour : $datetime';
  }

  @override
  String get ofOrderStatus_unknown => 'Inconnu';

  @override
  String get ofOrderStatus_materialReception => 'Réception des matériaux';

  @override
  String get ofOrderStatus_materialPreparation => 'Préparation des matériaux';

  @override
  String get ofOrderStatus_productionCoupe => 'Production - Coupe';

  @override
  String get ofOrderStatus_productionProd => 'Production - Prod';

  @override
  String get ofOrderStatus_productionTest => 'Production - Test';

  @override
  String get ofOrderStatus_control => 'Contrôle';

  @override
  String get ofOrderStatus_shipment => 'Expédition';

  @override
  String get ofOrderStatus_completed => 'Terminée';

  @override
  String get ofOrderStatus_cancelled => 'Annulé';
}
