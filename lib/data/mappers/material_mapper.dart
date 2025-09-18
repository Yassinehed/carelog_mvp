import '../../domain/entities/material.dart' as domain;
import '../models/material_model.dart' as model;

/// Mapper for converting between Material domain entity and MaterialModel data model
class MaterialMapper {
  /// Converts MaterialModel to Material domain entity
  static domain.Material toDomain(model.Material modelMaterial) {
    return domain.Material(
      reference: modelMaterial.reference,
      name: modelMaterial.name,
      description: modelMaterial.description,
      type: _mapCategoryModelToDomain(modelMaterial.category),
      unitOfMeasure: _mapUnitModelToDomain(modelMaterial.unit),
      category: modelMaterial.category.name, // Convert enum to string
      supplier: modelMaterial.supplierName != null
          ? domain.Supplier(
              id: 'supplier_${modelMaterial.supplierName}', // Generate ID
              name: modelMaterial.supplierName!,
              contactEmail: 'unknown@example.com', // Default
              contactPhone: null,
              address: null,
              leadTime: modelMaterial.leadTimeDays?.toDouble(),
            )
          : null,
      currentStock: modelMaterial.currentStock,
      minimumStock: modelMaterial.minimumStock.toDouble(),
      maximumStock: modelMaterial.maximumStock?.toDouble() ?? 0.0,
      reorderPoint: modelMaterial.minimumStock
          .toDouble(), // Use minimumStock as reorderPoint
      unitPrice: modelMaterial.unitCost,
      stockStatus: _mapStockStatusFromModel(modelMaterial),
      isActive: modelMaterial.isActive,
      location: modelMaterial.storageLocation,
      expiryDate: null, // Not available in model
      qualitySpecifications: modelMaterial.qualitySpecifications,
      stockMovements: const [], // Will be populated separately if needed
      createdAt: modelMaterial.createdAt,
      updatedAt: modelMaterial.updatedAt,
      createdBy: modelMaterial.createdBy,
      updatedBy: modelMaterial.updatedBy,
      version: modelMaterial.version,
      metadata: modelMaterial.metadata,
    );
  }

  /// Converts Material domain entity to MaterialModel
  static model.Material toModel(domain.Material entity) {
    return model.Material(
      reference: entity.reference,
      name: entity.name,
      description: entity.description,
      category: mapCategoryDomainToModel(entity.type),
      unit: mapUnitDomainToModel(entity.unitOfMeasure),
      minimumStock: entity.minimumStock.toInt(),
      maximumStock: entity.maximumStock.toInt(),
      currentStock: entity.currentStock,
      unitCost: entity.unitPrice,
      supplierName: entity.supplier?.name,
      supplierReference: null, // Not available in domain
      leadTimeDays: entity.supplier?.leadTime?.toInt(),
      storageLocation: entity.location,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      createdBy: entity.createdBy,
      updatedBy: entity.updatedBy,
      version: entity.version,
      metadata: entity.metadata,
    );
  }

  /// Converts MaterialCategoryModel to MaterialType domain enum
  static domain.MaterialType _mapCategoryModelToDomain(
      model.MaterialCategory modelCategory) {
    switch (modelCategory) {
      case model.MaterialCategory.rawMaterial:
        return domain.MaterialType.rawMaterial;
      case model.MaterialCategory.component:
        return domain.MaterialType.semiFinished;
      case model.MaterialCategory.packaging:
        return domain.MaterialType.packaging;
      case model.MaterialCategory.consumable:
        return domain.MaterialType.consumable;
      case model.MaterialCategory.chemical:
        return domain.MaterialType.rawMaterial;
      case model.MaterialCategory.other:
        return domain.MaterialType.sparePart;
    }
  }

  /// Converts MaterialType domain enum to MaterialCategoryModel
  static model.MaterialCategory mapCategoryDomainToModel(
      domain.MaterialType domainCategory) {
    return _mapCategoryDomainToModel(domainCategory);
  }

  /// Converts MaterialUnitModel to UnitOfMeasure domain enum
  static domain.UnitOfMeasure _mapUnitModelToDomain(
      model.MaterialUnit modelUnit) {
    switch (modelUnit) {
      case model.MaterialUnit.piece:
        return domain.UnitOfMeasure.piece;
      case model.MaterialUnit.kilogram:
        return domain.UnitOfMeasure.kilogram;
      case model.MaterialUnit.gram:
        return domain.UnitOfMeasure.kilogram;
      case model.MaterialUnit.liter:
        return domain.UnitOfMeasure.liter;
      case model.MaterialUnit.milliliter:
        return domain.UnitOfMeasure.liter;
      case model.MaterialUnit.meter:
        return domain.UnitOfMeasure.meter;
      case model.MaterialUnit.squareMeter:
        return domain.UnitOfMeasure.squareMeter;
      case model.MaterialUnit.cubicMeter:
        return domain.UnitOfMeasure.cubicMeter;
      case model.MaterialUnit.box:
        return domain.UnitOfMeasure.box;
      case model.MaterialUnit.pallet:
        return domain.UnitOfMeasure.pallet;
      case model.MaterialUnit.roll:
        return domain.UnitOfMeasure.piece;
      case model.MaterialUnit.other:
        return domain.UnitOfMeasure.piece;
    }
  }

  /// Converts UnitOfMeasure domain enum to MaterialUnitModel
  static model.MaterialUnit mapUnitDomainToModel(
      domain.UnitOfMeasure domainUnit) {
    return _mapUnitDomainToModel(domainUnit);
  }

  /// Maps stock status from model data
  static domain.StockStatus _mapStockStatusFromModel(
      model.Material modelMaterial) {
    if (modelMaterial.currentStock <= 0) {
      return domain.StockStatus.outOfStock;
    } else if (modelMaterial.currentStock <= modelMaterial.minimumStock) {
      return domain.StockStatus.lowStock;
    } else {
      return domain.StockStatus.inStock;
    }
  }

  /// Private helper methods for enum conversions
  static model.MaterialCategory _mapCategoryDomainToModel(
      domain.MaterialType domainCategory) {
    switch (domainCategory) {
      case domain.MaterialType.rawMaterial:
        return model.MaterialCategory.rawMaterial;
      case domain.MaterialType.semiFinished:
        return model.MaterialCategory.component;
      case domain.MaterialType.finishedProduct:
        return model.MaterialCategory.other;
      case domain.MaterialType.consumable:
        return model.MaterialCategory.consumable;
      case domain.MaterialType.packaging:
        return model.MaterialCategory.packaging;
      case domain.MaterialType.sparePart:
        return model.MaterialCategory.other;
    }
  }

  static model.MaterialUnit _mapUnitDomainToModel(
      domain.UnitOfMeasure domainUnit) {
    switch (domainUnit) {
      case domain.UnitOfMeasure.piece:
        return model.MaterialUnit.piece;
      case domain.UnitOfMeasure.kilogram:
        return model.MaterialUnit.kilogram;
      case domain.UnitOfMeasure.liter:
        return model.MaterialUnit.liter;
      case domain.UnitOfMeasure.meter:
        return model.MaterialUnit.meter;
      case domain.UnitOfMeasure.squareMeter:
        return model.MaterialUnit.squareMeter;
      case domain.UnitOfMeasure.cubicMeter:
        return model.MaterialUnit.cubicMeter;
      case domain.UnitOfMeasure.hour:
        return model.MaterialUnit.other;
      case domain.UnitOfMeasure.day:
        return model.MaterialUnit.other;
      case domain.UnitOfMeasure.box:
        return model.MaterialUnit.box;
      case domain.UnitOfMeasure.pallet:
        return model.MaterialUnit.pallet;
    }
  }
}
