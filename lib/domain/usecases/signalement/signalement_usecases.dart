import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/entities.dart';
import '../../../domain/entities/signalement.dart';
import '../../../domain/repositories/signalement_repository.dart';

/// Use case for getting signalement by ID
@injectable
class GetSignalementById {
  final SignalementRepository _signalementRepository;

  GetSignalementById(this._signalementRepository);

  Future<Either<Failure, Signalement>> call(String signalementId) async {
    return await _signalementRepository.getById(signalementId);
  }
}

/// Use case for getting all signalements
@injectable
class GetAllSignalements {
  final SignalementRepository _signalementRepository;

  GetAllSignalements(this._signalementRepository);

  Future<Either<Failure, List<Signalement>>> call() async {
    return await _signalementRepository.getAll();
  }
}

/// Use case for creating a new signalement
@injectable
class CreateSignalement {
  final SignalementRepository _signalementRepository;

  CreateSignalement(this._signalementRepository);

  Future<Either<Failure, Signalement>> call(Signalement signalement) async {
    return await _signalementRepository.create(signalement);
  }
}

/// Use case for updating signalement
@injectable
class UpdateSignalement {
  final SignalementRepository _signalementRepository;

  UpdateSignalement(this._signalementRepository);

  Future<Either<Failure, Signalement>> call(Signalement signalement) async {
    return await _signalementRepository.update(signalement);
  }
}

/// Use case for deleting signalement
@injectable
class DeleteSignalement {
  final SignalementRepository _signalementRepository;

  DeleteSignalement(this._signalementRepository);

  Future<Either<Failure, Unit>> call(String signalementId) async {
    return await _signalementRepository.delete(signalementId);
  }
}

/// Use case for getting signalements by status
@injectable
class GetSignalementsByStatus {
  final SignalementRepository _signalementRepository;

  GetSignalementsByStatus(this._signalementRepository);

  Future<Either<Failure, List<Signalement>>> call(
      SignalementStatus status) async {
    return await _signalementRepository.getByStatus(status);
  }
}

/// Use case for getting signalements by priority
@injectable
class GetSignalementsByPriority {
  final SignalementRepository _signalementRepository;

  GetSignalementsByPriority(this._signalementRepository);

  Future<Either<Failure, List<Signalement>>> call(
      SignalementPriority priority) async {
    return await _signalementRepository.getByPriority(priority);
  }
}

/// Use case for getting signalements assigned to a user
@injectable
class GetSignalementsAssignedTo {
  final SignalementRepository _signalementRepository;

  GetSignalementsAssignedTo(this._signalementRepository);

  Future<Either<Failure, List<Signalement>>> call(String userId) async {
    return await _signalementRepository.getAssignedTo(userId);
  }
}

/// Use case for getting signalements created by a user
@injectable
class GetSignalementsCreatedBy {
  final SignalementRepository _signalementRepository;

  GetSignalementsCreatedBy(this._signalementRepository);

  Future<Either<Failure, List<Signalement>>> call(String userId) async {
    return await _signalementRepository.getCreatedBy(userId);
  }
}

/// Use case for updating signalement status
@injectable
class UpdateSignalementStatus {
  final SignalementRepository _signalementRepository;

  UpdateSignalementStatus(this._signalementRepository);

  Future<Either<Failure, Signalement>> call(
    String signalementId,
    SignalementStatus newStatus,
    String updatedBy,
  ) async {
    return await _signalementRepository.updateStatus(
      signalementId,
      newStatus,
      updatedBy,
    );
  }
}

/// Use case for assigning signalement to user
@injectable
class AssignSignalement {
  final SignalementRepository _signalementRepository;

  AssignSignalement(this._signalementRepository);

  Future<Either<Failure, Signalement>> call(
    String signalementId,
    String assignedTo,
    String assignedBy,
  ) async {
    return await _signalementRepository.assignTo(
      signalementId,
      assignedTo,
      assignedBy,
    );
  }
}

/// Use case for adding comment to signalement
@injectable
class AddSignalementComment {
  final SignalementRepository _signalementRepository;

  AddSignalementComment(this._signalementRepository);

  Future<Either<Failure, Signalement>> call(
    String signalementId,
    String comment,
    String authorId,
  ) async {
    return await _signalementRepository.addComment(
      signalementId,
      comment,
      authorId,
    );
  }
}

/// Use case for getting signalements due today
@injectable
class GetSignalementsDueToday {
  final SignalementRepository _signalementRepository;

  GetSignalementsDueToday(this._signalementRepository);

  Future<Either<Failure, List<Signalement>>> call() async {
    return await _signalementRepository.getDueToday();
  }
}

/// Use case for getting overdue signalements
@injectable
class GetOverdueSignalements {
  final SignalementRepository _signalementRepository;

  GetOverdueSignalements(this._signalementRepository);

  Future<Either<Failure, List<Signalement>>> call() async {
    return await _signalementRepository.getOverdue();
  }
}
