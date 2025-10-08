import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/entities.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/user_repository.dart';
import '../datasources/remote/firestore_datasource.dart';
import '../mappers/user_mapper.dart' as user_mapper;
import '../models/user_model.dart' as model;

/// Implementation of UserRepository using Firebase
@Injectable()
class UserRepositoryImpl implements UserRepository {
  final FirestoreDataSource _firestoreDataSource;

  UserRepositoryImpl(this._firestoreDataSource);

  static const String _collection = 'users';

  @override
  Future<Either<Failure, User>> getById(String id) async {
    try {
      final doc = await _firestoreDataSource.getDocument(_collection, id);
      if (!doc.exists) {
        return const Left(ServerFailure());
      }
      final userModel = model.User.fromJson(doc.data()!);
      final user = user_mapper.UserMapper.toDomain(userModel);
      return Right(user);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAll() async {
    try {
      final snapshot = await _firestoreDataSource.getAllDocuments(_collection);
      final users = snapshot.docs
          .map((doc) =>
              user_mapper.UserMapper.toDomain(model.User.fromJson(doc.data())))
          .toList();
      return Right(users);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> create(User user) async {
    try {
      final userModel = user_mapper.UserMapper.toModel(user);
      await _firestoreDataSource.setDocument(
        _collection,
        user.id,
        userModel.toJson(),
      );
      return Right(user);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> update(User user) async {
    try {
      final userModel = user_mapper.UserMapper.toModel(user);
      await _firestoreDataSource.updateDocument(
        _collection,
        user.id,
        userModel.toJson(),
      );
      return Right(user);
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
  Future<Either<Failure, int>> count({Map<String, dynamic>? filters}) async {
    try {
      if (filters != null && filters.isNotEmpty) {
        // If filters are provided, use query to count
        final snapshot = await _firestoreDataSource.getDocumentsWithQuery(
          _collection,
          (query) {
            Query<Map<String, dynamic>> q = query;
            filters.forEach((key, value) {
              q = q.where(key, isEqualTo: value);
            });
            return q;
          },
        );
        return Right(snapshot.docs.length);
      } else {
        // No filters, count all documents
        final snapshot =
            await _firestoreDataSource.getAllDocuments(_collection);
        return Right(snapshot.docs.length);
      }
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> exists(String id) async {
    try {
      final doc = await _firestoreDataSource.getDocument(_collection, id);
      return Right(doc.exists);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> getPaginated({
    int limit = 20,
    String? startAfter,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final snapshot = await _firestoreDataSource.getDocumentsPaginated(
        _collection,
        startAfter: startAfter != null
            ? await _firestoreDataSource.getDocument(_collection, startAfter)
            : null,
        limit: limit,
        queryBuilder: filters != null && filters.isNotEmpty
            ? (query) {
                Query<Map<String, dynamic>> q = query;
                filters.forEach((key, value) {
                  q = q.where(key, isEqualTo: value);
                });
                return q;
              }
            : null,
      );

      final users = snapshot.docs
          .map((doc) =>
              user_mapper.UserMapper.toDomain(model.User.fromJson(doc.data())))
          .toList();

      return Right(users);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  // UserRepository specific methods
  @override
  Future<Either<Failure, User>> getByEmail(String email) async {
    try {
      final snapshot = await _firestoreDataSource.getDocumentsWithQuery(
        _collection,
        (query) => query.where('email', isEqualTo: email),
      );
      if (snapshot.docs.isEmpty) {
        return const Left(ServerFailure());
      }
      final userModel = model.User.fromJson(snapshot.docs.first.data());
      final user = user_mapper.UserMapper.toDomain(userModel);
      return Right(user);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> getByRole(UserRole role) async {
    try {
      final roleModel = user_mapper.UserMapper.mapRoleDomainToModel(role);
      final snapshot = await _firestoreDataSource.getDocumentsWithQuery(
        _collection,
        (query) => query.where('role', isEqualTo: roleModel.name),
      );
      final users = snapshot.docs
          .map((doc) =>
              user_mapper.UserMapper.toDomain(model.User.fromJson(doc.data())))
          .toList();
      return Right(users);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> updateRole(
      String userId, UserRole newRole) async {
    try {
      // First get the current user
      final getResult = await getById(userId);
      return getResult.fold(
        (failure) => Left(failure),
        (user) async {
          // Update the role
          final updatedUser = user.copyWith(role: newRole);
          // Save the updated user
          return update(updatedUser);
        },
      );
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isEmailAvailable(String email) async {
    try {
      final result = await getByEmail(email);
      return result.fold(
        (failure) =>
            const Right(true), // Email is available if getByEmail fails
        (user) => const Right(false), // Email is not available if user exists
      );
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async =>
      const Left(ServerFailure());

  @override
  Future<Either<Failure, User>> updateProfile(User user) async {
    return update(user);
  }

  @override
  Future<Either<Failure, List<User>>> search(String query) async {
    try {
      // Search by displayName or email (case-sensitive exact match for now)
      final snapshot = await _firestoreDataSource.getDocumentsWithQuery(
        _collection,
        (q) => q.where('displayName', isEqualTo: query),
      );

      final emailSnapshot = await _firestoreDataSource.getDocumentsWithQuery(
        _collection,
        (q) => q.where('email', isEqualTo: query),
      );

      final allDocs = {...snapshot.docs, ...emailSnapshot.docs};
      final users = allDocs
          .map((doc) =>
              user_mapper.UserMapper.toDomain(model.User.fromJson(doc.data())))
          .toList();

      return Right(users);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAdmins() async {
    return getByRole(UserRole.admin);
  }

  @override
  Future<Either<Failure, int>> getActiveUsersCount() async {
    // For now, return total count. In future, could filter by active status
    return count();
  }
}
