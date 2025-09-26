// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductionCountImpl _$$ProductionCountImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductionCountImpl(
      id: json['id'] as String,
      count: (json['count'] as num).toInt(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$ProductionCountImplToJson(
        _$ProductionCountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
