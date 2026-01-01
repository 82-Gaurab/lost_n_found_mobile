import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/auth/data/repositories/auth_repository.dart';
import 'package:lost_n_found/features/auth/domain/entities/auth_entity.dart';
import 'package:lost_n_found/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecaseParams extends Equatable {
  final String fullName;
  final String email;
  final String? batchId;
  final String username;
  final String password;
  final String? phoneNumber;

  const RegisterUsecaseParams({
    required this.fullName,
    required this.email,
    required this.username,
    required this.password,
    this.batchId,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [
    fullName,
    email,
    batchId,
    username,
    password,
    phoneNumber,
  ];
}

// provider
final registerUsecaseProvider = Provider<RegisterUsecase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return RegisterUsecase(authRepository: authRepository);
});

class RegisterUsecase
    implements UseCaseWithParams<bool, RegisterUsecaseParams> {
  final IAuthRepository _authRepository;

  RegisterUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, bool>> call(RegisterUsecaseParams params) {
    final entity = AuthEntity(
      fullName: params.fullName,
      email: params.email,
      username: params.username,
      phoneNumber: params.phoneNumber,
      batchId: params.batchId,
      password: params.password,
    );

    return _authRepository.register(entity);
  }
}
