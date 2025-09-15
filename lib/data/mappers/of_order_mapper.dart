import '../../domain/entities/of_order.dart' as domain;
import '../models/of_order_model.dart' as model;

/// Mapper for converting between OfOrder domain entity and OfOrderModel data model
class OfOrderMapper {
  /// Converts OfOrderModel to OfOrder domain entity
  static domain.OfOrder toDomain(model.OfOrder modelOfOrder) {
    return domain.OfOrder(
      ofNumber: modelOfOrder.ofNumber,
      title: modelOfOrder.title,
      description: modelOfOrder.description,
      clientName: modelOfOrder.clientName,
      productReference: modelOfOrder.productReference,
      plannedQuantity: modelOfOrder.plannedQuantity,
      unit: modelOfOrder.unit,
      status: _mapStatusModelToDomain(modelOfOrder.status),
      priority: _mapPriorityModelToDomain(modelOfOrder.priority),
      qualityStatus: _mapQualityStatusModelToDomain(modelOfOrder.qualityStatus),
      productionLine: modelOfOrder.productionLine,
      supervisorId: modelOfOrder.supervisorId,
      plannedStartDate: modelOfOrder.plannedStartDate,
      actualStartDate: modelOfOrder.actualStartDate,
      plannedCompletionDate: modelOfOrder.plannedCompletionDate,
      actualCompletionDate: modelOfOrder.actualCompletionDate,
      deliveryDeadline: modelOfOrder.deliveryDeadline,
      actualDeliveryDate: modelOfOrder.actualDeliveryDate,
      requiredMaterials: modelOfOrder.requiredMaterials,
      qualitySpecifications: modelOfOrder.qualitySpecifications,
      productionNotes: modelOfOrder.productionNotes
          .map(_mapProductionNoteModelToDomain)
          .toList(),
      qualityChecks: modelOfOrder.qualityChecks
          .map(_mapQualityCheckModelToDomain)
          .toList(),
      progressPercentage: modelOfOrder.progressPercentage,
      actualQuantity: modelOfOrder.actualQuantity,
      goodQuantity: modelOfOrder.goodQuantity,
      rejectedQuantity: modelOfOrder.rejectedQuantity,
      allocatedBudget: modelOfOrder.allocatedBudget,
      actualCost: modelOfOrder.actualCost,
      createdAt: modelOfOrder.createdAt,
      updatedAt: modelOfOrder.updatedAt,
      createdBy: modelOfOrder.createdBy,
      updatedBy: modelOfOrder.updatedBy,
      version: modelOfOrder.version,
      metadata: modelOfOrder.metadata,
    );
  }

  /// Converts OfOrder domain entity to OfOrderModel
  static model.OfOrder toModel(domain.OfOrder entity) {
    return model.OfOrder(
      ofNumber: entity.ofNumber,
      title: entity.title,
      description: entity.description,
      clientName: entity.clientName,
      productReference: entity.productReference,
      plannedQuantity: entity.plannedQuantity,
      unit: entity.unit,
      status: _mapStatusDomainToModel(entity.status),
      priority: _mapPriorityDomainToModel(entity.priority),
      qualityStatus: _mapQualityStatusDomainToModel(entity.qualityStatus),
      productionLine: entity.productionLine,
      supervisorId: entity.supervisorId,
      plannedStartDate: entity.plannedStartDate,
      actualStartDate: entity.actualStartDate,
      plannedCompletionDate: entity.plannedCompletionDate,
      actualCompletionDate: entity.actualCompletionDate,
      deliveryDeadline: entity.deliveryDeadline,
      actualDeliveryDate: entity.actualDeliveryDate,
      requiredMaterials: entity.requiredMaterials,
      qualitySpecifications: entity.qualitySpecifications,
      productionNotes:
          entity.productionNotes.map(_mapProductionNoteDomainToModel).toList(),
      qualityChecks:
          entity.qualityChecks.map(_mapQualityCheckDomainToModel).toList(),
      progressPercentage: entity.progressPercentage,
      actualQuantity: entity.actualQuantity,
      goodQuantity: entity.goodQuantity,
      rejectedQuantity: entity.rejectedQuantity,
      allocatedBudget: entity.allocatedBudget,
      actualCost: entity.actualCost,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      version: entity.version,
      metadata: entity.metadata,
    );
  }

  /// Converts OfOrderStatusModel to OfOrderStatus domain enum
  static domain.OfOrderStatus _mapStatusModelToDomain(
      model.OfOrderStatus modelStatus) {
    switch (modelStatus) {
      case model.OfOrderStatus.draft:
        return domain.OfOrderStatus.draft;
      case model.OfOrderStatus.planned:
        return domain.OfOrderStatus.planned;
      case model.OfOrderStatus.materialWaiting:
        return domain.OfOrderStatus.materialWaiting;
      case model.OfOrderStatus.inProgress:
        return domain.OfOrderStatus.inProgress;
      case model.OfOrderStatus.qualityCheck:
        return domain.OfOrderStatus.qualityCheck;
      case model.OfOrderStatus.completed:
        return domain.OfOrderStatus.completed;
      case model.OfOrderStatus.delivered:
        return domain.OfOrderStatus.delivered;
      case model.OfOrderStatus.cancelled:
        return domain.OfOrderStatus.cancelled;
    }
  }

  /// Converts OfOrderStatus domain enum to OfOrderStatusModel
  static model.OfOrderStatus _mapStatusDomainToModel(
      domain.OfOrderStatus domainStatus) {
    switch (domainStatus) {
      case domain.OfOrderStatus.draft:
        return model.OfOrderStatus.draft;
      case domain.OfOrderStatus.planned:
        return model.OfOrderStatus.planned;
      case domain.OfOrderStatus.materialWaiting:
        return model.OfOrderStatus.materialWaiting;
      case domain.OfOrderStatus.inProgress:
        return model.OfOrderStatus.inProgress;
      case domain.OfOrderStatus.qualityCheck:
        return model.OfOrderStatus.qualityCheck;
      case domain.OfOrderStatus.completed:
        return model.OfOrderStatus.completed;
      case domain.OfOrderStatus.delivered:
        return model.OfOrderStatus.delivered;
      case domain.OfOrderStatus.cancelled:
        return model.OfOrderStatus.cancelled;
    }
  }

  /// Converts OfOrderPriorityModel to OfOrderPriority domain enum
  static domain.OfOrderPriority _mapPriorityModelToDomain(
      model.OfOrderPriority modelPriority) {
    switch (modelPriority) {
      case model.OfOrderPriority.low:
        return domain.OfOrderPriority.low;
      case model.OfOrderPriority.normal:
        return domain.OfOrderPriority.normal;
      case model.OfOrderPriority.high:
        return domain.OfOrderPriority.high;
      case model.OfOrderPriority.urgent:
        return domain.OfOrderPriority.urgent;
    }
  }

  /// Converts OfOrderPriority domain enum to OfOrderPriorityModel
  static model.OfOrderPriority _mapPriorityDomainToModel(
      domain.OfOrderPriority domainPriority) {
    switch (domainPriority) {
      case domain.OfOrderPriority.low:
        return model.OfOrderPriority.low;
      case domain.OfOrderPriority.normal:
        return model.OfOrderPriority.normal;
      case domain.OfOrderPriority.high:
        return model.OfOrderPriority.high;
      case domain.OfOrderPriority.urgent:
        return model.OfOrderPriority.urgent;
    }
  }

  /// Converts QualityStatusModel to QualityStatus domain enum
  static domain.QualityStatus _mapQualityStatusModelToDomain(
      model.QualityStatus modelQualityStatus) {
    switch (modelQualityStatus) {
      case model.QualityStatus.pending:
        return domain.QualityStatus.pending;
      case model.QualityStatus.inProgress:
        return domain.QualityStatus.inProgress;
      case model.QualityStatus.passed:
        return domain.QualityStatus.passed;
      case model.QualityStatus.failed:
        return domain.QualityStatus.failed;
      case model.QualityStatus.rework:
        return domain.QualityStatus.rework;
    }
  }

  /// Converts QualityStatus domain enum to QualityStatusModel
  static model.QualityStatus _mapQualityStatusDomainToModel(
      domain.QualityStatus domainQualityStatus) {
    switch (domainQualityStatus) {
      case domain.QualityStatus.pending:
        return model.QualityStatus.pending;
      case domain.QualityStatus.inProgress:
        return model.QualityStatus.inProgress;
      case domain.QualityStatus.passed:
        return model.QualityStatus.passed;
      case domain.QualityStatus.failed:
        return model.QualityStatus.failed;
      case domain.QualityStatus.rework:
        return model.QualityStatus.rework;
    }
  }

  /// Converts ProductionNoteModel to ProductionNote domain entity
  static domain.ProductionNote _mapProductionNoteModelToDomain(
      model.ProductionNote modelNote) {
    return domain.ProductionNote(
      id: modelNote.id,
      content: modelNote.content,
      authorId: modelNote.authorId,
      timestamp: modelNote.timestamp,
    );
  }

  /// Converts ProductionNote domain entity to ProductionNoteModel
  static model.ProductionNote _mapProductionNoteDomainToModel(
      domain.ProductionNote domainNote) {
    return model.ProductionNote(
      id: domainNote.id,
      content: domainNote.content,
      authorId: domainNote.authorId,
      timestamp: domainNote.timestamp,
    );
  }

  /// Converts QualityCheckModel to QualityCheck domain entity
  static domain.QualityCheck _mapQualityCheckModelToDomain(
      model.QualityCheck modelCheck) {
    return domain.QualityCheck(
      id: modelCheck.id,
      checkpoint: modelCheck.checkpoint,
      passed: modelCheck.passed,
      notes: modelCheck.notes,
      inspectorId: modelCheck.inspectorId,
      timestamp: modelCheck.timestamp,
    );
  }

  /// Converts QualityCheck domain entity to QualityCheckModel
  static model.QualityCheck _mapQualityCheckDomainToModel(
      domain.QualityCheck domainCheck) {
    return model.QualityCheck(
      id: domainCheck.id,
      checkpoint: domainCheck.checkpoint,
      passed: domainCheck.passed,
      notes: domainCheck.notes,
      inspectorId: domainCheck.inspectorId,
      timestamp: domainCheck.timestamp,
    );
  }
}
