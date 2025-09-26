// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MachineStatusImpl _$$MachineStatusImplFromJson(Map<String, dynamic> json) =>
    _$MachineStatusImpl(
      id: json['id'] as String,
      status: json['status'] as String,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$MachineStatusImplToJson(_$MachineStatusImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
