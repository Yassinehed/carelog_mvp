import '../../domain/core/entities.dart';

/// User roles in the system
enum UserRole { operateur, controle, admin }

/// User entity representing a system user
class User extends Entity {
  final String userId;
  final String displayName;
  final String email;
  final UserRole role;
  final bool emailVerified;
  final DateTime? createdAt;
  final DateTime? lastSignInAt;
  @override
  final int version;

  const User({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.role,
    this.emailVerified = false,
    this.createdAt,
    this.lastSignInAt,
    this.version = 1,
  });

  @override
  String get id => userId;

  /// Creates a copy with updated fields
  User copyWith({
    String? userId,
    String? displayName,
    String? email,
    UserRole? role,
    bool? emailVerified,
    DateTime? createdAt,
    DateTime? lastSignInAt,
    int? version,
  }) {
    return User(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      role: role ?? this.role,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt ?? this.createdAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      version: version ?? this.version,
    );
  }

  /// Checks if user has admin privileges
  bool get isAdmin => role == UserRole.admin;

  /// Checks if user has control privileges
  bool get isControl => role == UserRole.controle;

  /// Checks if user is operator
  bool get isOperator => role == UserRole.operateur;

  /// Returns role display name in French
  String get roleDisplayName {
    switch (role) {
      case UserRole.admin:
        return 'Administrateur';
      case UserRole.controle:
        return 'Contrôle';
      case UserRole.operateur:
        return 'Opérateur';
    }
  }
}
