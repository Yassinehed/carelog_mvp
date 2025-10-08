import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../entities/of_order.dart';
import '../repositories/i_of_order_repository.dart';
import 'transition_of_order.dart';

/// Use case for updating the status of an OfOrder.
@injectable
class UpdateOfOrderStatusUseCase {
  final TransitionOfOrderUseCase _transitionUseCase;

  const UpdateOfOrderStatusUseCase(this._transitionUseCase);

  Future<Either<OfOrderFailure, Unit>> call(UpdateOfOrderStatusParams params) async {
    final res = await _transitionUseCase(params.ofOrderId, params.newStatus);
    return res.fold((f) => Left(f), (order) => const Right(unit));
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
