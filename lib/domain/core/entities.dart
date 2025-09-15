import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Base class for all domain entities
abstract class Entity extends Equatable {
  const Entity();

  /// Unique identifier for the entity
  String get id;

  /// Version for optimistic concurrency
  int get version;

  @override
  List<Object?> get props => [id, version];
}

/// Base class for all domain failures
abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

/// Common domain failures
class ServerFailure extends Failure {
  const ServerFailure();
}

class CacheFailure extends Failure {
  const CacheFailure();
}

class ValidationFailure extends Failure {
  final String message;
  const ValidationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class NotFoundFailure extends Failure {
  final String entityId;
  const NotFoundFailure(this.entityId);

  @override
  List<Object?> get props => [entityId];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();
}

class NetworkFailure extends Failure {
  const NetworkFailure();
}

/// Base repository interface with common CRUD operations
abstract class BaseRepository<T extends Entity> {
  /// Get entity by ID
  Future<Either<Failure, T>> getById(String id);

  /// Get all entities
  Future<Either<Failure, List<T>>> getAll();

  /// Create new entity
  Future<Either<Failure, T>> create(T entity);

  /// Update existing entity
  Future<Either<Failure, T>> update(T entity);

  /// Delete entity by ID
  Future<Either<Failure, Unit>> delete(String id);

  /// Check if entity exists
  Future<Either<Failure, bool>> exists(String id);

  /// Get entities with pagination
  Future<Either<Failure, List<T>>> getPaginated({
    int limit = 20,
    String? startAfter,
    Map<String, dynamic>? filters,
  });

  /// Search entities
  Future<Either<Failure, List<T>>> search(String query);

  /// Count total entities
  Future<Either<Failure, int>> count({Map<String, dynamic>? filters});
}

/// Base use case interface
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case parameters base class
abstract class UseCaseParams extends Equatable {
  const UseCaseParams();

  @override
  List<Object?> get props => [];
}

/// No parameters use case
class NoParams extends UseCaseParams {
  const NoParams();

  @override
  List<Object?> get props => [];
}

/// Single ID parameter
class IdParams extends UseCaseParams {
  final String id;

  const IdParams(this.id);

  @override
  List<Object?> get props => [id];
}

/// Pagination parameters
class PaginationParams extends UseCaseParams {
  final int limit;
  final String? startAfter;
  final Map<String, dynamic>? filters;

  const PaginationParams({
    this.limit = 20,
    this.startAfter,
    this.filters,
  });

  @override
  List<Object?> get props => [limit, startAfter, filters];
}

/// Search parameters
class SearchParams extends UseCaseParams {
  final String query;
  final int? limit;

  const SearchParams(this.query, {this.limit});

  @override
  List<Object?> get props => [query, limit];
}
