import '../../domain/entities/user.dart' as domain;
import '../models/user_model.dart' as model;

/// Mapper for converting between User domain entity and UserModel data model
class UserMapper {
  /// Converts UserModel to User domain entity
  static domain.User toDomain(model.User modelUser) {
    return domain.User(
      userId: modelUser.userId,
      displayName: modelUser.displayName,
      email: modelUser.email,
      role: _mapRoleModelToDomain(modelUser.role),
      emailVerified: modelUser.emailVerified,
      createdAt: modelUser.createdAt,
      lastSignInAt: modelUser.lastSignInAt,
      version: modelUser.version,
    );
  }

  /// Converts User domain entity to UserModel
  static model.User toModel(domain.User entity) {
    return model.User(
      userId: entity.userId,
      displayName: entity.displayName,
      email: entity.email,
      role: mapRoleDomainToModel(entity.role),
      emailVerified: entity.emailVerified,
      createdAt: entity.createdAt,
      lastSignInAt: entity.lastSignInAt,
      version: entity.version,
    );
  }

  /// Converts UserRoleModel to UserRole domain enum
  static domain.UserRole _mapRoleModelToDomain(model.UserRoleModel modelRole) {
    switch (modelRole) {
      case model.UserRoleModel.operateur:
        return domain.UserRole.operateur;
      case model.UserRoleModel.controle:
        return domain.UserRole.controle;
      case model.UserRoleModel.admin:
        return domain.UserRole.admin;
    }
  }

  /// Converts UserRole domain enum to UserRoleModel
  static model.UserRoleModel mapRoleDomainToModel(domain.UserRole domainRole) {
    switch (domainRole) {
      case domain.UserRole.operateur:
        return model.UserRoleModel.operateur;
      case domain.UserRole.controle:
        return model.UserRoleModel.controle;
      case domain.UserRole.admin:
        return model.UserRoleModel.admin;
    }
  }
}
