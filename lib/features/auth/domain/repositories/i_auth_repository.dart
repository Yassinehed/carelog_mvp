import 'package:dartz/dartz.dart';
import '../entities/auth_user.dart';

/// Authentication repository interface
abstract class IAuthRepository {
  /// Stream of authentication state changes
  Stream<AuthUser?> get authStateChanges;

  /// Current authenticated user, null if not authenticated
  AuthUser? get currentUser;

  /// Sign in with email and password
  Future<Either<AuthFailure, AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Create account with email and password
  Future<Either<AuthFailure, AuthUser>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign out current user
  Future<Either<AuthFailure, Unit>> signOut();

  /// Send password reset email
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail({
    required String email,
  });

  /// Reload current user data
  Future<Either<AuthFailure, AuthUser>> reloadUser();
}

/// Failure types for authentication operations.
abstract class AuthFailure {
  const AuthFailure();

  factory AuthFailure.cancelled() = AuthCancelledFailure;
  factory AuthFailure.invalidCredentials() = AuthInvalidCredentialsFailure;
  factory AuthFailure.emailAlreadyInUse() = AuthEmailAlreadyInUseFailure;
  factory AuthFailure.userNotFound() = AuthUserNotFoundFailure;
  factory AuthFailure.tooManyRequests() = AuthTooManyRequestsFailure;
  factory AuthFailure.networkError() = AuthNetworkErrorFailure;
  factory AuthFailure.unknown() = AuthUnknownFailure;
}

class AuthCancelledFailure extends AuthFailure {
  const AuthCancelledFailure();
}

class AuthInvalidCredentialsFailure extends AuthFailure {
  const AuthInvalidCredentialsFailure();
}

class AuthEmailAlreadyInUseFailure extends AuthFailure {
  const AuthEmailAlreadyInUseFailure();
}

class AuthUserNotFoundFailure extends AuthFailure {
  const AuthUserNotFoundFailure();
}

class AuthTooManyRequestsFailure extends AuthFailure {
  const AuthTooManyRequestsFailure();
}

class AuthNetworkErrorFailure extends AuthFailure {
  const AuthNetworkErrorFailure();
}

class AuthUnknownFailure extends AuthFailure {
  const AuthUnknownFailure();
}
