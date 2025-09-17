import 'package:equatable/equatable.dart';

import '../../domain/core/entities.dart';

/// Status progression for OF (Manufacturing Order) workflow
enum OfOrderStatus {
  draft,
  planned,
  materialWaiting,
  inProgress,
  qualityCheck,
  completed,
  delivered,
  cancelled
}

/// Priority levels for manufacturing orders
enum OfOrderPriority { low, normal, high, urgent }

/// Quality control status
enum QualityStatus { pending, inProgress, passed, failed, rework }

/// Production note entity
class ProductionNote extends Equatable {
  final String id;
  final String content;
  final String authorId;
  final DateTime timestamp;

  const ProductionNote({
    required this.id,
    required this.content,
    required this.authorId,
    required this.timestamp,
  });

  @override
  @override
  List<Object?> get props => [id, content, authorId, timestamp];
}

/// Quality check result entity
class QualityCheck extends Equatable {
  final String id;
  final String checkpoint;
  final bool passed;
  final String? notes;
  final String inspectorId;
  final DateTime timestamp;

  const QualityCheck({
    required this.id,
    required this.checkpoint,
    required this.passed,
    this.notes,
    required this.inspectorId,
    required this.timestamp,
  });

  @override
  @override
  List<Object?> get props =>
      [id, checkpoint, passed, notes, inspectorId, timestamp];
}

/// OfOrder entity representing a Manufacturing Order
class OfOrder extends Entity {
  final String ofNumber;
  final String title;
  final String description;
  final String clientName;
  final String productReference;
  final int plannedQuantity;
  final String unit;
  final OfOrderStatus status;
  final OfOrderPriority priority;
  final QualityStatus qualityStatus;
  final String? productionLine;
  final String? supervisorId;
  final DateTime? plannedStartDate;
  final DateTime? actualStartDate;
  final DateTime? plannedCompletionDate;
  final DateTime? actualCompletionDate;
  final DateTime? deliveryDeadline;
  final DateTime? actualDeliveryDate;
  final List<String> requiredMaterials;
  final List<String> qualitySpecifications;
  final List<ProductionNote> productionNotes;
  final List<QualityCheck> qualityChecks;
  final int progressPercentage;
  final int actualQuantity;
  final int goodQuantity;
  final int rejectedQuantity;
  final double? allocatedBudget;
  final double actualCost;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String? updatedBy;
  @override
  final int version;
  final Map<String, dynamic> metadata;

  const OfOrder({
    required this.ofNumber,
    required this.title,
    required this.description,
    required this.clientName,
    required this.productReference,
    required this.plannedQuantity,
    required this.unit,
    required this.status,
    required this.priority,
    this.qualityStatus = QualityStatus.pending,
    this.productionLine,
    this.supervisorId,
    this.plannedStartDate,
    this.actualStartDate,
    this.plannedCompletionDate,
    this.actualCompletionDate,
    this.deliveryDeadline,
    this.actualDeliveryDate,
    this.requiredMaterials = const [],
    this.qualitySpecifications = const [],
    this.productionNotes = const [],
    this.qualityChecks = const [],
    this.progressPercentage = 0,
    this.actualQuantity = 0,
    this.goodQuantity = 0,
    this.rejectedQuantity = 0,
    this.allocatedBudget,
    this.actualCost = 0.0,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.updatedBy,
    this.version = 1,
    this.metadata = const {},
  });

  @override
  String get id => ofNumber;

  /// Creates a copy with updated fields
  OfOrder copyWith({
    String? ofNumber,
    String? title,
    String? description,
    String? clientName,
    String? productReference,
    int? plannedQuantity,
    String? unit,
    OfOrderStatus? status,
    OfOrderPriority? priority,
    QualityStatus? qualityStatus,
    String? productionLine,
    String? supervisorId,
    DateTime? plannedStartDate,
    DateTime? actualStartDate,
    DateTime? plannedCompletionDate,
    DateTime? actualCompletionDate,
    DateTime? deliveryDeadline,
    DateTime? actualDeliveryDate,
    List<String>? requiredMaterials,
    List<String>? qualitySpecifications,
    List<ProductionNote>? productionNotes,
    List<QualityCheck>? qualityChecks,
    int? progressPercentage,
    int? actualQuantity,
    int? goodQuantity,
    int? rejectedQuantity,
    double? allocatedBudget,
    double? actualCost,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? updatedBy,
    int? version,
    Map<String, dynamic>? metadata,
  }) {
    return OfOrder(
      ofNumber: ofNumber ?? this.ofNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      clientName: clientName ?? this.clientName,
      productReference: productReference ?? this.productReference,
      plannedQuantity: plannedQuantity ?? this.plannedQuantity,
      unit: unit ?? this.unit,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      qualityStatus: qualityStatus ?? this.qualityStatus,
      productionLine: productionLine ?? this.productionLine,
      supervisorId: supervisorId ?? this.supervisorId,
      plannedStartDate: plannedStartDate ?? this.plannedStartDate,
      actualStartDate: actualStartDate ?? this.actualStartDate,
      plannedCompletionDate:
          plannedCompletionDate ?? this.plannedCompletionDate,
      actualCompletionDate: actualCompletionDate ?? this.actualCompletionDate,
      deliveryDeadline: deliveryDeadline ?? this.deliveryDeadline,
      actualDeliveryDate: actualDeliveryDate ?? this.actualDeliveryDate,
      requiredMaterials: requiredMaterials ?? this.requiredMaterials,
      qualitySpecifications:
          qualitySpecifications ?? this.qualitySpecifications,
      productionNotes: productionNotes ?? this.productionNotes,
      qualityChecks: qualityChecks ?? this.qualityChecks,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      actualQuantity: actualQuantity ?? this.actualQuantity,
      goodQuantity: goodQuantity ?? this.goodQuantity,
      rejectedQuantity: rejectedQuantity ?? this.rejectedQuantity,
      allocatedBudget: allocatedBudget ?? this.allocatedBudget,
      actualCost: actualCost ?? this.actualCost,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      version: version ?? this.version,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Checks if order is in terminal state
  bool get isCompleted =>
      status == OfOrderStatus.completed ||
      status == OfOrderStatus.delivered ||
      status == OfOrderStatus.cancelled;

  /// Checks if order is overdue
  bool get isOverdue {
    if (plannedCompletionDate == null || isCompleted) return false;
    return DateTime.now().isAfter(plannedCompletionDate!);
  }

  /// Checks if delivery is overdue
  bool get isDeliveryOverdue {
    if (deliveryDeadline == null || status == OfOrderStatus.delivered) {
      return false;
    }
    return DateTime.now().isAfter(deliveryDeadline!);
  }

  /// Calculates production efficiency
  double get efficiency {
    if (plannedQuantity == 0) return 0.0;
    return (goodQuantity / plannedQuantity) * 100.0;
  }

  /// Calculates scrap rate
  double get scrapRate {
    if (actualQuantity == 0) return 0.0;
    return (rejectedQuantity / actualQuantity) * 100.0;
  }

  /// Calculates budget variance
  double? get budgetVariance {
    if (allocatedBudget == null) return null;
    return actualCost - allocatedBudget!;
  }

  /// Checks if order is within budget
  bool get isWithinBudget {
    if (allocatedBudget == null) return true;
    return actualCost <= allocatedBudget!;
  }

  /// Calculates days since creation
  int get daysSinceCreation {
    return DateTime.now().difference(createdAt).inDays;
  }

  /// Returns status display name in French
  String get statusDisplayName {
    switch (status) {
      case OfOrderStatus.draft:
        return 'Brouillon';
      case OfOrderStatus.planned:
        return 'Planifié';
      case OfOrderStatus.materialWaiting:
        return 'En attente matériaux';
      case OfOrderStatus.inProgress:
        return 'En cours';
      case OfOrderStatus.qualityCheck:
        return 'Contrôle qualité';
      case OfOrderStatus.completed:
        return 'Terminé';
      case OfOrderStatus.delivered:
        return 'Livré';
      case OfOrderStatus.cancelled:
        return 'Annulé';
    }
  }

  /// Returns priority display name in French
  String get priorityDisplayName {
    switch (priority) {
      case OfOrderPriority.low:
        return 'Faible';
      case OfOrderPriority.normal:
        return 'Normal';
      case OfOrderPriority.high:
        return 'Élevé';
      case OfOrderPriority.urgent:
        return 'Urgent';
    }
  }

  /// Returns quality status display name in French
  String get qualityStatusDisplayName {
    switch (qualityStatus) {
      case QualityStatus.pending:
        return 'En attente';
      case QualityStatus.inProgress:
        return 'En cours';
      case QualityStatus.passed:
        return 'Réussi';
      case QualityStatus.failed:
        return 'Échoué';
      case QualityStatus.rework:
        return 'Retravaillé';
    }
  }

  /// Updates order status with automatic timestamp handling
  OfOrder updateStatus(OfOrderStatus newStatus, {String? updatedBy}) {
    final now = DateTime.now();
    DateTime? actualStart = actualStartDate;
    DateTime? actualCompletion = actualCompletionDate;
    DateTime? actualDelivery = actualDeliveryDate;

    if (newStatus == OfOrderStatus.inProgress && actualStart == null) {
      actualStart = now;
    } else if (newStatus == OfOrderStatus.completed &&
        actualCompletion == null) {
      actualCompletion = now;
    } else if (newStatus == OfOrderStatus.delivered && actualDelivery == null) {
      actualDelivery = now;
    }

    return copyWith(
      status: newStatus,
      actualStartDate: actualStart,
      actualCompletionDate: actualCompletion,
      actualDeliveryDate: actualDelivery,
      updatedAt: now,
      updatedBy: updatedBy,
      metadata: {
        ...metadata,
        'statusUpdateHistory': [
          ...metadata['statusUpdateHistory'] ?? [],
          {
            'from': status.name,
            'to': newStatus.name,
            'timestamp': now.toIso8601String(),
            'updatedBy': updatedBy,
          }
        ],
      },
    );
  }

  /// Updates production progress
  OfOrder updateProgress({
    int? progressPercentage,
    int? actualQuantity,
    int? goodQuantity,
    int? rejectedQuantity,
    double? actualCost,
    String? updatedBy,
  }) {
    return copyWith(
      progressPercentage:
          progressPercentage?.clamp(0, 100) ?? this.progressPercentage,
      actualQuantity: actualQuantity ?? this.actualQuantity,
      goodQuantity: goodQuantity ?? this.goodQuantity,
      rejectedQuantity: rejectedQuantity ?? this.rejectedQuantity,
      actualCost: actualCost ?? this.actualCost,
      updatedAt: DateTime.now(),
      updatedBy: updatedBy,
    );
  }

  /// Adds a production note
  OfOrder addProductionNote(String note, String authorId) {
    final newNote = ProductionNote(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: note,
      authorId: authorId,
      timestamp: DateTime.now(),
    );

    return copyWith(
      productionNotes: [...productionNotes, newNote],
      updatedAt: DateTime.now(),
    );
  }

  /// Adds a quality check result
  OfOrder addQualityCheck(QualityCheck check) {
    return copyWith(
      qualityChecks: [...qualityChecks, check],
      qualityStatus: check.passed ? QualityStatus.passed : QualityStatus.failed,
      updatedAt: DateTime.now(),
    );
  }
}
