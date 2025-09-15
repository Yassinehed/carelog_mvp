import 'package:dartz/dartz.dart';
import '../../domain/entities/signalement.dart';
import '../../domain/repositories/i_signalement_repository.dart';
import '../datasources/signalement_firestore_datasource.dart';
import '../models/signalement_dto.dart';

/// Firestore implementation of ISignalementRepository.
class FirestoreSignalementRepository implements ISignalementRepository {
  final SignalementFirestoreDatasource datasource;

  const FirestoreSignalementRepository(this.datasource);

  @override
  Future<Either<SignalementFailure, Unit>> createSignalement(
      Signalement signalement) async {
    try {
      final dto = SignalementMapper.toDto(signalement);
      await datasource.createSignalement(dto);
      return right(unit);
    } catch (e) {
      return left(SignalementFailure.unknown());
    }
  }

  @override
  Future<Either<SignalementFailure, List<Signalement>>>
      getSignalements() async {
    try {
      final dtos = await datasource.getSignalements();
      final entities = dtos.map(SignalementMapper.fromDto).toList();
      return right(entities);
    } catch (e) {
      return left(SignalementFailure.network());
    }
  }

  @override
  Future<Either<SignalementFailure, Unit>> updateSignalementStatus(
    String signalementId,
    SignalementStatus newStatus,
  ) async {
    try {
      final statusString = SignalementMapper.statusToString(newStatus);
      await datasource.updateSignalementStatus(signalementId, statusString);
      return right(unit);
    } catch (e) {
      return left(SignalementFailure.unknown());
    }
  }

  @override
  Future<Either<SignalementFailure, Signalement>> getSignalementById(
      String id) async {
    try {
      final dto = await datasource.getSignalementById(id);
      if (dto != null) {
        final entity = SignalementMapper.fromDto(dto);
        return right(entity);
      } else {
        return left(SignalementFailure.notFound());
      }
    } catch (e) {
      return left(SignalementFailure.network());
    }
  }
}
