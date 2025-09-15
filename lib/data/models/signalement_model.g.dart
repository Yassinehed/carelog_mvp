// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signalement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignalementImpl _$$SignalementImplFromJson(Map<String, dynamic> json) =>
    _$SignalementImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: $enumDecode(_$SignalementPriorityEnumMap, json['priority']),
      status: $enumDecode(_$SignalementStatusEnumMap, json['status']),
      category: $enumDecode(_$SignalementCategoryEnumMap, json['category']),
      createdBy: json['createdBy'] as String,
      assignedTo: json['assignedTo'] as String?,
      ofNumber: json['ofNumber'] as String?,
      location: json['location'] as String?,
      equipment: json['equipment'] as String?,
      materialBatch: json['materialBatch'] as String?,
      expectedResolutionDate: json['expectedResolutionDate'] == null
          ? null
          : DateTime.parse(json['expectedResolutionDate'] as String),
      actualResolutionDate: json['actualResolutionDate'] == null
          ? null
          : DateTime.parse(json['actualResolutionDate'] as String),
      resolutionNotes: json['resolutionNotes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['version'] as num?)?.toInt() ?? 1,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$SignalementImplToJson(_$SignalementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': _$SignalementPriorityEnumMap[instance.priority]!,
      'status': _$SignalementStatusEnumMap[instance.status]!,
      'category': _$SignalementCategoryEnumMap[instance.category]!,
      'createdBy': instance.createdBy,
      'assignedTo': instance.assignedTo,
      'ofNumber': instance.ofNumber,
      'location': instance.location,
      'equipment': instance.equipment,
      'materialBatch': instance.materialBatch,
      'expectedResolutionDate':
          instance.expectedResolutionDate?.toIso8601String(),
      'actualResolutionDate': instance.actualResolutionDate?.toIso8601String(),
      'resolutionNotes': instance.resolutionNotes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'version': instance.version,
      'metadata': instance.metadata,
    };

const _$SignalementPriorityEnumMap = {
  SignalementPriority.low: 'low',
  SignalementPriority.medium: 'medium',
  SignalementPriority.high: 'high',
  SignalementPriority.critical: 'critical',
};

const _$SignalementStatusEnumMap = {
  SignalementStatus.draft: 'draft',
  SignalementStatus.submitted: 'submitted',
  SignalementStatus.inProgress: 'inProgress',
  SignalementStatus.resolved: 'resolved',
  SignalementStatus.closed: 'closed',
  SignalementStatus.cancelled: 'cancelled',
};

const _$SignalementCategoryEnumMap = {
  SignalementCategory.quality: 'quality',
  SignalementCategory.equipment: 'equipment',
  SignalementCategory.material: 'material',
  SignalementCategory.process: 'process',
  SignalementCategory.safety: 'safety',
  SignalementCategory.other: 'other',
};
