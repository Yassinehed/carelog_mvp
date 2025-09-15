import 'package:flutter_test/flutter_test.dart';
import 'package:carelog_mvp/features/of_order/data/models/of_order_dto.dart';
import 'package:carelog_mvp/features/of_order/domain/entities/of_order.dart';

void main() {
  group('OfOrderMapper', () {
    final testOfOrder = OfOrder(
      id: 'test-id',
      client: 'Test Client',
      product: 'Test Product',
      quantity: 100,
      status: OfOrderStatus.materialReception,
      createdAt: DateTime(2023, 1, 1),
      description: 'Test description',
      updatedAt: DateTime(2023, 1, 2),
    );

    final testDto = OfOrderDto(
      id: 'test-id',
      client: 'Test Client',
      product: 'Test Product',
      quantity: 100,
      status: 'materialReception',
      createdAt: DateTime(2023, 1, 1),
      description: 'Test description',
      updatedAt: DateTime(2023, 1, 2),
    );

    test('fromDto should convert DTO to entity correctly', () {
      final result = OfOrderMapper.fromDto(testDto);

      expect(result.id, testDto.id);
      expect(result.client, testDto.client);
      expect(result.product, testDto.product);
      expect(result.quantity, testDto.quantity);
      expect(result.status, OfOrderStatus.materialReception);
      expect(result.createdAt, testDto.createdAt);
      expect(result.description, testDto.description);
      expect(result.updatedAt, testDto.updatedAt);
    });

    test('toDto should convert entity to DTO correctly', () {
      final result = OfOrderMapper.toDto(testOfOrder);

      expect(result.id, testOfOrder.id);
      expect(result.client, testOfOrder.client);
      expect(result.product, testOfOrder.product);
      expect(result.quantity, testOfOrder.quantity);
      expect(result.status, 'materialReception');
      expect(result.createdAt, testOfOrder.createdAt);
      expect(result.description, testOfOrder.description);
      expect(result.updatedAt, testOfOrder.updatedAt);
    });

    test('statusToString should convert all statuses correctly', () {
      expect(OfOrderMapper.statusToString(OfOrderStatus.materialReception),
          'materialReception');
      expect(OfOrderMapper.statusToString(OfOrderStatus.materialPreparation),
          'materialPreparation');
      expect(OfOrderMapper.statusToString(OfOrderStatus.productionCoupe),
          'productionCoupe');
      expect(OfOrderMapper.statusToString(OfOrderStatus.productionProd),
          'productionProd');
      expect(OfOrderMapper.statusToString(OfOrderStatus.productionTest),
          'productionTest');
      expect(OfOrderMapper.statusToString(OfOrderStatus.control), 'control');
      expect(OfOrderMapper.statusToString(OfOrderStatus.shipment), 'shipment');
      expect(
          OfOrderMapper.statusToString(OfOrderStatus.completed), 'completed');
      expect(
          OfOrderMapper.statusToString(OfOrderStatus.cancelled), 'cancelled');
    });

    test('round trip conversion should preserve data', () {
      final dto = OfOrderMapper.toDto(testOfOrder);
      final entity = OfOrderMapper.fromDto(dto);

      expect(entity.id, testOfOrder.id);
      expect(entity.client, testOfOrder.client);
      expect(entity.product, testOfOrder.product);
      expect(entity.quantity, testOfOrder.quantity);
      expect(entity.status, testOfOrder.status);
      expect(entity.createdAt, testOfOrder.createdAt);
      expect(entity.description, testOfOrder.description);
      expect(entity.updatedAt, testOfOrder.updatedAt);
    });
  });
}
