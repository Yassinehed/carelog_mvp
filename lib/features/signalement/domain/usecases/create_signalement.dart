import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/signalement.dart';
import '../repositories/i_signalement_repository.dart';

/// Use case for creating a new signalement.
class CreateSignalementUseCase {
  final ISignalementRepository repository;

  const CreateSignalementUseCase(this.repository);

  Future<Either<SignalementFailure, Unit>> call(
      CreateSignalementParams params) {
    final signalement = Signalement(
      id: params.id,
      type: params.type,
      severity: params.severity,
      createdBy: params.createdBy,
      createdAt: DateTime.now(),
      description: params.description,
      status: SignalementStatus.open,
    );
    return repository.createSignalement(signalement);
  }
}

/// Parameters for creating a signalement.
class CreateSignalementParams extends Equatable {
  final String id;
  final SignalementType type;
  final SignalementSeverity severity;
  final String createdBy;
  final String description;

  const CreateSignalementParams({
    required this.id,
    required this.type,
    required this.severity,
    required this.createdBy,
    required this.description,
  });

  @override
  List<Object?> get props => [id, type, severity, createdBy, description];
}
