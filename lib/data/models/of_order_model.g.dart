// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'of_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OfOrderImpl _$$OfOrderImplFromJson(Map<String, dynamic> json) =>
    _$OfOrderImpl(
      ofNumber: json['ofNumber'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      clientName: json['clientName'] as String,
      productReference: json['productReference'] as String,
      plannedQuantity: (json['plannedQuantity'] as num).toInt(),
      unit: json['unit'] as String,
      status: $enumDecode(_$OfOrderStatusEnumMap, json['status']),
      priority: $enumDecode(_$OfOrderPriorityEnumMap, json['priority']),
      qualityStatus:
          $enumDecodeNullable(_$QualityStatusEnumMap, json['qualityStatus']) ??
              QualityStatus.pending,
      productionLine: json['productionLine'] as String?,
      supervisorId: json['supervisorId'] as String?,
      plannedStartDate: json['plannedStartDate'] == null
          ? null
          : DateTime.parse(json['plannedStartDate'] as String),
      actualStartDate: json['actualStartDate'] == null
          ? null
          : DateTime.parse(json['actualStartDate'] as String),
      plannedCompletionDate: json['plannedCompletionDate'] == null
          ? null
          : DateTime.parse(json['plannedCompletionDate'] as String),
      actualCompletionDate: json['actualCompletionDate'] == null
          ? null
          : DateTime.parse(json['actualCompletionDate'] as String),
      deliveryDeadline: json['deliveryDeadline'] == null
          ? null
          : DateTime.parse(json['deliveryDeadline'] as String),
      actualDeliveryDate: json['actualDeliveryDate'] == null
          ? null
          : DateTime.parse(json['actualDeliveryDate'] as String),
      requiredMaterials: (json['requiredMaterials'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      qualitySpecifications: (json['qualitySpecifications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      productionNotes: (json['productionNotes'] as List<dynamic>?)
              ?.map((e) => ProductionNote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      qualityChecks: (json['qualityChecks'] as List<dynamic>?)
              ?.map((e) => QualityCheck.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      progressPercentage: (json['progressPercentage'] as num?)?.toInt() ?? 0,
      actualQuantity: (json['actualQuantity'] as num?)?.toInt() ?? 0,
      goodQuantity: (json['goodQuantity'] as num?)?.toInt() ?? 0,
      rejectedQuantity: (json['rejectedQuantity'] as num?)?.toInt() ?? 0,
      allocatedBudget: (json['allocatedBudget'] as num?)?.toDouble(),
      actualCost: (json['actualCost'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String?,
      version: (json['version'] as num?)?.toInt() ?? 1,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$OfOrderImplToJson(_$OfOrderImpl instance) =>
    <String, dynamic>{
      'ofNumber': instance.ofNumber,
      'title': instance.title,
      'description': instance.description,
      'clientName': instance.clientName,
      'productReference': instance.productReference,
      'plannedQuantity': instance.plannedQuantity,
      'unit': instance.unit,
      'status': _$OfOrderStatusEnumMap[instance.status]!,
      'priority': _$OfOrderPriorityEnumMap[instance.priority]!,
      'qualityStatus': _$QualityStatusEnumMap[instance.qualityStatus]!,
      'productionLine': instance.productionLine,
      'supervisorId': instance.supervisorId,
      'plannedStartDate': instance.plannedStartDate?.toIso8601String(),
      'actualStartDate': instance.actualStartDate?.toIso8601String(),
      'plannedCompletionDate':
          instance.plannedCompletionDate?.toIso8601String(),
      'actualCompletionDate': instance.actualCompletionDate?.toIso8601String(),
      'deliveryDeadline': instance.deliveryDeadline?.toIso8601String(),
      'actualDeliveryDate': instance.actualDeliveryDate?.toIso8601String(),
      'requiredMaterials': instance.requiredMaterials,
      'qualitySpecifications': instance.qualitySpecifications,
      'productionNotes': instance.productionNotes,
      'qualityChecks': instance.qualityChecks,
      'progressPercentage': instance.progressPercentage,
      'actualQuantity': instance.actualQuantity,
      'goodQuantity': instance.goodQuantity,
      'rejectedQuantity': instance.rejectedQuantity,
      'allocatedBudget': instance.allocatedBudget,
      'actualCost': instance.actualCost,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'version': instance.version,
      'metadata': instance.metadata,
    };

const _$OfOrderStatusEnumMap = {
  OfOrderStatus.draft: 'draft',
  OfOrderStatus.planned: 'planned',
  OfOrderStatus.materialWaiting: 'materialWaiting',
  OfOrderStatus.inProgress: 'inProgress',
  OfOrderStatus.qualityCheck: 'qualityCheck',
  OfOrderStatus.completed: 'completed',
  OfOrderStatus.delivered: 'delivered',
  OfOrderStatus.cancelled: 'cancelled',
};

const _$OfOrderPriorityEnumMap = {
  OfOrderPriority.low: 'low',
  OfOrderPriority.normal: 'normal',
  OfOrderPriority.high: 'high',
  OfOrderPriority.urgent: 'urgent',
};

const _$QualityStatusEnumMap = {
  QualityStatus.pending: 'pending',
  QualityStatus.inProgress: 'inProgress',
  QualityStatus.passed: 'passed',
  QualityStatus.failed: 'failed',
  QualityStatus.rework: 'rework',
};

_$ProductionNoteImpl _$$ProductionNoteImplFromJson(Map<String, dynamic> json) =>
    _$ProductionNoteImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      authorId: json['authorId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$ProductionNoteImplToJson(
        _$ProductionNoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'authorId': instance.authorId,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$QualityCheckImpl _$$QualityCheckImplFromJson(Map<String, dynamic> json) =>
    _$QualityCheckImpl(
      id: json['id'] as String,
      checkpoint: json['checkpoint'] as String,
      passed: json['passed'] as bool,
      notes: json['notes'] as String?,
      inspectorId: json['inspectorId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$QualityCheckImplToJson(_$QualityCheckImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'checkpoint': instance.checkpoint,
      'passed': instance.passed,
      'notes': instance.notes,
      'inspectorId': instance.inspectorId,
      'timestamp': instance.timestamp.toIso8601String(),
    };
