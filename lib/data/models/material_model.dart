import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'material_model.freezed.dart';
part 'material_model.g.dart';

/// Material categories for classification
enum MaterialCategory {
  rawMaterial, // Raw materials (metals, plastics, etc.)
  component, // Manufactured components
  packaging, // Packaging materials
  consumable, // Consumables (lubricants, tools, etc.)
  chemical, // Chemicals and solvents
  other // Miscellaneous
}

/// Unit of measurement for materials
enum MaterialUnit {
  piece, // Individual pieces
  kilogram, // Weight in kg
  gram, // Weight in grams
  liter, // Volume in liters
  milliliter, // Volume in ml
  meter, // Length in meters
  squareMeter, // Area in m²
  cubicMeter, // Volume in m³
  box, // Boxes/cases
  pallet, // Pallets
  roll, // Rolls (paper, fabric, etc.)
  other // Custom units
}

/// Quality status for material batches
enum MaterialQualityStatus { pending, approved, rejected, quarantined }

/// Represents a material in the CareLog inventory system.
/// This model manages material lifecycle from supplier receipt to consumption
/// in manufacturing processes, including quality control and traceability.
@freezed
class Material with _$Material {
  const Material._(); // Private constructor for custom methods

  const factory Material({
    /// Unique material reference/SKU
    required String reference,

    /// Human-readable material name
    required String name,

    /// Detailed description
    required String description,

    /// Material category
    required MaterialCategory category,

    /// Unit of measurement
    required MaterialUnit unit,

    /// Minimum stock level (reorder point)
    @Default(0) int minimumStock,

    /// Maximum stock level
    int? maximumStock,

    /// Current stock quantity
    @Default(0.0) double currentStock,

    /// Reserved quantity (allocated to orders)
    @Default(0.0) double reservedStock,

    /// Available quantity (current - reserved)
    @Default(0.0) double availableStock,

    /// Unit cost
    @Default(0.0) double unitCost,

    /// Supplier information
    String? supplierName,

    /// Supplier reference/catalog number
    String? supplierReference,

    /// Lead time in days for reordering
    int? leadTimeDays,

    /// Storage location
    String? storageLocation,

    /// Safety stock level
    @Default(0.0) double safetyStock,

    /// Quality specifications
    @Default([]) List<String> qualitySpecifications,

    /// Material batches/lots
    @Default([]) List<MaterialBatch> batches,

    /// Is material active (not discontinued)
    @Default(true) bool isActive,

    /// Creation timestamp
    required DateTime createdAt,

    /// Last update timestamp
    required DateTime updatedAt,

    /// User who created the material
    required String createdBy,

    /// Last user who updated the material
    String? updatedBy,

    /// Version for optimistic concurrency
    @Default(1) int version,

    /// Additional metadata
    @Default({}) Map<String, dynamic> metadata,
  }) = _Material;

  /// Creates a Material from JSON data
  factory Material.fromJson(Map<String, dynamic> json) =>
      _$MaterialFromJson(json);

  /// Creates a new Material with default values
  factory Material.create({
    required String name,
    required String description,
    required MaterialCategory category,
    required MaterialUnit unit,
    required String createdBy,
    int minimumStock = 0,
    int? maximumStock,
    double unitCost = 0.0,
    String? supplierName,
    String? supplierReference,
    int? leadTimeDays,
    String? storageLocation,
    double safetyStock = 0.0,
    List<String>? qualitySpecifications,
    Map<String, dynamic>? metadata,
  }) {
    final now = DateTime.now();
    final reference = _generateMaterialReference(category);

    return Material(
      reference: reference,
      name: name.trim(),
      description: description.trim(),
      category: category,
      unit: unit,
      minimumStock: minimumStock,
      maximumStock: maximumStock,
      unitCost: unitCost,
      supplierName: supplierName?.trim(),
      supplierReference: supplierReference?.trim(),
      leadTimeDays: leadTimeDays,
      storageLocation: storageLocation?.trim(),
      safetyStock: safetyStock,
      qualitySpecifications: qualitySpecifications ?? [],
      createdAt: now,
      updatedAt: now,
      createdBy: createdBy,
      metadata: metadata ?? {},
    );
  }

  /// Generates a unique material reference based on category
  static String _generateMaterialReference(MaterialCategory category) {
    final prefix = switch (category) {
      MaterialCategory.rawMaterial => 'RAW',
      MaterialCategory.component => 'CMP',
      MaterialCategory.packaging => 'PKG',
      MaterialCategory.consumable => 'CON',
      MaterialCategory.chemical => 'CHM',
      MaterialCategory.other => 'MAT',
    };

    final sequence = const Uuid().v4().substring(0, 8).toUpperCase();
    return '$prefix${DateTime.now().year}$sequence';
  }

  /// Validates the material data integrity
  bool get isValid {
    return reference.isNotEmpty &&
        name.isNotEmpty &&
        name.length <= 100 &&
        description.isNotEmpty &&
        description.length <= 500 &&
        minimumStock >= 0 &&
        (maximumStock == null || maximumStock! >= minimumStock) &&
        currentStock >= 0 &&
        reservedStock >= 0 &&
        availableStock >= 0 &&
        unitCost >= 0 &&
        safetyStock >= 0 &&
        (supplierName == null || supplierName!.length <= 100) &&
        (supplierReference == null || supplierReference!.length <= 50) &&
        (storageLocation == null || storageLocation!.length <= 50) &&
        (leadTimeDays == null || leadTimeDays! > 0);
  }

  /// Checks if material is below minimum stock level
  bool get needsReorder {
    return availableStock <= minimumStock;
  }

  /// Checks if material is at critical stock level (below safety stock)
  bool get isCriticalStock {
    return availableStock <= safetyStock;
  }

  /// Checks if material is overstocked
  bool get isOverstocked {
    if (maximumStock == null) return false;
    return currentStock > maximumStock!;
  }

  /// Calculates total value of current stock
  double get totalValue {
    return currentStock * unitCost;
  }

  /// Calculates stock turnover ratio (if consumption data available)
  double getStockTurnover(int daysInPeriod, double consumedQuantity) {
    if (currentStock == 0 || consumedQuantity == 0) return 0.0;
    final averageStock = currentStock; // Simplified calculation
    return (consumedQuantity / averageStock) * (365 / daysInPeriod);
  }

  /// Returns a human-readable category description
  String get categoryDescription {
    switch (category) {
      case MaterialCategory.rawMaterial:
        return 'Matière première';
      case MaterialCategory.component:
        return 'Composant';
      case MaterialCategory.packaging:
        return 'Emballage';
      case MaterialCategory.consumable:
        return 'Consommable';
      case MaterialCategory.chemical:
        return 'Produit chimique';
      case MaterialCategory.other:
        return 'Autre';
    }
  }

  /// Returns a human-readable unit description
  String get unitDescription {
    switch (unit) {
      case MaterialUnit.piece:
        return 'pièce';
      case MaterialUnit.kilogram:
        return 'kg';
      case MaterialUnit.gram:
        return 'g';
      case MaterialUnit.liter:
        return 'L';
      case MaterialUnit.milliliter:
        return 'mL';
      case MaterialUnit.meter:
        return 'm';
      case MaterialUnit.squareMeter:
        return 'm²';
      case MaterialUnit.cubicMeter:
        return 'm³';
      case MaterialUnit.box:
        return 'boîte';
      case MaterialUnit.pallet:
        return 'palette';
      case MaterialUnit.roll:
        return 'rouleau';
      case MaterialUnit.other:
        return 'autre';
    }
  }

  /// Updates stock levels
  Material updateStock({
    double? currentStock,
    double? reservedStock,
    String? updatedBy,
  }) {
    final newCurrent = currentStock ?? this.currentStock;
    final newReserved = reservedStock ?? this.reservedStock;
    final newAvailable = (newCurrent - newReserved).clamp(0.0, double.infinity);

    return copyWith(
      currentStock: newCurrent,
      reservedStock: newReserved,
      availableStock: newAvailable,
      updatedAt: DateTime.now(),
      updatedBy: updatedBy,
      metadata: {
        ...metadata,
        'stockUpdateHistory': [
          ...metadata['stockUpdateHistory'] ?? [],
          {
            'currentStock': newCurrent,
            'reservedStock': newReserved,
            'availableStock': newAvailable,
            'timestamp': DateTime.now().toIso8601String(),
            'updatedBy': updatedBy,
          }
        ],
      },
    );
  }

  /// Reserves stock for an order
  Material reserveStock(double quantity, String orderId, {String? updatedBy}) {
    if (quantity > availableStock) {
      throw Exception('Insufficient stock available for reservation');
    }

    final newReserved = reservedStock + quantity;
    final newAvailable = currentStock - newReserved;

    return copyWith(
      reservedStock: newReserved,
      availableStock: newAvailable,
      updatedAt: DateTime.now(),
      updatedBy: updatedBy,
      metadata: {
        ...metadata,
        'reservations': [
          ...metadata['reservations'] ?? [],
          {
            'orderId': orderId,
            'quantity': quantity,
            'timestamp': DateTime.now().toIso8601String(),
          }
        ],
      },
    );
  }

  /// Releases reserved stock
  Material releaseReservation(double quantity, String orderId,
      {String? updatedBy}) {
    if (quantity > reservedStock) {
      throw Exception('Cannot release more than reserved quantity');
    }

    final newReserved = reservedStock - quantity;
    final newAvailable = currentStock - newReserved;

    return copyWith(
      reservedStock: newReserved,
      availableStock: newAvailable,
      updatedAt: DateTime.now(),
      updatedBy: updatedBy,
      metadata: {
        ...metadata,
        'reservationReleases': [
          ...metadata['reservationReleases'] ?? [],
          {
            'orderId': orderId,
            'quantity': quantity,
            'timestamp': DateTime.now().toIso8601String(),
          }
        ],
      },
    );
  }

  /// Consumes stock from available inventory
  Material consumeStock(double quantity, String consumptionReason,
      {String? updatedBy}) {
    if (quantity > availableStock) {
      throw Exception('Insufficient available stock for consumption');
    }

    final newCurrent = currentStock - quantity;
    final newAvailable = newCurrent - reservedStock;

    return copyWith(
      currentStock: newCurrent,
      availableStock: newAvailable,
      updatedAt: DateTime.now(),
      updatedBy: updatedBy,
      metadata: {
        ...metadata,
        'consumptionHistory': [
          ...metadata['consumptionHistory'] ?? [],
          {
            'quantity': quantity,
            'reason': consumptionReason,
            'timestamp': DateTime.now().toIso8601String(),
            'updatedBy': updatedBy,
          }
        ],
      },
    );
  }

  /// Adds a new material batch
  Material addBatch(MaterialBatch batch) {
    return copyWith(
      batches: [...batches, batch],
      updatedAt: DateTime.now(),
    );
  }

  /// Updates material cost
  Material updateCost(double newUnitCost, {String? updatedBy}) {
    return copyWith(
      unitCost: newUnitCost,
      updatedAt: DateTime.now(),
      updatedBy: updatedBy,
      metadata: {
        ...metadata,
        'costHistory': [
          ...metadata['costHistory'] ?? [],
          {
            'cost': newUnitCost,
            'timestamp': DateTime.now().toIso8601String(),
            'updatedBy': updatedBy,
          }
        ],
      },
    );
  }

  /// Converts to a summary map for list views
  Map<String, dynamic> toSummaryMap() {
    return {
      'reference': reference,
      'name': name,
      'category': category.name,
      'unit': unit.name,
      'currentStock': currentStock,
      'availableStock': availableStock,
      'unitCost': unitCost,
      'totalValue': totalValue,
      'needsReorder': needsReorder,
      'isCriticalStock': isCriticalStock,
      'supplierName': supplierName,
    };
  }

  /// Converts to a detailed map for detail views
  Map<String, dynamic> toDetailMap() {
    return {
      ...toSummaryMap(),
      'description': description,
      'minimumStock': minimumStock,
      'maximumStock': maximumStock,
      'reservedStock': reservedStock,
      'supplierReference': supplierReference,
      'leadTimeDays': leadTimeDays,
      'storageLocation': storageLocation,
      'safetyStock': safetyStock,
      'qualitySpecifications': qualitySpecifications,
      'batches': batches.map((b) => b.toJson()).toList(),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'version': version,
      'metadata': metadata,
    };
  }
}

/// Represents a specific batch/lot of material with quality tracking
@freezed
class MaterialBatch with _$MaterialBatch {
  const MaterialBatch._(); // Private constructor for custom methods

  const factory MaterialBatch({
    /// Unique batch identifier
    required String batchId,

    /// Quantity in this batch
    required double quantity,

    /// Quality status
    @Default(MaterialQualityStatus.pending) MaterialQualityStatus qualityStatus,

    /// Supplier batch/lot number
    String? supplierBatchId,

    /// Manufacturing date
    DateTime? manufacturingDate,

    /// Expiration date
    DateTime? expirationDate,

    /// Receipt date
    required DateTime receiptDate,

    /// Quality check date
    DateTime? qualityCheckDate,

    /// Quality inspector
    String? qualityInspector,

    /// Quality notes
    String? qualityNotes,

    /// Certificate of analysis reference
    String? certificateReference,

    /// Storage conditions
    String? storageConditions,

    /// Remaining quantity in this batch
    double? remainingQuantity,

    /// Is batch active (not expired/consumed)
    @Default(true) bool isActive,
  }) = _MaterialBatch;

  factory MaterialBatch.fromJson(Map<String, dynamic> json) =>
      _$MaterialBatchFromJson(json);

  /// Creates a new material batch
  factory MaterialBatch.create({
    required double quantity,
    String? supplierBatchId,
    DateTime? manufacturingDate,
    DateTime? expirationDate,
    String? storageConditions,
    String? certificateReference,
  }) {
    return MaterialBatch(
      batchId: const Uuid().v4(),
      quantity: quantity,
      supplierBatchId: supplierBatchId,
      manufacturingDate: manufacturingDate,
      expirationDate: expirationDate,
      receiptDate: DateTime.now(),
      storageConditions: storageConditions,
      certificateReference: certificateReference,
      remainingQuantity: quantity,
    );
  }

  /// Checks if batch is expired
  bool get isExpired {
    if (expirationDate == null) return false;
    return DateTime.now().isAfter(expirationDate!);
  }

  /// Checks if batch is near expiration (within 30 days)
  bool get isNearExpiration {
    if (expirationDate == null) return false;
    final daysUntilExpiration =
        expirationDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiration <= 30 && daysUntilExpiration > 0;
  }

  /// Returns a human-readable quality status description
  String get qualityStatusDescription {
    switch (qualityStatus) {
      case MaterialQualityStatus.pending:
        return 'En attente';
      case MaterialQualityStatus.approved:
        return 'Approuvé';
      case MaterialQualityStatus.rejected:
        return 'Rejeté';
      case MaterialQualityStatus.quarantined:
        return 'En quarantaine';
    }
  }
}
