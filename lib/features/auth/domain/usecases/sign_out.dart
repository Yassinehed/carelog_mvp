import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../repositories/i_auth_repository.dart';

/// Use case for signing out the current user
@Injectable()
class SignOutUseCase {
  final IAuthRepository repository;

  const SignOutUseCase(this.repository);

  Future<Either<AuthFailure, Unit>> call() {
    return repository.signOut();
  }
}
