import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/batch/data/repositories/batch_repository.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

class DeleteBatchUsecaseParams extends Equatable {
  final String batchId;

  const DeleteBatchUsecaseParams({required this.batchId});

  @override
  List<Object?> get props => [batchId];
}

// NOTE: Dependency Injection using Provider
final deleteBatchUsecaseProvider = Provider<DeleteBatchUsecase>((ref) {
  return DeleteBatchUsecase(batchRepository: ref.read(batchRepositoryProvider));
});

class DeleteBatchUsecase
    implements UseCaseWithParams<bool, DeleteBatchUsecaseParams> {
  final IBatchRepository _batchRepository;

  DeleteBatchUsecase({required IBatchRepository batchRepository})
    : _batchRepository = batchRepository;

  @override
  Future<Either<Failure, bool>> call(DeleteBatchUsecaseParams params) {
    return _batchRepository.deleteBatch(params.batchId);
  }
}
