import 'package:dartz/dartz.dart';
import '../entities/signalement.dart';
import '../repositories/i_signalement_repository.dart';

/// Use case for listing all signalements.
class ListSignalementsUseCase {
  final ISignalementRepository repository;

  const ListSignalementsUseCase(this.repository);

  Future<Either<SignalementFailure, List<Signalement>>> call() {
    return repository.getSignalements();
  }
}
