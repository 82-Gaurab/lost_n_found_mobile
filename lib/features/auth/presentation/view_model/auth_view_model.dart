import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/features/auth/domain/usecases/login_usecase.dart';
import 'package:lost_n_found/features/auth/domain/usecases/register_usecase.dart';
import 'package:lost_n_found/features/auth/presentation/state/auth_state.dart';

// INFO: Notifier Provider
final authViewModelProvider = NotifierProvider<AuthViewModel, AuthState>(
  () => AuthViewModel(),
);

class AuthViewModel extends Notifier<AuthState> {
  late final LoginUsecase _loginUsecase;
  late final RegisterUsecase _registerUsecase;

  @override
  AuthState build() {
    _loginUsecase = ref.read(loginUsecaseProvider);
    _registerUsecase = ref.read(registerUsecaseProvider);
    return AuthState();
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String username,
    String? batchId,
    String? phoneNumber,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);

    final params = RegisterUsecaseParams(
      fullName: fullName,
      email: email,
      username: username,
      password: password,
      batchId: batchId,
      phoneNumber: phoneNumber,
    );

    final result = await _registerUsecase(params);

    result.fold(
      (left) => state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: left.message,
      ),
      (right) {
        if (right) {
          state = state.copyWith(status: AuthStatus.registered);
        } else {
          state = state.copyWith(
            status: AuthStatus.error,
            errorMessage: "Registration failed",
          );
        }
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading);

    final params = LoginUsecaseParams(email: email, password: password);

    final result = await _loginUsecase(params);

    result.fold(
      (left) => state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: left.message,
      ),
      (authEntity) => state = state.copyWith(
        status: AuthStatus.authenticated,
        authEntity: authEntity,
      ),
    );
  }
}
