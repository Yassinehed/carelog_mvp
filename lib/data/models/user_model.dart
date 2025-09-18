import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum UserRoleModel { operateur, controle, admin }

@freezed
class User with _$User {
  const factory User({
    required String userId,
    required String displayName,
    required String email,
    required UserRoleModel role,
    @Default(false) bool emailVerified,
    DateTime? createdAt,
    DateTime? lastSignInAt,
    @Default(1) int version,
    Map<String, dynamic>? metadata,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
