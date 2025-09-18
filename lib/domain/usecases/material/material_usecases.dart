import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/entities.dart';
import '../../../domain/entities/material.dart';
import '../../../domain/repositories/material_repository.dart';

/// Use case for getting material by ID
@injectable
class GetMaterialById {
  final MaterialRepository _materialRepository;

  GetMaterialById(this._materialRepository);

  Future<Either<Failure, Material>> call(String materialId) async {
    return await _materialRepository.getById(materialId);
  }
}

/// Use case for getting all materials
@injectable
class GetAllMaterials {
  final MaterialRepository _materialRepository;

  GetAllMaterials(this._materialRepository);

  Future<Either<Failure, List<Material>>> call() async {
    return await _materialRepository.getAll();
  }
}

/// Use case for creating a new material
@injectable
class CreateMaterial {
  final MaterialRepository _materialRepository;

  CreateMaterial(this._materialRepository);

  Future<Either<Failure, Material>> call(Material material) async {
    return await _materialRepository.create(material);
  }
}

/// Use case for updating material
@injectable
class UpdateMaterial {
  final MaterialRepository _materialRepository;

  UpdateMaterial(this._materialRepository);

  Future<Either<Failure, Material>> call(Material material) async {
    return await _materialRepository.update(material);
  }
}

/// Use case for deleting material
@injectable
class DeleteMaterial {
  final MaterialRepository _materialRepository;

  DeleteMaterial(this._materialRepository);

  Future<Either<Failure, Unit>> call(String materialId) async {
    return await _materialRepository.delete(materialId);
  }
}

/// Use case for getting materials by type
@injectable
class GetMaterialsByType {
  final MaterialRepository _materialRepository;

  GetMaterialsByType(this._materialRepository);

  Future<Either<Failure, List<Material>>> call(MaterialType type) async {
    return await _materialRepository.getByType(type);
  }
}

/// Use case for getting materials by category
@injectable
class GetMaterialsByCategory {
  final MaterialRepository _materialRepository;

  GetMaterialsByCategory(this._materialRepository);

  Future<Either<Failure, List<Material>>> call(String category) async {
    return await _materialRepository.getByCategory(category);
  }
}

/// Use case for getting materials by stock status
@injectable
class GetMaterialsByStockStatus {
  final MaterialRepository _materialRepository;

  GetMaterialsByStockStatus(this._materialRepository);

  Future<Either<Failure, List<Material>>> call(StockStatus status) async {
    return await _materialRepository.getByStockStatus(status);
  }
}

/// Use case for getting low stock materials
@injectable
class GetLowStockMaterials {
  final MaterialRepository _materialRepository;

  GetLowStockMaterials(this._materialRepository);

  Future<Either<Failure, List<Material>>> call() async {
    return await _materialRepository.getLowStock();
  }
}

/// Use case for getting out of stock materials
@injectable
class GetOutOfStockMaterials {
  final MaterialRepository _materialRepository;

  GetOutOfStockMaterials(this._materialRepository);

  Future<Either<Failure, List<Material>>> call() async {
    return await _materialRepository.getOutOfStock();
  }
}

/// Use case for getting materials needing reorder
@injectable
class GetMaterialsNeedingReorder {
  final MaterialRepository _materialRepository;

  GetMaterialsNeedingReorder(this._materialRepository);

  Future<Either<Failure, List<Material>>> call() async {
    return await _materialRepository.getNeedingReorder();
  }
}

/// Use case for updating stock level
@injectable
class UpdateMaterialStock {
  final MaterialRepository _materialRepository;

  UpdateMaterialStock(this._materialRepository);

  Future<Either<Failure, Material>> call(
    String materialId,
    double quantity,
    String type,
    String reason,
    String userId, {
    String? reference,
    Map<String, dynamic>? metadata,
  }) async {
    return await _materialRepository.updateStock(
      materialId,
      quantity,
      type,
      reason,
      userId,
      reference: reference,
      metadata: metadata,
    );
  }
}

/// Use case for stock in operation
@injectable
class StockInMaterial {
  final MaterialRepository _materialRepository;

  StockInMaterial(this._materialRepository);

  Future<Either<Failure, Material>> call(
    String materialId,
    double quantity,
    String reason,
    String userId, {
    String? reference,
    Map<String, dynamic>? metadata,
  }) async {
    return await _materialRepository.stockIn(
      materialId,
      quantity,
      reason,
      userId,
      reference: reference,
      metadata: metadata,
    );
  }
}

/// Use case for stock out operation
@injectable
class StockOutMaterial {
  final MaterialRepository _materialRepository;

  StockOutMaterial(this._materialRepository);

  Future<Either<Failure, Material>> call(
    String materialId,
    double quantity,
    String reason,
    String userId, {
    String? reference,
    Map<String, dynamic>? metadata,
  }) async {
    return await _materialRepository.stockOut(
      materialId,
      quantity,
      reason,
      userId,
      reference: reference,
      metadata: metadata,
    );
  }
}

/// Use case for updating material information
@injectable
class UpdateMaterialInfo {
  final MaterialRepository _materialRepository;

  UpdateMaterialInfo(this._materialRepository);

  Future<Either<Failure, Material>> call(
    String materialId, {
    String? name,
    String? description,
    MaterialType? type,
    UnitOfMeasure? unitOfMeasure,
    String? category,
    String? subCategory,
    String? supplierId,
    double? minimumStock,
    double? maximumStock,
    double? reorderPoint,
    double? unitPrice,
    String? currency,
    String? location,
    String? barcode,
    String? qrCode,
    DateTime? expiryDate,
    List<String>? compatibleMachines,
    List<String>? qualitySpecifications,
    String? updatedBy,
    Map<String, dynamic>? metadata,
  }) async {
    return await _materialRepository.updateInfo(
      materialId,
      name: name,
      description: description,
      type: type,
      unitOfMeasure: unitOfMeasure,
      category: category,
      subCategory: subCategory,
      supplierId: supplierId,
      minimumStock: minimumStock,
      maximumStock: maximumStock,
      reorderPoint: reorderPoint,
      unitPrice: unitPrice,
      currency: currency,
      location: location,
      barcode: barcode,
      qrCode: qrCode,
      expiryDate: expiryDate,
      compatibleMachines: compatibleMachines,
      qualitySpecifications: qualitySpecifications,
      updatedBy: updatedBy,
      metadata: metadata,
    );
  }
}

/// Use case for getting material statistics
@injectable
class GetMaterialStatistics {
  final MaterialRepository _materialRepository;

  GetMaterialStatistics(this._materialRepository);

  Future<Either<Failure, MaterialStats>> call() async {
    return await _materialRepository.getStatistics();
  }
}

/// Use case for getting stock alerts
@injectable
class GetStockAlerts {
  final MaterialRepository _materialRepository;

  GetStockAlerts(this._materialRepository);

  Future<Either<Failure, List<StockAlert>>> call() async {
    return await _materialRepository.getStockAlerts();
  }
}
