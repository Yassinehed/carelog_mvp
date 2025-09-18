import 'package:injectable/injectable.dart';
import '../entities/auth_user.dart';
import '../repositories/i_auth_repository.dart';

/// Use case for getting the current authenticated user
@Injectable()
class GetCurrentUserUseCase {
  final IAuthRepository repository;

  const GetCurrentUserUseCase(this.repository);

  AuthUser? call() {
    return repository.currentUser;
  }
}
