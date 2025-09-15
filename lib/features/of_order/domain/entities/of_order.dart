import 'package:freezed_annotation/freezed_annotation.dart';

part 'of_order.freezed.dart';

/// OfOrder entity representing a Manufacturing Order.
@freezed
class OfOrder with _$OfOrder {
  const factory OfOrder({
    required String id,
    required String client,
    required String product,
    required int quantity,
    required OfOrderStatus status,
    required DateTime createdAt,
    String? description,
    DateTime? updatedAt,
  }) = _OfOrder;

  const OfOrder._();
}

/// Status of the OfOrder.
enum OfOrderStatus {
  materialReception,
  materialPreparation,
  productionCoupe,
  productionProd,
  productionTest,
  control,
  shipment,
  completed,
  cancelled,
}
