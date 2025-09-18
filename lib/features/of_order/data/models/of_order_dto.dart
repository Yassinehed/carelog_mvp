import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/of_order.dart';

part 'of_order_dto.freezed.dart';
part 'of_order_dto.g.dart';

/// DTO for OfOrder in Firestore.
@freezed
class OfOrderDto with _$OfOrderDto {
  const factory OfOrderDto({
    required String id,
    required String client,
    required String product,
    required int quantity,
    required String status,
    required DateTime createdAt,
    String? description,
    DateTime? updatedAt,
  }) = _OfOrderDto;

  const OfOrderDto._();

  factory OfOrderDto.fromJson(Map<String, dynamic> json) =>
      _$OfOrderDtoFromJson(json);

  factory OfOrderDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OfOrderDto.fromJson(data..['id'] = doc.id);
  }

  Map<String, dynamic> toFirestore() => toJson()..remove('id');
}

/// Mapper between OfOrder entity and DTO.
class OfOrderMapper {
  static OfOrder fromDto(OfOrderDto dto) {
    return OfOrder(
      id: dto.id,
      client: dto.client,
      product: dto.product,
      quantity: dto.quantity,
      status: _stringToStatus(dto.status),
      createdAt: dto.createdAt,
      description: dto.description,
      updatedAt: dto.updatedAt,
    );
  }

  static OfOrderDto toDto(OfOrder entity) {
    return OfOrderDto(
      id: entity.id,
      client: entity.client,
      product: entity.product,
      quantity: entity.quantity,
      status: statusToString(entity.status),
      createdAt: entity.createdAt,
      description: entity.description,
      updatedAt: entity.updatedAt,
    );
  }

  static OfOrderStatus _stringToStatus(String value) {
    switch (value) {
      case 'materialReception':
        return OfOrderStatus.materialReception;
      case 'materialPreparation':
        return OfOrderStatus.materialPreparation;
      case 'productionCoupe':
        return OfOrderStatus.productionCoupe;
      case 'productionProd':
        return OfOrderStatus.productionProd;
      case 'productionTest':
        return OfOrderStatus.productionTest;
      case 'control':
        return OfOrderStatus.control;
      case 'shipment':
        return OfOrderStatus.shipment;
      case 'completed':
        return OfOrderStatus.completed;
      case 'cancelled':
        return OfOrderStatus.cancelled;
      default:
        throw ArgumentError('Invalid OfOrderStatus: $value');
    }
  }

  static String statusToString(OfOrderStatus status) {
    switch (status) {
      case OfOrderStatus.materialReception:
        return 'materialReception';
      case OfOrderStatus.materialPreparation:
        return 'materialPreparation';
      case OfOrderStatus.productionCoupe:
        return 'productionCoupe';
      case OfOrderStatus.productionProd:
        return 'productionProd';
      case OfOrderStatus.productionTest:
        return 'productionTest';
      case OfOrderStatus.control:
        return 'control';
      case OfOrderStatus.shipment:
        return 'shipment';
      case OfOrderStatus.completed:
        return 'completed';
      case OfOrderStatus.cancelled:
        return 'cancelled';
    }
  }
}
