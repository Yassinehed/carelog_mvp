import 'package:dartz/dartz.dart';
import '../../domain/core/entities.dart';
import '../entities/user.dart';

/// Repository interface for User domain operations
abstract class UserRepository extends BaseRepository<User> {
  /// Get user by email
  Future<Either<Failure, User>> getByEmail(String email);

  /// Get users by role
  Future<Either<Failure, List<User>>> getByRole(UserRole role);

  /// Update user role
  Future<Either<Failure, User>> updateRole(String userId, UserRole newRole);

  /// Check if email is available
  Future<Either<Failure, bool>> isEmailAvailable(String email);

  /// Get current authenticated user
  Future<Either<Failure, User>> getCurrentUser();

  /// Update user profile
  Future<Either<Failure, User>> updateProfile(User user);

  /// Search users by name or email
  @override
  Future<Either<Failure, List<User>>> search(String query);

  /// Get admin users
  Future<Either<Failure, List<User>>> getAdmins();

  /// Get active users count
  Future<Either<Failure, int>> getActiveUsersCount();
}
