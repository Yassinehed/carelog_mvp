import 'package:dartz/dartz.dart';
import '../entities/of_order.dart';

/// Repository interface for OfOrder operations.
abstract class IOfOrderRepository {
  /// Creates a new OfOrder.
  Future<Either<OfOrderFailure, Unit>> createOfOrder(OfOrder ofOrder);

  /// Retrieves all OfOrders.
  Future<Either<OfOrderFailure, List<OfOrder>>> getOfOrders();

  /// Updates the status of an OfOrder.
  Future<Either<OfOrderFailure, Unit>> updateOfOrderStatus(
    String ofOrderId,
    OfOrderStatus newStatus,
    {String? updatedBy}
  );

  /// Returns true if the quality checklist for the order is complete.
  Future<Either<OfOrderFailure, bool>> isChecklistComplete(String ofOrderId);

  /// Retrieves an OfOrder by ID.
  Future<Either<OfOrderFailure, OfOrder>> getOfOrderById(String id);
}

/// Failure types for OfOrder operations.
abstract class OfOrderFailure {
  const OfOrderFailure();

  factory OfOrderFailure.network() = NetworkFailure;
  factory OfOrderFailure.notFound() = NotFoundFailure;
  factory OfOrderFailure.permissionDenied() = PermissionDeniedFailure;
  factory OfOrderFailure.unknown() = UnknownFailure;
}

class NetworkFailure extends OfOrderFailure {
  const NetworkFailure();
}

class NotFoundFailure extends OfOrderFailure {
  const NotFoundFailure();
}

class PermissionDeniedFailure extends OfOrderFailure {
  const PermissionDeniedFailure();
}

class UnknownFailure extends OfOrderFailure {
  const UnknownFailure();
}
