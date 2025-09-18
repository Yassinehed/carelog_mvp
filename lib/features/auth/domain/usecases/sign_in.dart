import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../entities/auth_user.dart';
import '../repositories/i_auth_repository.dart';

/// Use case for signing in with email and password
@Injectable()
class SignInUseCase {
  final IAuthRepository repository;

  const SignInUseCase(this.repository);

  Future<Either<AuthFailure, AuthUser>> call(SignInParams params) {
    return repository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters for sign in use case
class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
