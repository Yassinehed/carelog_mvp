import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:carelog_mvp/features/of_order/domain/entities/of_order.dart';
import 'package:carelog_mvp/features/of_order/domain/repositories/i_of_order_repository.dart';
import 'package:carelog_mvp/features/of_order/domain/services/of_workflow_service.dart';

class _FakeRepo implements IOfOrderRepository {
  OfOrder? _order;

  _FakeRepo(this._order);

  @override
  Future<Either<OfOrderFailure, Unit>> createOfOrder(OfOrder ofOrder) async => const Right(unit);

  @override
  Future<Either<OfOrderFailure, List<OfOrder>>> getOfOrders() async => Right(_order == null ? [] : [_order!]);

  @override
  Future<Either<OfOrderFailure, Unit>> updateOfOrderStatus(String ofOrderId, OfOrderStatus newStatus, {String? updatedBy}) async {
    if (_order == null || _order!.id != ofOrderId) return const Left(NotFoundFailure());
    _order = _order!.copyWith(status: newStatus, updatedAt: DateTime.now());
    return const Right(unit);
  }

  @override
  Future<Either<OfOrderFailure, bool>> isChecklistComplete(String ofOrderId) async {
    // For tests, assume checklist is complete
    return const Right(true);
  }

  @override
  Future<Either<OfOrderFailure, OfOrder>> getOfOrderById(String id) async {
    if (_order == null || _order!.id != id) return const Left(NotFoundFailure());
    return Right(_order!);
  }
}

void main() {
  group('OfWorkflowService', () {
    test('allows valid transition productionProd -> productionTest', () async {
      final initial = OfOrder(
        id: 'OF-1',
        client: 'ACME',
        product: 'Widget',
        quantity: 10,
        status: OfOrderStatus.productionProd,
        createdAt: DateTime.now(),
      );

      final repo = _FakeRepo(initial);
      final svc = OfWorkflowService(repo);

      final res = await svc.transition('OF-1', OfOrderStatus.productionTest);

  expect(res.isRight(), isTrue);
  res.fold((failure) => fail('Expected success but got failure: $failure'), (order) => expect(order.status, OfOrderStatus.productionTest));
    });

    test('rejects invalid transition materialReception -> productionProd', () async {
      final initial = OfOrder(
        id: 'OF-2',
        client: 'ACME',
        product: 'Widget',
        quantity: 5,
        status: OfOrderStatus.materialReception,
        createdAt: DateTime.now(),
      );

      final repo = _FakeRepo(initial);
      final svc = OfWorkflowService(repo);

      final res = await svc.transition('OF-2', OfOrderStatus.productionProd);

  expect(res.isLeft(), isTrue);
  res.fold((failure) => expect(failure is PermissionDeniedFailure, isTrue), (order) => fail('Expected failure but got order: $order'));
    });
  });
}
