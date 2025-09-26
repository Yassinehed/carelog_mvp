// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MachineAlertImpl _$$MachineAlertImplFromJson(Map<String, dynamic> json) =>
    _$MachineAlertImpl(
      id: json['id'] as String,
      code: json['code'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$MachineAlertImplToJson(_$MachineAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'message': instance.message,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
