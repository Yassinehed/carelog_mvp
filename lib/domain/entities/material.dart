import 'package:equatable/equatable.dart';

import '../../domain/core/entities.dart';

/// Material types for categorization
enum MaterialType {
  rawMaterial,
  semiFinished,
  finishedProduct,
  consumable,
  packaging,
  sparePart
}

/// Unit of measurement for materials
enum UnitOfMeasure {
  piece,
  kilogram,
  liter,
  meter,
  squareMeter,
  cubicMeter,
  hour,
  day,
  box,
  pallet
}

/// Stock status for materials
enum StockStatus { inStock, lowStock, outOfStock, onOrder }

/// Supplier information
class Supplier extends Equatable {
  final String id;
  final String name;
  final String contactEmail;
  final String? contactPhone;
  final String? address;
  final double? leadTime; // in days

  const Supplier({
    required this.id,
    required this.name,
    required this.contactEmail,
    this.contactPhone,
    this.address,
    this.leadTime,
  });

  @override
  List<Object?> get props =>
      [id, name, contactEmail, contactPhone, address, leadTime];
}

/// Stock movement record
class StockMovement extends Equatable {
  final String id;
  final String materialId;
  final String type; // 'in', 'out', 'adjustment'
  final double quantity;
  final String unit;
  final String reason;
  final String? reference; // OF number, supplier invoice, etc.
  final String userId;
  final DateTime timestamp;
  final Map<String, dynamic> metadata;

  const StockMovement({
    required this.id,
    required this.materialId,
    required this.type,
    required this.quantity,
    required this.unit,
    required this.reason,
    this.reference,
    required this.userId,
    required this.timestamp,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [
        id,
        materialId,
        type,
        quantity,
        unit,
        reason,
        reference,
        userId,
        timestamp,
        metadata
      ];
}

/// Material entity representing inventory items
class Material extends Entity {
  final String reference;
  final String name;
  final String description;
  final MaterialType type;
  final UnitOfMeasure unitOfMeasure;
  final String category;
  final String? subCategory;
  final Supplier? supplier;
  final double currentStock;
  final double minimumStock;
  final double maximumStock;
  final double reorderPoint;
  final double unitPrice;
  final String currency;
  final StockStatus stockStatus;
  final bool isActive;
  final String? location;
  final String? barcode;
  final String? qrCode;
  final DateTime? lastStockUpdate;
  final DateTime? expiryDate;
  final List<String> compatibleMachines;
  final List<String> qualitySpecifications;
  final List<StockMovement> stockMovements;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String? updatedBy;
  @override
  final int version;
  final Map<String, dynamic> metadata;

  const Material({
    required this.reference,
    required this.name,
    required this.description,
    required this.type,
    required this.unitOfMeasure,
    required this.category,
    this.subCategory,
    this.supplier,
    required this.currentStock,
    required this.minimumStock,
    required this.maximumStock,
    required this.reorderPoint,
    required this.unitPrice,
    this.currency = 'EUR',
    this.stockStatus = StockStatus.inStock,
    this.isActive = true,
    this.location,
    this.barcode,
    this.qrCode,
    this.lastStockUpdate,
    this.expiryDate,
    this.compatibleMachines = const [],
    this.qualitySpecifications = const [],
    this.stockMovements = const [],
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.updatedBy,
    this.version = 1,
    this.metadata = const {},
  });

  @override
  String get id => reference;

  Material copyWith({
    String? reference,
    String? name,
    String? description,
    MaterialType? type,
    UnitOfMeasure? unitOfMeasure,
    String? category,
    String? subCategory,
    Supplier? supplier,
    double? currentStock,
    double? minimumStock,
    double? maximumStock,
    double? reorderPoint,
    double? unitPrice,
    String? currency,
    StockStatus? stockStatus,
    bool? isActive,
    String? location,
    String? barcode,
    String? qrCode,
    DateTime? lastStockUpdate,
    DateTime? expiryDate,
    List<String>? compatibleMachines,
    List<String>? qualitySpecifications,
    List<StockMovement>? stockMovements,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? updatedBy,
    int? version,
    Map<String, dynamic>? metadata,
  }) {
    return Material(
      reference: reference ?? this.reference,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      supplier: supplier ?? this.supplier,
      currentStock: currentStock ?? this.currentStock,
      minimumStock: minimumStock ?? this.minimumStock,
      maximumStock: maximumStock ?? this.maximumStock,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      unitPrice: unitPrice ?? this.unitPrice,
      currency: currency ?? this.currency,
      stockStatus: stockStatus ?? this.stockStatus,
      isActive: isActive ?? this.isActive,
      location: location ?? this.location,
      barcode: barcode ?? this.barcode,
      qrCode: qrCode ?? this.qrCode,
      lastStockUpdate: lastStockUpdate ?? this.lastStockUpdate,
      expiryDate: expiryDate ?? this.expiryDate,
      compatibleMachines: compatibleMachines ?? this.compatibleMachines,
      qualitySpecifications:
          qualitySpecifications ?? this.qualitySpecifications,
      stockMovements: stockMovements ?? this.stockMovements,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      version: version ?? this.version,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Checks if material needs reordering
  bool get needsReordering => currentStock <= reorderPoint;

  /// Checks if material is low on stock
  bool get isLowStock => currentStock <= minimumStock && currentStock > 0;

  /// Checks if material is out of stock
  bool get isOutOfStock => currentStock <= 0;

  /// Checks if material is expired
  bool get isExpired {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }

  /// Checks if material is expiring soon (within 30 days)
  bool get isExpiringSoon {
    if (expiryDate == null) return false;
    final thirtyDaysFromNow = DateTime.now().add(const Duration(days: 30));
    return expiryDate!.isBefore(thirtyDaysFromNow);
  }

  /// Calculates stock coverage in days (based on average daily consumption)
  double stockCoverage(double averageDailyConsumption) {
    if (averageDailyConsumption <= 0) return double.infinity;
    return currentStock / averageDailyConsumption;
  }

  /// Calculates total value of current stock
  double get totalValue => currentStock * unitPrice;

  /// Returns stock status based on current levels
  StockStatus get calculatedStockStatus {
    if (currentStock <= 0) return StockStatus.outOfStock;
    if (currentStock <= minimumStock) return StockStatus.lowStock;
    return StockStatus.inStock;
  }

  /// Returns type display name in French
  String get typeDisplayName {
    switch (type) {
      case MaterialType.rawMaterial:
        return 'Matière première';
      case MaterialType.semiFinished:
        return 'Semi-fini';
      case MaterialType.finishedProduct:
        return 'Produit fini';
      case MaterialType.consumable:
        return 'Consommable';
      case MaterialType.packaging:
        return 'Emballage';
      case MaterialType.sparePart:
        return 'Pièce de rechange';
    }
  }

  /// Returns unit display name in French
  String get unitDisplayName {
    switch (unitOfMeasure) {
      case UnitOfMeasure.piece:
        return 'Pièce';
      case UnitOfMeasure.kilogram:
        return 'Kilogramme';
      case UnitOfMeasure.liter:
        return 'Litre';
      case UnitOfMeasure.meter:
        return 'Mètre';
      case UnitOfMeasure.squareMeter:
        return 'Mètre carré';
      case UnitOfMeasure.cubicMeter:
        return 'Mètre cube';
      case UnitOfMeasure.hour:
        return 'Heure';
      case UnitOfMeasure.day:
        return 'Jour';
      case UnitOfMeasure.box:
        return 'Boîte';
      case UnitOfMeasure.pallet:
        return 'Palette';
    }
  }

  /// Returns stock status display name in French
  String get stockStatusDisplayName {
    switch (stockStatus) {
      case StockStatus.inStock:
        return 'En stock';
      case StockStatus.lowStock:
        return 'Stock faible';
      case StockStatus.outOfStock:
        return 'Rupture de stock';
      case StockStatus.onOrder:
        return 'En commande';
    }
  }

  /// Updates stock level and adds movement record
  Material updateStock({
    required double quantity,
    required String type,
    required String reason,
    required String userId,
    String? reference,
    Map<String, dynamic>? metadata,
  }) {
    final newStock = currentStock + quantity;
    final movement = StockMovement(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      materialId: this.reference,
      type: type,
      quantity: quantity,
      unit: unitOfMeasure.name,
      reason: reason,
      reference: reference,
      userId: userId,
      timestamp: DateTime.now(),
      metadata: metadata ?? {},
    );

    return copyWith(
      currentStock: newStock,
      stockStatus: calculatedStockStatus,
      lastStockUpdate: DateTime.now(),
      stockMovements: [...stockMovements, movement],
      updatedAt: DateTime.now(),
    );
  }

  /// Adjusts stock level (for inventory corrections)
  Material adjustStock({
    required double newStock,
    required String reason,
    required String userId,
    Map<String, dynamic>? metadata,
  }) {
    final adjustment = newStock - currentStock;
    return updateStock(
      quantity: adjustment,
      type: 'adjustment',
      reason: reason,
      userId: userId,
      metadata: metadata,
    );
  }

  /// Records stock in (receiving materials)
  Material stockIn({
    required double quantity,
    required String reason,
    required String userId,
    String? reference,
    Map<String, dynamic>? metadata,
  }) {
    return updateStock(
      quantity: quantity,
      type: 'in',
      reason: reason,
      userId: userId,
      reference: reference,
      metadata: metadata,
    );
  }

  /// Records stock out (consuming materials)
  Material stockOut({
    required double quantity,
    required String reason,
    required String userId,
    String? reference,
    Map<String, dynamic>? metadata,
  }) {
    return updateStock(
      quantity: -quantity,
      type: 'out',
      reason: reason,
      userId: userId,
      reference: reference,
      metadata: metadata,
    );
  }

  /// Updates material information
  Material updateInfo({
    String? name,
    String? description,
    MaterialType? type,
    UnitOfMeasure? unitOfMeasure,
    String? category,
    String? subCategory,
    Supplier? supplier,
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
  }) {
    return copyWith(
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      supplier: supplier ?? this.supplier,
      minimumStock: minimumStock ?? this.minimumStock,
      maximumStock: maximumStock ?? this.maximumStock,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      unitPrice: unitPrice ?? this.unitPrice,
      currency: currency ?? this.currency,
      location: location ?? this.location,
      barcode: barcode ?? this.barcode,
      qrCode: qrCode ?? this.qrCode,
      expiryDate: expiryDate ?? this.expiryDate,
      compatibleMachines: compatibleMachines ?? this.compatibleMachines,
      qualitySpecifications:
          qualitySpecifications ?? this.qualitySpecifications,
      updatedAt: DateTime.now(),
      updatedBy: updatedBy,
      metadata: metadata ?? this.metadata,
    );
  }
}
