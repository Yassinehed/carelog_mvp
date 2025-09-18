// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MaterialImpl _$$MaterialImplFromJson(Map<String, dynamic> json) =>
    _$MaterialImpl(
      reference: json['reference'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$MaterialCategoryEnumMap, json['category']),
      unit: $enumDecode(_$MaterialUnitEnumMap, json['unit']),
      minimumStock: (json['minimumStock'] as num?)?.toInt() ?? 0,
      maximumStock: (json['maximumStock'] as num?)?.toInt(),
      currentStock: (json['currentStock'] as num?)?.toDouble() ?? 0.0,
      reservedStock: (json['reservedStock'] as num?)?.toDouble() ?? 0.0,
      availableStock: (json['availableStock'] as num?)?.toDouble() ?? 0.0,
      unitCost: (json['unitCost'] as num?)?.toDouble() ?? 0.0,
      supplierName: json['supplierName'] as String?,
      supplierReference: json['supplierReference'] as String?,
      leadTimeDays: (json['leadTimeDays'] as num?)?.toInt(),
      storageLocation: json['storageLocation'] as String?,
      safetyStock: (json['safetyStock'] as num?)?.toDouble() ?? 0.0,
      qualitySpecifications: (json['qualitySpecifications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      batches: (json['batches'] as List<dynamic>?)
              ?.map((e) => MaterialBatch.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String?,
      version: (json['version'] as num?)?.toInt() ?? 1,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$MaterialImplToJson(_$MaterialImpl instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'name': instance.name,
      'description': instance.description,
      'category': _$MaterialCategoryEnumMap[instance.category]!,
      'unit': _$MaterialUnitEnumMap[instance.unit]!,
      'minimumStock': instance.minimumStock,
      'maximumStock': instance.maximumStock,
      'currentStock': instance.currentStock,
      'reservedStock': instance.reservedStock,
      'availableStock': instance.availableStock,
      'unitCost': instance.unitCost,
      'supplierName': instance.supplierName,
      'supplierReference': instance.supplierReference,
      'leadTimeDays': instance.leadTimeDays,
      'storageLocation': instance.storageLocation,
      'safetyStock': instance.safetyStock,
      'qualitySpecifications': instance.qualitySpecifications,
      'batches': instance.batches,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'version': instance.version,
      'metadata': instance.metadata,
    };

const _$MaterialCategoryEnumMap = {
  MaterialCategory.rawMaterial: 'rawMaterial',
  MaterialCategory.component: 'component',
  MaterialCategory.packaging: 'packaging',
  MaterialCategory.consumable: 'consumable',
  MaterialCategory.chemical: 'chemical',
  MaterialCategory.other: 'other',
};

const _$MaterialUnitEnumMap = {
  MaterialUnit.piece: 'piece',
  MaterialUnit.kilogram: 'kilogram',
  MaterialUnit.gram: 'gram',
  MaterialUnit.liter: 'liter',
  MaterialUnit.milliliter: 'milliliter',
  MaterialUnit.meter: 'meter',
  MaterialUnit.squareMeter: 'squareMeter',
  MaterialUnit.cubicMeter: 'cubicMeter',
  MaterialUnit.box: 'box',
  MaterialUnit.pallet: 'pallet',
  MaterialUnit.roll: 'roll',
  MaterialUnit.other: 'other',
};

_$MaterialBatchImpl _$$MaterialBatchImplFromJson(Map<String, dynamic> json) =>
    _$MaterialBatchImpl(
      batchId: json['batchId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      qualityStatus: $enumDecodeNullable(
              _$MaterialQualityStatusEnumMap, json['qualityStatus']) ??
          MaterialQualityStatus.pending,
      supplierBatchId: json['supplierBatchId'] as String?,
      manufacturingDate: json['manufacturingDate'] == null
          ? null
          : DateTime.parse(json['manufacturingDate'] as String),
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      receiptDate: DateTime.parse(json['receiptDate'] as String),
      qualityCheckDate: json['qualityCheckDate'] == null
          ? null
          : DateTime.parse(json['qualityCheckDate'] as String),
      qualityInspector: json['qualityInspector'] as String?,
      qualityNotes: json['qualityNotes'] as String?,
      certificateReference: json['certificateReference'] as String?,
      storageConditions: json['storageConditions'] as String?,
      remainingQuantity: (json['remainingQuantity'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$MaterialBatchImplToJson(_$MaterialBatchImpl instance) =>
    <String, dynamic>{
      'batchId': instance.batchId,
      'quantity': instance.quantity,
      'qualityStatus': _$MaterialQualityStatusEnumMap[instance.qualityStatus]!,
      'supplierBatchId': instance.supplierBatchId,
      'manufacturingDate': instance.manufacturingDate?.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'receiptDate': instance.receiptDate.toIso8601String(),
      'qualityCheckDate': instance.qualityCheckDate?.toIso8601String(),
      'qualityInspector': instance.qualityInspector,
      'qualityNotes': instance.qualityNotes,
      'certificateReference': instance.certificateReference,
      'storageConditions': instance.storageConditions,
      'remainingQuantity': instance.remainingQuantity,
      'isActive': instance.isActive,
    };

const _$MaterialQualityStatusEnumMap = {
  MaterialQualityStatus.pending: 'pending',
  MaterialQualityStatus.approved: 'approved',
  MaterialQualityStatus.rejected: 'rejected',
  MaterialQualityStatus.quarantined: 'quarantined',
};
