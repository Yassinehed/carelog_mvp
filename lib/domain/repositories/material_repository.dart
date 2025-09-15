import 'package:dartz/dartz.dart';
import '../../domain/core/entities.dart';
import '../entities/material.dart';

/// Repository interface for Material domain operations
abstract class MaterialRepository extends BaseRepository<Material> {
  /// Get materials by type
  Future<Either<Failure, List<Material>>> getByType(MaterialType type);

  /// Get materials by category
  Future<Either<Failure, List<Material>>> getByCategory(String category);

  /// Get materials by supplier
  Future<Either<Failure, List<Material>>> getBySupplier(String supplierId);

  /// Get materials by stock status
  Future<Either<Failure, List<Material>>> getByStockStatus(StockStatus status);

  /// Get low stock materials
  Future<Either<Failure, List<Material>>> getLowStock();

  /// Get out of stock materials
  Future<Either<Failure, List<Material>>> getOutOfStock();

  /// Get materials needing reorder
  Future<Either<Failure, List<Material>>> getNeedingReorder();

  /// Get expired materials
  Future<Either<Failure, List<Material>>> getExpired();

  /// Get materials expiring soon
  Future<Either<Failure, List<Material>>> getExpiringSoon();

  /// Update stock level
  Future<Either<Failure, Material>> updateStock(
    String materialId,
    double quantity,
    String type,
    String reason,
    String userId, {
    String? reference,
    Map<String, dynamic>? metadata,
  });

  /// Adjust stock level (for corrections)
  Future<Either<Failure, Material>> adjustStock(
    String materialId,
    double newStock,
    String reason,
    String userId, {
    Map<String, dynamic>? metadata,
  });

  /// Record stock in
  Future<Either<Failure, Material>> stockIn(
    String materialId,
    double quantity,
    String reason,
    String userId, {
    String? reference,
    Map<String, dynamic>? metadata,
  });

  /// Record stock out
  Future<Either<Failure, Material>> stockOut(
    String materialId,
    double quantity,
    String reason,
    String userId, {
    String? reference,
    Map<String, dynamic>? metadata,
  });

  /// Update material information
  Future<Either<Failure, Material>> updateInfo(
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
  });

  /// Get stock movements for material
  Future<Either<Failure, List<StockMovement>>> getStockMovements(
    String materialId, {
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  });

  /// Get materials compatible with machine
  Future<Either<Failure, List<Material>>> getCompatibleWithMachine(
    String machineId,
  );

  /// Get material statistics
  Future<Either<Failure, MaterialStats>> getStatistics();

  /// Search materials with filters
  Future<Either<Failure, List<Material>>> searchWithFilters({
    String? query,
    MaterialType? type,
    String? category,
    StockStatus? stockStatus,
    String? supplierId,
    bool? isActive,
    DateTime? expiryBefore,
  });

  /// Get materials count by status
  Future<Either<Failure, Map<StockStatus, int>>> getCountByStatus();

  /// Get total inventory value
  Future<Either<Failure, double>> getTotalInventoryValue();

  /// Get inventory value by category
  Future<Either<Failure, Map<String, double>>> getInventoryValueByCategory();

  /// Get stock alerts
  Future<Either<Failure, List<StockAlert>>> getStockAlerts();

  /// Bulk update stock levels
  Future<Either<Failure, List<Material>>> bulkUpdateStock(
    List<StockUpdate> updates,
    String userId,
  );

  /// Get supplier information
  Future<Either<Failure, Supplier>> getSupplier(String supplierId);

  /// Get all suppliers
  Future<Either<Failure, List<Supplier>>> getAllSuppliers();

  /// Update supplier information
  Future<Either<Failure, Supplier>> updateSupplier(
    String supplierId,
    Supplier supplier,
  );
}

/// Stock update for bulk operations
class StockUpdate {
  final String materialId;
  final double quantity;
  final String type;
  final String reason;
  final String? reference;
  final Map<String, dynamic>? metadata;

  const StockUpdate({
    required this.materialId,
    required this.quantity,
    required this.type,
    required this.reason,
    this.reference,
    this.metadata,
  });
}

/// Stock alert for low/expired materials
class StockAlert {
  final String materialId;
  final String materialName;
  final String
      alertType; // 'low_stock', 'out_of_stock', 'expired', 'expiring_soon'
  final String message;
  final DateTime? expiryDate;
  final double currentStock;
  final double minimumStock;

  const StockAlert({
    required this.materialId,
    required this.materialName,
    required this.alertType,
    required this.message,
    this.expiryDate,
    required this.currentStock,
    required this.minimumStock,
  });
}

/// Statistics for materials/inventory
class MaterialStats {
  final int totalMaterials;
  final int activeMaterials;
  final int inStock;
  final int lowStock;
  final int outOfStock;
  final int expired;
  final int expiringSoon;
  final double totalInventoryValue;
  final Map<MaterialType, int> byType;
  final Map<String, int> byCategory;
  final Map<String, int> bySupplier;
  final double stockTurnoverRatio;
  final DateTime lastUpdated;

  const MaterialStats({
    required this.totalMaterials,
    required this.activeMaterials,
    required this.inStock,
    required this.lowStock,
    required this.outOfStock,
    required this.expired,
    required this.expiringSoon,
    required this.totalInventoryValue,
    required this.byType,
    required this.byCategory,
    required this.bySupplier,
    required this.stockTurnoverRatio,
    required this.lastUpdated,
  });
}
