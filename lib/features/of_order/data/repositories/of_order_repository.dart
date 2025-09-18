import 'package:dartz/dartz.dart';
import '../../domain/entities/of_order.dart';
import '../../domain/repositories/i_of_order_repository.dart';
import '../datasources/of_order_firestore_datasource.dart';

/// Repository implementation for OfOrder operations.
class OfOrderRepository implements IOfOrderRepository {
  final OfOrderFirestoreDatasource _datasource;

  OfOrderRepository(this._datasource);

  @override
  Future<Either<OfOrderFailure, Unit>> createOfOrder(OfOrder ofOrder) async {
    try {
      await _datasource.createOfOrder(ofOrder);
      return const Right(unit);
    } catch (e) {
      return Left(OfOrderFailure.unknown());
    }
  }

  @override
  Future<Either<OfOrderFailure, List<OfOrder>>> getOfOrders() async {
    try {
      final result = await _datasource.listOfOrders();
      return Right(result);
    } catch (e) {
      return Left(OfOrderFailure.unknown());
    }
  }

  @override
  Future<Either<OfOrderFailure, Unit>> updateOfOrderStatus(
    String ofOrderId,
    OfOrderStatus newStatus,
  ) async {
    try {
      await _datasource.updateOfOrderStatus(ofOrderId, newStatus);
      return const Right(unit);
    } catch (e) {
      return Left(OfOrderFailure.unknown());
    }
  }

  @override
  Future<Either<OfOrderFailure, OfOrder>> getOfOrderById(String id) async {
    try {
      final orders = await _datasource.listOfOrders();
      final order = orders.where((o) => o.id == id).firstOrNull;
      if (order != null) {
        return Right(order);
      } else {
        return Left(OfOrderFailure.notFound());
      }
    } catch (e) {
      return Left(OfOrderFailure.unknown());
    }
  }
}
