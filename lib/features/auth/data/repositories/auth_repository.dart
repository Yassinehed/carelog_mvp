import 'package:dartz/dartz.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';
import '../models/auth_user_model.dart';

/// Repository implementation for authentication operations
class AuthRepository implements IAuthRepository {
  final FirebaseAuthDatasource _datasource;

  AuthRepository(this._datasource);

  @override
  Stream<AuthUser?> get authStateChanges {
    return _datasource.authStateChanges.map((model) {
      return model != null ? _modelToEntity(model) : null;
    });
  }

  @override
  AuthUser? get currentUser {
    final model = _datasource.currentUser;
    return model != null ? _modelToEntity(model) : null;
  }

  @override
  Future<Either<AuthFailure, AuthUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _datasource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(_modelToEntity(model));
    } catch (e) {
      // Log the raw error to help debugging (FirebaseAuthException has code/message)
      try {
        // ignore: avoid_print
        print('signInWithEmailAndPassword error: $e');
      } catch (_) {}
      return Left(_mapFirebaseError(e));
    }
  }

  @override
  Future<Either<AuthFailure, AuthUser>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _datasource.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(_modelToEntity(model));
    } catch (e) {
      try {
        // ignore: avoid_print
        print('createUserWithEmailAndPassword error: $e');
      } catch (_) {}
      return Left(_mapFirebaseError(e));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await _datasource.signOut();
      return const Right(unit);
    } catch (e) {
      try {
        // ignore: avoid_print
        print('signOut error: $e');
      } catch (_) {}
      return Left(_mapFirebaseError(e));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _datasource.sendPasswordResetEmail(email: email);
      return const Right(unit);
    } catch (e) {
      try {
        // ignore: avoid_print
        print('sendPasswordResetEmail error: $e');
      } catch (_) {}
      return Left(_mapFirebaseError(e));
    }
  }

  @override
  Future<Either<AuthFailure, AuthUser>> reloadUser() async {
    try {
      final model = await _datasource.reloadUser();
      return Right(_modelToEntity(model));
    } catch (e) {
      try {
        // ignore: avoid_print
        print('reloadUser error: $e');
      } catch (_) {}
      return Left(_mapFirebaseError(e));
    }
  }

  /// Converts AuthUserModel to AuthUser entity
  AuthUser _modelToEntity(AuthUserModel model) {
    return AuthUser(
      id: model.id,
      email: model.email,
      displayName: model.displayName,
      photoUrl: model.photoUrl,
      emailVerified: model.emailVerified,
      createdAt: model.createdAt,
      lastSignInAt: model.lastSignInAt,
    );
  }

  /// Maps Firebase exceptions to AuthFailure types
  AuthFailure _mapFirebaseError(dynamic error) {
    // This is a simplified error mapping. In a real app, you'd want more specific error handling
    // based on FirebaseAuthException codes
    if (error.toString().contains('user-not-found')) {
      return const AuthUserNotFoundFailure();
    } else if (error.toString().contains('wrong-password') ||
        error.toString().contains('invalid-credential')) {
      return const AuthInvalidCredentialsFailure();
    } else if (error.toString().contains('email-already-in-use')) {
      return const AuthEmailAlreadyInUseFailure();
    } else if (error.toString().contains('too-many-requests')) {
      return const AuthTooManyRequestsFailure();
    } else if (error.toString().contains('network-request-failed')) {
      return const AuthNetworkErrorFailure();
    } else {
      return const AuthUnknownFailure();
    }
  }
}
