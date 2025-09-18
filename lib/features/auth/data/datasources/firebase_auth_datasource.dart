import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../models/auth_user_model.dart';

/// Abstract datasource for authentication operations
abstract class IAuthDatasource {
  /// Stream of authentication state changes
  Stream<AuthUserModel?> get authStateChanges;

  /// Current user
  AuthUserModel? get currentUser;

  /// Sign in with email and password
  Future<AuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Create account with email and password
  Future<AuthUserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign out
  Future<void> signOut();

  /// Send password reset email
  Future<void> sendPasswordResetEmail({
    required String email,
  });

  /// Reload current user
  Future<AuthUserModel> reloadUser();
}

/// Firebase implementation of authentication datasource
@Injectable()
class FirebaseAuthDatasource implements IAuthDatasource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDatasource(this._firebaseAuth);

  @override
  Stream<AuthUserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      return user != null ? AuthUserModel.fromFirebase(user) : null;
    });
  }

  @override
  AuthUserModel? get currentUser {
    final user = _firebaseAuth.currentUser;
    return user != null ? AuthUserModel.fromFirebase(user) : null;
  }

  @override
  Future<AuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return AuthUserModel.fromFirebase(userCredential.user!);
  }

  @override
  Future<AuthUserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return AuthUserModel.fromFirebase(userCredential.user!);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<AuthUserModel> reloadUser() async {
    await _firebaseAuth.currentUser?.reload();
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return AuthUserModel.fromFirebase(user);
    } else {
      throw Exception('User not found after reload');
    }
  }
}
