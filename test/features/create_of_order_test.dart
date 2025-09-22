import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:carelog_mvp/features/of_order/domain/usecases/create_of_order.dart';
import 'package:carelog_mvp/features/of_order/domain/entities/of_order.dart';
import 'package:carelog_mvp/features/of_order/domain/repositories/i_of_order_repository.dart';

class FakeOfOrderRepository implements IOfOrderRepository {
  OfOrder? lastCreated;

  @override
  Future<Either<OfOrderFailure, Unit>> createOfOrder(OfOrder ofOrder) async {
    lastCreated = ofOrder;
    return right(unit);
  }

  @override
  Future<Either<OfOrderFailure, List<OfOrder>>> getOfOrders() async {
    return right([]);
  }

  @override
  Future<Either<OfOrderFailure, Unit>> updateOfOrderStatus(String ofOrderId, OfOrderStatus newStatus) async {
    return right(unit);
  }

  @override
  Future<Either<OfOrderFailure, OfOrder>> getOfOrderById(String id) async {
    throw UnimplementedError();
  }
}

void main() {
  group('CreateOfOrderUseCase', () {
    test('creates an order and returns Unit on success', () async {
  final fakeRepo = FakeOfOrderRepository();
  final usecase = CreateOfOrderUseCase(fakeRepo);

      const params = CreateOfOrderParams(
        id: 'o1',
        client: 'client',
        product: 'product',
        quantity: 10,
        description: 'desc',
      );

      final result = await usecase(params);

      expect(result.isRight(), true);
      expect(fakeRepo.lastCreated, isNotNull);
      expect(fakeRepo.lastCreated!.id, 'o1');
    });
  });
}
