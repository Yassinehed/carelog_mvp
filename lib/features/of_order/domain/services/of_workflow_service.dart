import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/of_order.dart';
import '../repositories/i_of_order_repository.dart';

/// Service responsible for validating and executing OF status transitions.
@lazySingleton
class OfWorkflowService {
  final IOfOrderRepository repository;

  OfWorkflowService(this.repository);

  // Define allowed state transitions for feature-specific statuses
  static const Map<OfOrderStatus, List<OfOrderStatus>> _allowed = {
    OfOrderStatus.materialReception: [OfOrderStatus.materialPreparation, OfOrderStatus.cancelled],
    OfOrderStatus.materialPreparation: [OfOrderStatus.productionCoupe, OfOrderStatus.cancelled],
    OfOrderStatus.productionCoupe: [OfOrderStatus.productionProd, OfOrderStatus.cancelled],
    OfOrderStatus.productionProd: [OfOrderStatus.productionTest, OfOrderStatus.cancelled],
    OfOrderStatus.productionTest: [OfOrderStatus.control, OfOrderStatus.productionProd, OfOrderStatus.cancelled],
    OfOrderStatus.control: [OfOrderStatus.shipment, OfOrderStatus.productionProd, OfOrderStatus.cancelled],
    OfOrderStatus.shipment: [OfOrderStatus.completed, OfOrderStatus.cancelled],
    OfOrderStatus.completed: [],
    OfOrderStatus.cancelled: [],
  };

  bool _isAllowed(OfOrderStatus from, OfOrderStatus to) {
    final allowed = _allowed[from] ?? [];
    return allowed.contains(to);
  }

  /// Attempt to transition order [ofId] to [newStatus].
  /// Returns the updated OfOrder on success or an OfOrderFailure on error.
  Future<Either<OfOrderFailure, OfOrder>> transition(
    String ofId,
    OfOrderStatus newStatus, {
    String? updatedBy,
  }) async {
    final currentRes = await repository.getOfOrderById(ofId);
    return await currentRes.fold((failure) async => Left(failure), (order) async {
      // Prevent transitions that are not allowed by the state machine
      if (!_isAllowed(order.status, newStatus)) {
        return const Left(PermissionDeniedFailure());
      }

      // perform update
      final updateRes = await repository.updateOfOrderStatus(ofId, newStatus);
      return await updateRes.fold((f) async => Left(f), (_) async {
        // fetch fresh copy
        final refreshed = await repository.getOfOrderById(ofId);
        return refreshed;
      });
    });
  }
}
