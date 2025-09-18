import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/entities.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/user_repository.dart';

/// Use case for getting current authenticated user
@injectable
class GetCurrentUser {
  final UserRepository _userRepository;

  GetCurrentUser(this._userRepository);

  Future<Either<Failure, User>> call() async {
    return await _userRepository.getCurrentUser();
  }
}

/// Use case for getting user by ID
@injectable
class GetUserById {
  final UserRepository _userRepository;

  GetUserById(this._userRepository);

  Future<Either<Failure, User>> call(String userId) async {
    return await _userRepository.getById(userId);
  }
}

/// Use case for getting user by email
@injectable
class GetUserByEmail {
  final UserRepository _userRepository;

  GetUserByEmail(this._userRepository);

  Future<Either<Failure, User>> call(String email) async {
    return await _userRepository.getByEmail(email);
  }
}

/// Use case for checking if email is available
@injectable
class CheckEmailAvailability {
  final UserRepository _userRepository;

  CheckEmailAvailability(this._userRepository);

  Future<Either<Failure, bool>> call(String email) async {
    return await _userRepository.isEmailAvailable(email);
  }
}

/// Use case for updating user profile
@injectable
class UpdateUserProfile {
  final UserRepository _userRepository;

  UpdateUserProfile(this._userRepository);

  Future<Either<Failure, User>> call(User user) async {
    return await _userRepository.updateProfile(user);
  }
}

/// Use case for updating user role
@injectable
class UpdateUserRole {
  final UserRepository _userRepository;

  UpdateUserRole(this._userRepository);

  Future<Either<Failure, User>> call(String userId, UserRole newRole) async {
    return await _userRepository.updateRole(userId, newRole);
  }
}

/// Use case for getting users by role
@injectable
class GetUsersByRole {
  final UserRepository _userRepository;

  GetUsersByRole(this._userRepository);

  Future<Either<Failure, List<User>>> call(UserRole role) async {
    return await _userRepository.getByRole(role);
  }
}

/// Use case for getting admin users
@injectable
class GetAdminUsers {
  final UserRepository _userRepository;

  GetAdminUsers(this._userRepository);

  Future<Either<Failure, List<User>>> call() async {
    return await _userRepository.getAdmins();
  }
}

/// Use case for searching users
@injectable
class SearchUsers {
  final UserRepository _userRepository;

  SearchUsers(this._userRepository);

  Future<Either<Failure, List<User>>> call(String query) async {
    return await _userRepository.search(query);
  }
}

/// Use case for getting active users count
@injectable
class GetActiveUsersCount {
  final UserRepository _userRepository;

  GetActiveUsersCount(this._userRepository);

  Future<Either<Failure, int>> call() async {
    return await _userRepository.getActiveUsersCount();
  }
}
