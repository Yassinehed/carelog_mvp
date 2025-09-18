import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'of_order_model.freezed.dart';
part 'of_order_model.g.dart';

/// Status progression for OF (Manufacturing Order) lifecycle
enum OfOrderStatus {
  draft, // Initial creation
  planned, // Scheduled for production
  materialWaiting, // Waiting for materials
  inProgress, // Production started
  qualityCheck, // Under quality inspection
  completed, // Production finished
  delivered, // Delivered to client
  cancelled // Cancelled/voided
}

/// Priority levels for manufacturing orders
enum OfOrderPriority { low, normal, high, urgent }

/// Quality control status for the order
enum QualityStatus { pending, inProgress, passed, failed, rework }

/// Represents a Manufacturing Order (OF) in the CareLog system.
/// This model encapsulates the complete lifecycle of manufacturing orders
/// including material tracking, quality controls, and production workflow.
@freezed
class OfOrder with _$OfOrder {
  const OfOrder._(); // Private constructor for custom methods

  const factory OfOrder({
    /// Unique OF number (Manufacturing Order Number)
    required String ofNumber,

    /// Human-readable title/description
    required String title,

    /// Detailed description of the manufacturing requirements
    required String description,

    /// Client/customer name
    required String clientName,

    /// Product reference/SKU
    required String productReference,

    /// Planned quantity to produce
    required int plannedQuantity,

    /// Unit of measurement (pieces, kg, meters, etc.)
    required String unit,

    /// Current status in the workflow
    required OfOrderStatus status,

    /// Priority level
    required OfOrderPriority priority,

    /// Quality control status
    @Default(QualityStatus.pending) QualityStatus qualityStatus,

    /// Assigned production line/machine
    String? productionLine,

    /// Supervisor/lead operator ID
    String? supervisorId,

    /// Planned start date
    DateTime? plannedStartDate,

    /// Actual start date
    DateTime? actualStartDate,

    /// Planned completion date
    DateTime? plannedCompletionDate,

    /// Actual completion date
    DateTime? actualCompletionDate,

    /// Delivery deadline
    DateTime? deliveryDeadline,

    /// Actual delivery date
    DateTime? actualDeliveryDate,

    /// Materials required (list of material references)
    @Default([]) List<String> requiredMaterials,

    /// Quality specifications/checkpoints
    @Default([]) List<String> qualitySpecifications,

    /// Production notes/progress updates
    @Default([]) List<ProductionNote> productionNotes,

    /// Quality control results
    @Default([]) List<QualityCheck> qualityChecks,

    /// Current progress percentage (0-100)
    @Default(0) int progressPercentage,

    /// Quantity actually produced
    @Default(0) int actualQuantity,

    /// Quantity that passed quality control
    @Default(0) int goodQuantity,

    /// Quantity rejected/scrap
    @Default(0) int rejectedQuantity,

    /// Budget allocated for this order
    double? allocatedBudget,

    /// Actual costs incurred
    @Default(0.0) double actualCost,

    /// Creation timestamp
    required DateTime createdAt,

    /// Last update timestamp
    required DateTime updatedAt,

    /// User who created the order
    required String createdBy,

    /// Last user who updated the order
    String? updatedBy,

    /// Version for optimistic concurrency
    @Default(1) int version,

    /// Additional metadata
    @Default({}) Map<String, dynamic> metadata,
  }) = _OfOrder;

  /// Creates an OfOrder from JSON data
  factory OfOrder.fromJson(Map<String, dynamic> json) =>
      _$OfOrderFromJson(json);

  /// Creates a new OF Order with default values
  factory OfOrder.create({
    required String title,
    required String description,
    required String clientName,
    required String productReference,
    required int plannedQuantity,
    required String unit,
    required OfOrderPriority priority,
    required String createdBy,
    String? productionLine,
    String? supervisorId,
    DateTime? plannedStartDate,
    DateTime? plannedCompletionDate,
    DateTime? deliveryDeadline,
    List<String>? requiredMaterials,
    List<String>? qualitySpecifications,
    double? allocatedBudget,
    Map<String, dynamic>? metadata,
  }) {
    final now = DateTime.now();
    final ofNumber = _generateOfNumber();

    return OfOrder(
      ofNumber: ofNumber,
      title: title.trim(),
      description: description.trim(),
      clientName: clientName.trim(),
      productReference: productReference.trim(),
      plannedQuantity: plannedQuantity,
      unit: unit.trim(),
      status: OfOrderStatus.draft,
      priority: priority,
      productionLine: productionLine?.trim(),
      supervisorId: supervisorId,
      plannedStartDate: plannedStartDate,
      plannedCompletionDate: plannedCompletionDate,
      deliveryDeadline: deliveryDeadline,
      requiredMaterials: requiredMaterials ?? [],
      qualitySpecifications: qualitySpecifications ?? [],
      allocatedBudget: allocatedBudget,
      createdAt: now,
      updatedAt: now,
      createdBy: createdBy,
      metadata: metadata ?? {},
    );
  }

  /// Generates a unique OF number following enterprise conventions
  static String _generateOfNumber() {
    final now = DateTime.now();
    final year = now.year.toString().substring(2); // Last 2 digits
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final sequence = const Uuid().v4().substring(0, 6).toUpperCase();
    return 'OF$year$month$day$sequence';
  }

  /// Validates the OF Order data integrity
  bool get isValid {
    return ofNumber.isNotEmpty &&
        title.isNotEmpty &&
        title.length <= 200 &&
        description.isNotEmpty &&
        description.length <= 1000 &&
        clientName.isNotEmpty &&
        clientName.length <= 100 &&
        productReference.isNotEmpty &&
        productReference.length <= 50 &&
        plannedQuantity > 0 &&
        unit.isNotEmpty &&
        unit.length <= 20 &&
        (productionLine == null || productionLine!.length <= 50) &&
        (supervisorId == null || supervisorId!.isNotEmpty) &&
        (allocatedBudget == null || allocatedBudget! >= 0);
  }

  /// Checks if the order is in a terminal state
  bool get isCompleted =>
      status == OfOrderStatus.completed ||
      status == OfOrderStatus.delivered ||
      status == OfOrderStatus.cancelled;

  /// Checks if the order is overdue based on planned completion date
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

  /// Calculates production efficiency (good quantity / planned quantity)
  double get efficiency {
    if (plannedQuantity == 0) return 0.0;
    return (goodQuantity / plannedQuantity) * 100.0;
  }

  /// Calculates scrap rate (rejected quantity / actual quantity)
  double get scrapRate {
    if (actualQuantity == 0) return 0.0;
    return (rejectedQuantity / actualQuantity) * 100.0;
  }

  /// Calculates budget variance (actual cost - allocated budget)
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

  /// Calculates days since last update
  int get daysSinceUpdate {
    return DateTime.now().difference(updatedAt).inDays;
  }

  /// Returns a human-readable status description
  String get statusDescription {
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

  /// Returns a human-readable priority description
  String get priorityDescription {
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

  /// Returns a human-readable quality status description
  String get qualityStatusDescription {
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

  /// Updates the order status with automatic timestamp handling
  OfOrder updateStatus(OfOrderStatus newStatus, {String? updatedBy}) {
    final now = DateTime.now();
    DateTime? actualStart = actualStartDate;
    DateTime? actualCompletion = actualCompletionDate;
    DateTime? actualDelivery = actualDeliveryDate;

    // Set actual dates based on status transitions
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
    final newProgress = progressPercentage ?? this.progressPercentage;
    final newActual = actualQuantity ?? this.actualQuantity;
    final newGood = goodQuantity ?? this.goodQuantity;
    final newRejected = rejectedQuantity ?? this.rejectedQuantity;
    final newCost = actualCost ?? this.actualCost;

    return copyWith(
      progressPercentage: newProgress.clamp(0, 100),
      actualQuantity: newActual,
      goodQuantity: newGood,
      rejectedQuantity: newRejected,
      actualCost: newCost,
      updatedAt: DateTime.now(),
      updatedBy: updatedBy,
    );
  }

  /// Adds a production note
  OfOrder addProductionNote(String note, String authorId) {
    final newNote = ProductionNote(
      id: const Uuid().v4(),
      content: note.trim(),
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

  /// Converts to a summary map for list views
  Map<String, dynamic> toSummaryMap() {
    return {
      'ofNumber': ofNumber,
      'title': title,
      'clientName': clientName,
      'productReference': productReference,
      'plannedQuantity': plannedQuantity,
      'unit': unit,
      'status': status.name,
      'priority': priority.name,
      'progressPercentage': progressPercentage,
      'plannedCompletionDate': plannedCompletionDate?.toIso8601String(),
      'deliveryDeadline': deliveryDeadline?.toIso8601String(),
      'isOverdue': isOverdue,
      'isDeliveryOverdue': isDeliveryOverdue,
      'efficiency': efficiency,
      'isWithinBudget': isWithinBudget,
    };
  }

  /// Converts to a detailed map for detail views
  Map<String, dynamic> toDetailMap() {
    return {
      ...toSummaryMap(),
      'description': description,
      'productionLine': productionLine,
      'supervisorId': supervisorId,
      'plannedStartDate': plannedStartDate?.toIso8601String(),
      'actualStartDate': actualStartDate?.toIso8601String(),
      'actualCompletionDate': actualCompletionDate?.toIso8601String(),
      'actualDeliveryDate': actualDeliveryDate?.toIso8601String(),
      'requiredMaterials': requiredMaterials,
      'qualitySpecifications': qualitySpecifications,
      'qualityStatus': qualityStatus.name,
      'actualQuantity': actualQuantity,
      'goodQuantity': goodQuantity,
      'rejectedQuantity': rejectedQuantity,
      'allocatedBudget': allocatedBudget,
      'actualCost': actualCost,
      'budgetVariance': budgetVariance,
      'scrapRate': scrapRate,
      'productionNotes': productionNotes.map((n) => n.toJson()).toList(),
      'qualityChecks': qualityChecks.map((c) => c.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'version': version,
      'metadata': metadata,
    };
  }
}

/// Represents a production note/progress update
@freezed
class ProductionNote with _$ProductionNote {
  const factory ProductionNote({
    required String id,
    required String content,
    required String authorId,
    required DateTime timestamp,
  }) = _ProductionNote;

  factory ProductionNote.fromJson(Map<String, dynamic> json) =>
      _$ProductionNoteFromJson(json);
}

/// Represents a quality control check result
@freezed
class QualityCheck with _$QualityCheck {
  const factory QualityCheck({
    required String id,
    required String checkpoint,
    required bool passed,
    String? notes,
    required String inspectorId,
    required DateTime timestamp,
  }) = _QualityCheck;

  factory QualityCheck.fromJson(Map<String, dynamic> json) =>
      _$QualityCheckFromJson(json);
}
