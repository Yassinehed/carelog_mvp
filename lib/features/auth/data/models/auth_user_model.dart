/// Data model for AuthUser in the data layer.
/// This is used for Firebase operations and can be converted to/from domain entities.
class AuthUserModel {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final bool emailVerified;
  final DateTime? createdAt;
  final DateTime? lastSignInAt;

  const AuthUserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.emailVerified = false,
    this.createdAt,
    this.lastSignInAt,
  });

  /// Creates an AuthUserModel from Firebase User data.
  factory AuthUserModel.fromFirebase(dynamic firebaseUser) {
    return AuthUserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      emailVerified: firebaseUser.emailVerified ?? false,
      createdAt: firebaseUser.metadata?.creationTime,
      lastSignInAt: firebaseUser.metadata?.lastSignInTime,
    );
  }

  /// Converts this model to a map for storage/serialization if needed.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'emailVerified': emailVerified,
      'createdAt': createdAt?.toIso8601String(),
      'lastSignInAt': lastSignInAt?.toIso8601String(),
    };
  }

  /// Creates an AuthUserModel from a map.
  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String?,
      photoUrl: map['photoUrl'] as String?,
      emailVerified: map['emailVerified'] as bool? ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      lastSignInAt: map['lastSignInAt'] != null
          ? DateTime.parse(map['lastSignInAt'] as String)
          : null,
    );
  }
}
