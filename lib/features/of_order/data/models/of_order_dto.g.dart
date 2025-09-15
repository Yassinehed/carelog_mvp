// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'of_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OfOrderDtoImpl _$$OfOrderDtoImplFromJson(Map<String, dynamic> json) =>
    _$OfOrderDtoImpl(
      id: json['id'] as String,
      client: json['client'] as String,
      product: json['product'] as String,
      quantity: (json['quantity'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$OfOrderDtoImplToJson(_$OfOrderDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client': instance.client,
      'product': instance.product,
      'quantity': instance.quantity,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'description': instance.description,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
