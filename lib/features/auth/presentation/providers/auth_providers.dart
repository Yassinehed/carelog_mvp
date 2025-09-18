import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/auth_user.dart';
import 'package:carelog_mvp/features/auth/domain/repositories/i_auth_repository.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_up.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/reset_password.dart';
import '../../../../injection.dart';

/// Provider per il caso d'uso SignInUseCase
final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return getIt<SignInUseCase>();
});

/// Provider per il caso d'uso SignUpUseCase
final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return getIt<SignUpUseCase>();
});

/// Provider per il caso d'uso SignOutUseCase
final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  return getIt<SignOutUseCase>();
});

/// Provider per il caso d'uso GetCurrentUserUseCase
final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return getIt<GetCurrentUserUseCase>();
});

/// Provider per il caso d'uso ResetPasswordUseCase
final resetPasswordUseCaseProvider = Provider<ResetPasswordUseCase>((ref) {
  return getIt<ResetPasswordUseCase>();
});

/// Stato per l'autenticazione
class AuthState {
  final AuthUser? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    AuthUser? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get isAuthenticated => user != null;
}

/// Notifier per gestire lo stato dell'autenticazione
class AuthNotifier extends StateNotifier<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  late final StreamSubscription<AuthUser?> _authSub;

  AuthNotifier(
    this._signInUseCase,
    this._signUpUseCase,
    this._signOutUseCase,
    this._resetPasswordUseCase,
  ) : super(const AuthState(isLoading: true)) {
    // Subscribe to repository auth state changes to initialize auth state
    final repo = getIt<IAuthRepository>();
    _authSub = repo.authStateChanges.listen((user) {
      // Debug logging to trace initial auth state during startup
      // ignore: avoid_print
      print('Auth stream emitted user: ${user?.email ?? 'null'}');
      state = state.copyWith(user: user, isLoading: false);
    });
  }

  @override
  void dispose() {
    _authSub.cancel();
    super.dispose();
  }

  /// Effettua il login con email e password
  Future<bool> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final result =
        await _signInUseCase(SignInParams(email: email, password: password));

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
        return false;
      },
      (user) {
        state = state.copyWith(
          user: user,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  /// Effettua la registrazione con email e password
  Future<bool> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final result =
        await _signUpUseCase(SignUpParams(email: email, password: password));

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
        return false;
      },
      (user) {
        state = state.copyWith(
          user: user,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  /// Effettua il logout
  Future<bool> signOut() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _signOutUseCase();

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
        return false;
      },
      (_) {
        state = state.copyWith(
          user: null,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  /// Invia email di reset password
  Future<bool> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _resetPasswordUseCase(email);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
        return false;
      },
      (_) {
        state = state.copyWith(
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  /// Aggiorna lo stato dell'utente corrente
  void updateUser(AuthUser? user) {
    state = state.copyWith(user: user, error: null);
  }

  /// Imposta un errore
  void setError(String error) {
    state = state.copyWith(error: error, isLoading: false);
  }

  /// Cancella l'errore
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Converte un AuthFailure in un messaggio di errore user-friendly
  String _mapFailureToMessage(AuthFailure failure) {
    if (failure is AuthInvalidCredentialsFailure) {
      return 'Email o password non valide';
    } else if (failure is AuthUserNotFoundFailure) {
      return 'Utente non trovato';
    } else if (failure is AuthEmailAlreadyInUseFailure) {
      return 'Email già in uso';
    } else if (failure is AuthTooManyRequestsFailure) {
      return 'Troppi tentativi. Riprova più tardi';
    } else if (failure is AuthNetworkErrorFailure) {
      return 'Errore di connessione. Controlla la tua connessione internet';
    } else {
      return 'Si è verificato un errore. Riprova';
    }
  }
}

/// Provider per il notifier dell'autenticazione
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final signInUseCase = ref.watch(signInUseCaseProvider);
  final signUpUseCase = ref.watch(signUpUseCaseProvider);
  final signOutUseCase = ref.watch(signOutUseCaseProvider);
  final resetPasswordUseCase = ref.watch(resetPasswordUseCaseProvider);

  return AuthNotifier(
    signInUseCase,
    signUpUseCase,
    signOutUseCase,
    resetPasswordUseCase,
  );
});

/// Provider per controllare se l'utente è autenticato
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isAuthenticated;
});

/// Provider per ottenere l'utente corrente
final currentUserProvider = Provider<AuthUser?>((ref) {
  return ref.watch(authNotifierProvider).user;
});
