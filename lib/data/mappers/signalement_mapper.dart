import '../../domain/entities/signalement.dart' as domain;
import '../models/signalement_model.dart' as model;

/// Mapper for converting between Signalement domain entity and SignalementModel data model
class SignalementMapper {
  /// Converts SignalementModel to Signalement domain entity
  static domain.Signalement toDomain(model.Signalement modelSignalement) {
    return domain.Signalement(
      id: modelSignalement.id,
      title: modelSignalement.title,
      description: modelSignalement.description,
      priority: _mapPriorityModelToDomain(modelSignalement.priority),
      status: _mapStatusModelToDomain(modelSignalement.status),
      category: _mapCategoryModelToDomain(modelSignalement.category),
      createdBy: modelSignalement.createdBy,
      assignedTo: modelSignalement.assignedTo,
      ofNumber: modelSignalement.ofNumber,
      location: modelSignalement.location,
      equipment: modelSignalement.equipment,
      materialBatch: modelSignalement.materialBatch,
      expectedResolutionDate: modelSignalement.expectedResolutionDate,
      actualResolutionDate: modelSignalement.actualResolutionDate,
      resolutionNotes: modelSignalement.resolutionNotes,
      createdAt: modelSignalement.createdAt,
      updatedAt: modelSignalement.updatedAt,
      version: modelSignalement.version,
      metadata: modelSignalement.metadata,
    );
  }

  /// Converts Signalement domain entity to SignalementModel
  static model.Signalement toModel(domain.Signalement entity) {
    return model.Signalement(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      priority: mapPriorityDomainToModel(entity.priority),
      status: mapStatusDomainToModel(entity.status),
      category: mapCategoryDomainToModel(entity.category),
      createdBy: entity.createdBy,
      assignedTo: entity.assignedTo,
      ofNumber: entity.ofNumber,
      location: entity.location,
      equipment: entity.equipment,
      materialBatch: entity.materialBatch,
      expectedResolutionDate: entity.expectedResolutionDate,
      actualResolutionDate: entity.actualResolutionDate,
      resolutionNotes: entity.resolutionNotes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      version: entity.version,
      metadata: entity.metadata,
    );
  }

  /// Converts SignalementPriorityModel to SignalementPriority domain enum
  static domain.SignalementPriority _mapPriorityModelToDomain(
      model.SignalementPriority modelPriority) {
    switch (modelPriority) {
      case model.SignalementPriority.low:
        return domain.SignalementPriority.low;
      case model.SignalementPriority.medium:
        return domain.SignalementPriority.medium;
      case model.SignalementPriority.high:
        return domain.SignalementPriority.high;
      case model.SignalementPriority.critical:
        return domain.SignalementPriority.critical;
    }
  }

  /// Converts SignalementPriority domain enum to SignalementPriorityModel
  static model.SignalementPriority mapPriorityDomainToModel(
      domain.SignalementPriority domainPriority) {
    return _mapPriorityDomainToModel(domainPriority);
  }

  /// Converts SignalementStatusModel to SignalementStatus domain enum
  static domain.SignalementStatus _mapStatusModelToDomain(
      model.SignalementStatus modelStatus) {
    switch (modelStatus) {
      case model.SignalementStatus.draft:
        return domain.SignalementStatus.draft;
      case model.SignalementStatus.submitted:
        return domain.SignalementStatus.submitted;
      case model.SignalementStatus.inProgress:
        return domain.SignalementStatus.inProgress;
      case model.SignalementStatus.resolved:
        return domain.SignalementStatus.resolved;
      case model.SignalementStatus.closed:
        return domain.SignalementStatus.closed;
      case model.SignalementStatus.cancelled:
        return domain.SignalementStatus.cancelled;
    }
  }

  /// Converts SignalementStatus domain enum to SignalementStatusModel
  static model.SignalementStatus mapStatusDomainToModel(
      domain.SignalementStatus domainStatus) {
    return _mapStatusDomainToModel(domainStatus);
  }

  /// Converts SignalementCategory domain enum to SignalementCategoryModel
  static model.SignalementCategory mapCategoryDomainToModel(
      domain.SignalementCategory domainCategory) {
    return _mapCategoryDomainToModel(domainCategory);
  }

  /// Converts SignalementPriority domain enum to SignalementPriorityModel
  static model.SignalementPriority _mapPriorityDomainToModel(
      domain.SignalementPriority domainPriority) {
    switch (domainPriority) {
      case domain.SignalementPriority.low:
        return model.SignalementPriority.low;
      case domain.SignalementPriority.medium:
        return model.SignalementPriority.medium;
      case domain.SignalementPriority.high:
        return model.SignalementPriority.high;
      case domain.SignalementPriority.critical:
        return model.SignalementPriority.critical;
    }
  }

  /// Converts SignalementStatus domain enum to SignalementStatusModel
  static model.SignalementStatus _mapStatusDomainToModel(
      domain.SignalementStatus domainStatus) {
    switch (domainStatus) {
      case domain.SignalementStatus.draft:
        return model.SignalementStatus.draft;
      case domain.SignalementStatus.submitted:
        return model.SignalementStatus.submitted;
      case domain.SignalementStatus.inProgress:
        return model.SignalementStatus.inProgress;
      case domain.SignalementStatus.resolved:
        return model.SignalementStatus.resolved;
      case domain.SignalementStatus.closed:
        return model.SignalementStatus.closed;
      case domain.SignalementStatus.cancelled:
        return model.SignalementStatus.cancelled;
    }
  }

  /// Converts SignalementCategoryModel to SignalementCategory domain enum
  static domain.SignalementCategory _mapCategoryModelToDomain(
      model.SignalementCategory modelCategory) {
    switch (modelCategory) {
      case model.SignalementCategory.quality:
        return domain.SignalementCategory.quality;
      case model.SignalementCategory.equipment:
        return domain.SignalementCategory.equipment;
      case model.SignalementCategory.material:
        return domain.SignalementCategory.material;
      case model.SignalementCategory.process:
        return domain.SignalementCategory.process;
      case model.SignalementCategory.safety:
        return domain.SignalementCategory.safety;
      case model.SignalementCategory.other:
        return domain.SignalementCategory.other;
    }
  }

  /// Converts SignalementCategory domain enum to SignalementCategoryModel
  static model.SignalementCategory _mapCategoryDomainToModel(
      domain.SignalementCategory domainCategory) {
    switch (domainCategory) {
      case domain.SignalementCategory.quality:
        return model.SignalementCategory.quality;
      case domain.SignalementCategory.equipment:
        return model.SignalementCategory.equipment;
      case domain.SignalementCategory.material:
        return model.SignalementCategory.material;
      case domain.SignalementCategory.process:
        return model.SignalementCategory.process;
      case domain.SignalementCategory.safety:
        return model.SignalementCategory.safety;
      case domain.SignalementCategory.other:
        return model.SignalementCategory.other;
    }
  }
}
