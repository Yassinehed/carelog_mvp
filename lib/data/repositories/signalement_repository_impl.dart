import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/entities.dart';
import '../../../domain/entities/signalement.dart';
import '../../../domain/repositories/signalement_repository.dart';
import '../datasources/remote/firestore_datasource.dart';
import '../mappers/signalement_mapper.dart' as signalement_mapper;
import '../models/signalement_model.dart' as model;

/// Implementation of SignalementRepository using Firebase
@Injectable(as: SignalementRepository)
class SignalementRepositoryImpl implements SignalementRepository {
  final FirestoreDataSource _firestoreDataSource;

  SignalementRepositoryImpl(this._firestoreDataSource);

  static const String _collection = 'signalements';

  @override
  Future<Either<Failure, Signalement>> getById(String id) async {
    try {
      final doc = await _firestoreDataSource.getDocument(_collection, id);
      if (!doc.exists) {
        return const Left(ServerFailure());
      }
      final signalementModel = model.Signalement.fromJson(doc.data()!);
      final signalement =
          signalement_mapper.SignalementMapper.toDomain(signalementModel);
      return Right(signalement);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Signalement>>> getAll() async {
    try {
      final snapshot = await _firestoreDataSource.getAllDocuments(_collection);
      final signalements = snapshot.docs
          .map((doc) => signalement_mapper.SignalementMapper.toDomain(
              model.Signalement.fromJson(doc.data())))
          .toList();
      return Right(signalements);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Signalement>> create(Signalement signalement) async {
    try {
      final signalementModel =
          signalement_mapper.SignalementMapper.toModel(signalement);
      await _firestoreDataSource.setDocument(
          _collection, signalement.id, signalementModel.toJson());
      return Right(signalement);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Signalement>> update(Signalement signalement) async {
    try {
      final signalementModel =
          signalement_mapper.SignalementMapper.toModel(signalement);
      await _firestoreDataSource.updateDocument(
          _collection, signalement.id, signalementModel.toJson());
      return Right(signalement);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> delete(String id) async {
    try {
      await _firestoreDataSource.deleteDocument(_collection, id);
      return const Right(unit);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, int>> count({Map<String, dynamic>? filters}) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, bool>> exists(String id) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Signalement>>> getPaginated({
    int limit = 20,
    String? startAfter,
    Map<String, dynamic>? filters,
  }) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Signalement>>> search(String query) async =>
      const Left(ServerFailure());

  // SignalementRepository specific methods
  @override
  Future<Either<Failure, List<Signalement>>> getByStatus(
      SignalementStatus status) async {
    try {
      final statusModel =
          signalement_mapper.SignalementMapper.mapStatusDomainToModel(status);
      final snapshot = await _firestoreDataSource.getDocumentsWithQuery(
        _collection,
        (query) => query.where('status', isEqualTo: statusModel.name),
      );
      final signalements = snapshot.docs
          .map((doc) => signalement_mapper.SignalementMapper.toDomain(
              model.Signalement.fromJson(doc.data())))
          .toList();
      return Right(signalements);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Signalement>>> getByPriority(
      SignalementPriority priority) async {
    try {
      final priorityModel =
          signalement_mapper.SignalementMapper.mapPriorityDomainToModel(
              priority);
      final snapshot = await _firestoreDataSource.getDocumentsWithQuery(
        _collection,
        (query) => query.where('priority', isEqualTo: priorityModel.name),
      );
      final signalements = snapshot.docs
          .map((doc) => signalement_mapper.SignalementMapper.toDomain(
              model.Signalement.fromJson(doc.data())))
          .toList();
      return Right(signalements);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Signalement>>> getAssignedTo(
      String userId) async {
    try {
      final snapshot = await _firestoreDataSource.getDocumentsWithQuery(
        _collection,
        (query) => query.where('assignedTo', isEqualTo: userId),
      );
      final signalements = snapshot.docs
          .map((doc) => signalement_mapper.SignalementMapper.toDomain(
              model.Signalement.fromJson(doc.data())))
          .toList();
      return Right(signalements);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Signalement>>> getCreatedBy(String userId) async {
    try {
      final snapshot = await _firestoreDataSource.getDocumentsWithQuery(
        _collection,
        (query) => query.where('createdBy', isEqualTo: userId),
      );
      final signalements = snapshot.docs
          .map((doc) => signalement_mapper.SignalementMapper.toDomain(
              model.Signalement.fromJson(doc.data())))
          .toList();
      return Right(signalements);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Signalement>>> getByCategory(
      String category) async {
    try {
      final snapshot = await _firestoreDataSource.getDocumentsWithQuery(
        _collection,
        (query) => query.where('category', isEqualTo: category),
      );
      final signalements = snapshot.docs
          .map((doc) => signalement_mapper.SignalementMapper.toDomain(
              model.Signalement.fromJson(doc.data())))
          .toList();
      return Right(signalements);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Signalement>> updateStatus(
    String signalementId,
    SignalementStatus newStatus,
    String updatedBy,
  ) async {
    try {
      // First get the current signalement
      final getResult = await getById(signalementId);
      return getResult.fold(
        (failure) => Left(failure),
        (signalement) async {
          // Update the signalement with new status
          final updatedSignalement = signalement.copyWith(
            status: newStatus,
            updatedAt: DateTime.now(),
          );
          // Save the updated signalement
          final updateResult = await update(updatedSignalement);
          return updateResult;
        },
      );
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Signalement>> assignTo(
    String signalementId,
    String assignedTo,
    String assignedBy,
  ) async {
    try {
      // First get the current signalement
      final getResult = await getById(signalementId);
      return getResult.fold(
        (failure) => Left(failure),
        (signalement) async {
          // Update the signalement with new assignment
          final updatedSignalement = signalement.copyWith(
            assignedTo: assignedTo,
            updatedAt: DateTime.now(),
          );
          // Save the updated signalement
          final updateResult = await update(updatedSignalement);
          return updateResult;
        },
      );
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Signalement>> addComment(
    String signalementId,
    String comment,
    String authorId,
  ) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Signalement>>> getDueToday() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Signalement>>> getOverdue() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Signalement>>> getByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, SignalementStats>> getStatistics() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, List<Signalement>>> searchWithFilters({
    String? query,
    SignalementStatus? status,
    SignalementPriority? priority,
    String? category,
    String? assignedTo,
    DateTime? startDate,
    DateTime? endDate,
  }) async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, Map<SignalementStatus, int>>>
      getCountByStatus() async => const Left(ServerFailure());

  @override
  Future<Either<Failure, int>> archiveOldCompleted(int daysOld) async =>
      const Left(ServerFailure());
}
