import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/features/batch/data/datasources/batch_datasource.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

class BatchRepository implements IBatchRepository {
  final IBatchDatasource _datasource;

  BatchRepository({required IBatchDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Either<Failure, bool>> createBatch(BatchEntity batch) async {
    try {
      final model = BatchHiveModel.fromEntity(batch);
      final result = await _datasource.createBatch(model);
      if (result) {
        return const Right(true);
      }
      return const Left(
        LocalDatabaseFailure(message: "Failed to create batch"),
      );
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteBatch(BatchEntity batch) {
    // TODO: implement deleteBatch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() {
    // TODO: implement getAllBatches
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, BatchEntity>> getBatchById(String batchId) {
    // TODO: implement getBatchById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateBatch(BatchEntity batch) {
    // TODO: implement updateBatch
    throw UnimplementedError();
  }
}
