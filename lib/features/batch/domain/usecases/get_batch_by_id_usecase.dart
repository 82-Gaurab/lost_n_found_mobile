import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/batch/data/repositories/batch_repository.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

class GetBatchByIdUsecaseParams extends Equatable {
  final String batchId;

  const GetBatchByIdUsecaseParams({required this.batchId});

  @override
  List<Object?> get props => [batchId];
}

// NOTE: Dependency Injection using Provider
final getBatchByIdUsecaseProvider = Provider<GetBatchByIdUsecase>((ref) {
  return GetBatchByIdUsecase(
    batchRepository: ref.read(batchRepositoryProvider),
  );
});

class GetBatchByIdUsecase
    implements UseCaseWithParams<void, GetBatchByIdUsecaseParams> {
  final IBatchRepository _batchRepository;

  GetBatchByIdUsecase({required IBatchRepository batchRepository})
    : _batchRepository = batchRepository;

  @override
  Future<Either<Failure, void>> call(GetBatchByIdUsecaseParams params) {
    return _batchRepository.getBatchById(params.batchId);
  }
}
