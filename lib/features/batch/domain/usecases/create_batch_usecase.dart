import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

class CreateBatchUsecaseParams extends Equatable {
  final String batchName;

  const CreateBatchUsecaseParams({required this.batchName});

  @override
  List<Object?> get props => [batchName];
}

class CreateBatchUsecase
    implements UseCaseWithParams<void, CreateBatchUsecaseParams> {
  final IBatchRepository _batchRepository;
  CreateBatchUsecase(this._batchRepository);

  @override
  Future<Either<Failure, void>> call(CreateBatchUsecaseParams params) {
    // Create a BatchEntity using the provided params
    final batch = BatchEntity(batchName: params.batchName);
    return _batchRepository.createBatch(batch);
  }
}
