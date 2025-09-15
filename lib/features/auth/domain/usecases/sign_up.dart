import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../entities/auth_user.dart';
import '../repositories/i_auth_repository.dart';

/// Use case for creating a new account with email and password
@Injectable()
class SignUpUseCase {
  final IAuthRepository repository;

  const SignUpUseCase(this.repository);

  Future<Either<AuthFailure, AuthUser>> call(SignUpParams params) {
    return repository.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters for sign up use case
class SignUpParams extends Equatable {
  final String email;
  final String password;

  const SignUpParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
