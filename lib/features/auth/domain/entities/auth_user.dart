import 'package:equatable/equatable.dart';

/// Represents an authenticated user in the system.
class AuthUser extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final bool emailVerified;
  final DateTime? createdAt;
  final DateTime? lastSignInAt;

  const AuthUser({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.emailVerified = false,
    this.createdAt,
    this.lastSignInAt,
  });

  /// Creates an AuthUser from Firebase User data.
  factory AuthUser.fromFirebase(dynamic firebaseUser) {
    return AuthUser(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      emailVerified: firebaseUser.emailVerified ?? false,
      createdAt: firebaseUser.metadata?.creationTime,
      lastSignInAt: firebaseUser.metadata?.lastSignInTime,
    );
  }

  /// Creates a copy of this AuthUser with updated fields.
  AuthUser copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? emailVerified,
    DateTime? createdAt,
    DateTime? lastSignInAt,
  }) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt ?? this.createdAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoUrl,
        emailVerified,
        createdAt,
        lastSignInAt,
      ];
}
