import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/of_order.dart';
import '../repositories/i_of_order_repository.dart';

/// Use case for updating the status of an OfOrder.
class UpdateOfOrderStatusUseCase {
  final IOfOrderRepository repository;

  const UpdateOfOrderStatusUseCase(this.repository);

  Future<Either<OfOrderFailure, Unit>> call(UpdateOfOrderStatusParams params) {
    return repository.updateOfOrderStatus(params.ofOrderId, params.newStatus);
  }
}

/// Parameters for updating OfOrder status.
class UpdateOfOrderStatusParams extends Equatable {
  final String ofOrderId;
  final OfOrderStatus newStatus;

  const UpdateOfOrderStatusParams({
    required this.ofOrderId,
    required this.newStatus,
  });

  @override
  List<Object?> get props => [ofOrderId, newStatus];
}
