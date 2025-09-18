import '../../domain/core/entities.dart';

/// Priority levels for signalements
enum SignalementPriority { low, medium, high, critical }

/// Status progression for signalement workflow
enum SignalementStatus {
  draft,
  submitted,
  inProgress,
  resolved,
  closed,
  cancelled
}

/// Categories for classifying signalements
enum SignalementCategory {
  quality,
  equipment,
  material,
  process,
  safety,
  other
}

/// Signalement entity representing an issue/incident report
class Signalement extends Entity {
  @override
  final String id;
  final String title;
  final String description;
  final SignalementPriority priority;
  final SignalementStatus status;
  final SignalementCategory category;
  final String createdBy;
  final String? assignedTo;
  final String? ofNumber;
  final String? location;
  final String? equipment;
  final String? materialBatch;
  final DateTime? expectedResolutionDate;
  final DateTime? actualResolutionDate;
  final String? resolutionNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  @override
  final int version;
  final Map<String, dynamic> metadata;

  const Signalement({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.category,
    required this.createdBy,
    this.assignedTo,
    this.ofNumber,
    this.location,
    this.equipment,
    this.materialBatch,
    this.expectedResolutionDate,
    this.actualResolutionDate,
    this.resolutionNotes,
    required this.createdAt,
    required this.updatedAt,
    this.version = 1,
    this.metadata = const {},
  });

  /// Creates a copy with updated fields
  Signalement copyWith({
    String? id,
    String? title,
    String? description,
    SignalementPriority? priority,
    SignalementStatus? status,
    SignalementCategory? category,
    String? createdBy,
    String? assignedTo,
    String? ofNumber,
    String? location,
    String? equipment,
    String? materialBatch,
    DateTime? expectedResolutionDate,
    DateTime? actualResolutionDate,
    String? resolutionNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
    Map<String, dynamic>? metadata,
  }) {
    return Signalement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      category: category ?? this.category,
      createdBy: createdBy ?? this.createdBy,
      assignedTo: assignedTo ?? this.assignedTo,
      ofNumber: ofNumber ?? this.ofNumber,
      location: location ?? this.location,
      equipment: equipment ?? this.equipment,
      materialBatch: materialBatch ?? this.materialBatch,
      expectedResolutionDate:
          expectedResolutionDate ?? this.expectedResolutionDate,
      actualResolutionDate: actualResolutionDate ?? this.actualResolutionDate,
      resolutionNotes: resolutionNotes ?? this.resolutionNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Checks if signalement is in terminal state
  bool get isClosed =>
      status == SignalementStatus.closed ||
      status == SignalementStatus.cancelled ||
      status == SignalementStatus.resolved;

  /// Checks if signalement is overdue
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

  /// Returns priority display name in French
  String get priorityDisplayName {
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

  /// Returns status display name in French
  String get statusDisplayName {
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

  /// Returns category display name in French
  String get categoryDisplayName {
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

  /// Creates a new signalement with updated status
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

  /// Assigns signalement to a user
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

  /// Resolves the signalement
  Signalement resolve(String resolutionNotes, {String? resolvedBy}) {
    return copyWith(
      status: SignalementStatus.resolved,
      resolutionNotes: resolutionNotes,
      actualResolutionDate: DateTime.now(),
      updatedAt: DateTime.now(),
      metadata: {
        ...metadata,
        'resolvedAt': DateTime.now().toIso8601String(),
        if (resolvedBy != null) 'resolvedBy': resolvedBy,
      },
    );
  }
}
