import 'package:dartz/dartz.dart';
import '../entities/of_order.dart';
import '../repositories/i_of_order_repository.dart';

/// Use case for getting an OfOrder by ID.
class GetOfOrderByIdUseCase {
  final IOfOrderRepository repository;

  const GetOfOrderByIdUseCase(this.repository);

  Future<Either<OfOrderFailure, OfOrder>> call(String id) {
    return repository.getOfOrderById(id);
  }
}