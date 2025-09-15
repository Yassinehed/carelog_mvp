import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/signalement.dart';
import '../repositories/i_signalement_repository.dart';

/// Use case for updating the status of a signalement.
class UpdateSignalementStatusUseCase {
  final ISignalementRepository repository;

  const UpdateSignalementStatusUseCase(this.repository);

  Future<Either<SignalementFailure, Unit>> call(
      UpdateSignalementStatusParams params) {
    return repository.updateSignalementStatus(
        params.signalementId, params.newStatus);
  }
}

/// Parameters for updating signalement status.
class UpdateSignalementStatusParams extends Equatable {
  final String signalementId;
  final SignalementStatus newStatus;

  const UpdateSignalementStatusParams({
    required this.signalementId,
    required this.newStatus,
  });

  @override
  List<Object?> get props => [signalementId, newStatus];
}
