import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../repositories/i_auth_repository.dart';

/// Use case per il reset della password
@Injectable()
class ResetPasswordUseCase {
  final IAuthRepository repository;

  const ResetPasswordUseCase(this.repository);

  /// Esegue il reset della password per l'email specificata
  Future<Either<AuthFailure, Unit>> call(String email) async {
    return await repository.sendPasswordResetEmail(email: email);
  }
}

/// Parametri per il reset password
class ResetPasswordParams {
  final String email;

  const ResetPasswordParams({required this.email});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ResetPasswordParams && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}
