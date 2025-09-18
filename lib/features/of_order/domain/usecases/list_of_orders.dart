import 'package:dartz/dartz.dart';
import '../entities/of_order.dart';
import '../repositories/i_of_order_repository.dart';

/// Use case for getting all OfOrders.
class GetOfOrdersUseCase {
  final IOfOrderRepository repository;

  const GetOfOrdersUseCase(this.repository);

  Future<Either<OfOrderFailure, List<OfOrder>>> call() {
    return repository.getOfOrders();
  }
}
