import 'package:dartz/dartz.dart';
import '../entities/signalement.dart';

/// Repository interface for Signalement operations.
abstract class ISignalementRepository {
  /// Creates a new signalement.
  Future<Either<SignalementFailure, Unit>> createSignalement(
      Signalement signalement);

  /// Retrieves all signalements.
  Future<Either<SignalementFailure, List<Signalement>>> getSignalements();

  /// Updates the status of a signalement.
  Future<Either<SignalementFailure, Unit>> updateSignalementStatus(
    String signalementId,
    SignalementStatus newStatus,
  );

  /// Retrieves a signalement by ID.
  Future<Either<SignalementFailure, Signalement>> getSignalementById(String id);
}

/// Failure types for signalement operations.
abstract class SignalementFailure {
  const SignalementFailure();

  factory SignalementFailure.network() = NetworkFailure;
  factory SignalementFailure.notFound() = NotFoundFailure;
  factory SignalementFailure.permissionDenied() = PermissionDeniedFailure;
  factory SignalementFailure.unknown() = UnknownFailure;
}

class NetworkFailure extends SignalementFailure {
  const NetworkFailure();
}

class NotFoundFailure extends SignalementFailure {
  const NotFoundFailure();
}

class PermissionDeniedFailure extends SignalementFailure {
  const PermissionDeniedFailure();
}

class UnknownFailure extends SignalementFailure {
  const UnknownFailure();
}
