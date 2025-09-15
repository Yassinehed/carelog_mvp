import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'signalement_model.freezed.dart';
part 'signalement_model.g.dart';

/// Priority levels for signalements (issues/incidents)
enum SignalementPriority { low, medium, high, critical }

/// Status progression for signalement lifecycle
enum SignalementStatus {
  draft, // Initial creation
  submitted, // Submitted for review
  inProgress, // Being worked on
  resolved, // Issue resolved
  closed, // Final closure
  cancelled // Cancelled/voided
}

/// Categories for classifying signalements
enum SignalementCategory {
  quality, // Quality issues
  equipment, // Equipment malfunction
  material, // Material problems
  process, // Process issues
  safety, // Safety concerns
  other // Miscellaneous
}

/// Represents a signalement (issue/incident report) in the CareLog system.
/// This model follows enterprise-grade patterns with comprehensive validation,
/// audit trails, and business logic encapsulation.
@freezed
class Signalement with _$Signalement {
  const Signalement._(); // Private constructor for custom methods

  const factory Signalement({
    /// Unique identifier for the signalement
    required String id,

    /// Title/summary of the issue (max 200 chars)
    required String title,

    /// Detailed description of the issue
    required String description,

    /// Priority level of the signalement
    required SignalementPriority priority,

    /// Current status in the workflow
    required SignalementStatus status,

    /// Category classification
    required SignalementCategory category,

    /// ID of the user who created the signalement
    required String createdBy,

    /// ID of the user currently assigned (nullable)
    String? assignedTo,

    /// Associated OF (Manufacturing Order) number
    String? ofNumber,

    /// Location where the issue occurred
    String? location,

    /// Equipment involved (if applicable)
    String? equipment,

    /// Material batch/lot involved (if applicable)
    String? materialBatch,

    /// Expected resolution date
    DateTime? expectedResolutionDate,

    /// Actual resolution date
    DateTime? actualResolutionDate,

    /// Resolution notes/comments
    String? resolutionNotes,

    /// Creation timestamp
    required DateTime createdAt,

    /// Last update timestamp
    required DateTime updatedAt,

    /// Version for optimistic concurrency
    @Default(1) int version,

    /// Additional metadata as key-value pairs
    @Default({}) Map<String, dynamic> metadata,
  }) = _Signalement;

  /// Creates a Signalement from JSON data
  factory Signalement.fromJson(Map<String, dynamic> json) =>
      _$SignalementFromJson(json);

  /// Creates a new Signalement with default values for creation
  factory Signalement.create({
    required String title,
    required String description,
    required SignalementPriority priority,
    required SignalementCategory category,
    required String createdBy,
    String? ofNumber,
    String? location,
    String? equipment,
    String? materialBatch,
    DateTime? expectedResolutionDate,
    Map<String, dynamic>? metadata,
  }) {
    final now = DateTime.now();
    return Signalement(
      id: const Uuid().v4(),
      title: title.trim(),
      description: description.trim(),
      priority: priority,
      status: SignalementStatus.draft,
      category: category,
      createdBy: createdBy,
      ofNumber: ofNumber?.trim(),
      location: location?.trim(),
      equipment: equipment?.trim(),
      materialBatch: materialBatch?.trim(),
      expectedResolutionDate: expectedResolutionDate,
      createdAt: now,
      updatedAt: now,
      metadata: metadata ?? {},
    );
  }

  /// Validates the signalement data integrity
  bool get isValid {
    return title.isNotEmpty &&
        title.length <= 200 &&
        description.isNotEmpty &&
        description.length <= 2000 &&
        createdBy.isNotEmpty &&
        (ofNumber == null || ofNumber!.isNotEmpty) &&
        (location == null || location!.isNotEmpty) &&
        (equipment == null || equipment!.isNotEmpty) &&
        (materialBatch == null || materialBatch!.isNotEmpty) &&
        (resolutionNotes == null || resolutionNotes!.length <= 1000);
  }

  /// Checks if the signalement is in a terminal state
  bool get isClosed =>
      status == SignalementStatus.closed ||
      status == SignalementStatus.cancelled ||
      status == SignalementStatus.resolved;

  /// Checks if the signalement is overdue based on expected resolution date
  bool get isOverdue {
    if (expectedResolutionDate == null || isClosed) return false;
    return DateTime.now().isAfter(expectedResolutionDate!);
  }

  /// Calculates days since creation
  int get daysSinceCreation {
    return DateTime.now().difference(createdAt).inDays;
  }

  /// Calculates days since last update
  int get daysSinceUpdate {
    return DateTime.now().difference(updatedAt).inDays;
  }

  /// Returns a human-readable status description
  String get statusDescription {
    switch (status) {
      case SignalementStatus.draft:
        return 'Brouillon';
      case SignalementStatus.submitted:
        return 'Soumis';
      case SignalementStatus.inProgress:
        return 'En cours';
      case SignalementStatus.resolved:
        return 'Résolu';
      case SignalementStatus.closed:
        return 'Fermé';
      case SignalementStatus.cancelled:
        return 'Annulé';
    }
  }

  /// Returns a human-readable priority description
  String get priorityDescription {
    switch (priority) {
      case SignalementPriority.low:
        return 'Faible';
      case SignalementPriority.medium:
        return 'Moyen';
      case SignalementPriority.high:
        return 'Élevé';
      case SignalementPriority.critical:
        return 'Critique';
    }
  }

  /// Returns a human-readable category description
  String get categoryDescription {
    switch (category) {
      case SignalementCategory.quality:
        return 'Qualité';
      case SignalementCategory.equipment:
        return 'Équipement';
      case SignalementCategory.material:
        return 'Matériau';
      case SignalementCategory.process:
        return 'Processus';
      case SignalementCategory.safety:
        return 'Sécurité';
      case SignalementCategory.other:
        return 'Autre';
    }
  }

  /// Creates a copy with updated status and automatic timestamp update
  Signalement updateStatus(SignalementStatus newStatus, {String? updatedBy}) {
    final now = DateTime.now();
    final resolutionDate =
        newStatus == SignalementStatus.resolved ? now : actualResolutionDate;

    return copyWith(
      status: newStatus,
      actualResolutionDate: resolutionDate,
      updatedAt: now,
      metadata: {
        ...metadata,
        'lastStatusUpdate': now.toIso8601String(),
        if (updatedBy != null) 'lastUpdatedBy': updatedBy,
      },
    );
  }

  /// Creates a copy with assignment update
  Signalement assignTo(String userId) {
    return copyWith(
      assignedTo: userId,
      updatedAt: DateTime.now(),
      metadata: {
        ...metadata,
        'assignedAt': DateTime.now().toIso8601String(),
        'assignedBy': userId,
      },
    );
  }

  /// Creates a copy with resolution details
  Signalement resolve(String resolutionNotes, {String? resolvedBy}) {
    return copyWith(
      status: SignalementStatus.resolved,
      resolutionNotes: resolutionNotes.trim(),
      actualResolutionDate: DateTime.now(),
      updatedAt: DateTime.now(),
      metadata: {
        ...metadata,
        'resolvedAt': DateTime.now().toIso8601String(),
        if (resolvedBy != null) 'resolvedBy': resolvedBy,
      },
    );
  }

  /// Converts to a summary map for list views
  Map<String, dynamic> toSummaryMap() {
    return {
      'id': id,
      'title': title,
      'priority': priority.name,
      'status': status.name,
      'category': category.name,
      'createdBy': createdBy,
      'assignedTo': assignedTo,
      'ofNumber': ofNumber,
      'createdAt': createdAt.toIso8601String(),
      'isOverdue': isOverdue,
      'daysSinceCreation': daysSinceCreation,
    };
  }

  /// Converts to a detailed map for detail views
  Map<String, dynamic> toDetailMap() {
    return {
      ...toSummaryMap(),
      'description': description,
      'location': location,
      'equipment': equipment,
      'materialBatch': materialBatch,
      'expectedResolutionDate': expectedResolutionDate?.toIso8601String(),
      'actualResolutionDate': actualResolutionDate?.toIso8601String(),
      'resolutionNotes': resolutionNotes,
      'updatedAt': updatedAt.toIso8601String(),
      'version': version,
      'metadata': metadata,
    };
  }
}
