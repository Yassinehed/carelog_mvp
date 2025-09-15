// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signalement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignalementDtoImpl _$$SignalementDtoImplFromJson(Map<String, dynamic> json) =>
    _$SignalementDtoImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      severity: json['severity'] as String,
      createdBy: json['createdBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$SignalementDtoImplToJson(
        _$SignalementDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'severity': instance.severity,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'description': instance.description,
      'status': instance.status,
    };
