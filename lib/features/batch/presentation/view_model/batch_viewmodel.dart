import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/features/batch/domain/usecases/create_batch_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/delete_batch_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/get_all_batch_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/update_batch_usecase.dart';
import 'package:lost_n_found/features/batch/presentation/states/batch_state.dart';

class BatchViewmodel extends Notifier<BatchState> {
  late final GetAllBatchUsecase _getAllBatchUsecase;
  late final CreateBatchUsecase _createBatchUsecase;
  late final UpdateBatchUsecase _updateBatchUsecase;
  late final DeleteBatchUsecase _deleteBatchUsecase;

  @override
  BatchState build() {
    // Initialize the usecases here using ref, which we will do later
    return const BatchState();
  }

  Future<void> getAllBatches() async {
    state = state.copyWith(status: BatchStatus.loading);

    final result = await _getAllBatchUsecase();

    result.fold(
      (failure) => state = state.copyWith(
        status: BatchStatus.error,
        errorMessage: failure.message,
      ),
      (batches) => state.copyWith(status: BatchStatus.loaded, batches: batches),
    );
  }

  Future<void> createBatch(String batchName) async {
    state = state.copyWith(status: BatchStatus.loading);

    final result = await _createBatchUsecase(
      CreateBatchUsecaseParams(batchName: batchName),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: BatchStatus.error,
        errorMessage: failure.message,
      ),
      (success) => state = state.copyWith(status: BatchStatus.loaded),
    );
  }

  Future<void> updateBatch(String batchId, String batchName) async {
    state = state.copyWith(status: BatchStatus.loading);

    final result = await _updateBatchUsecase(
      UpdateBatchUsecaseParams(batchId: batchId, batchName: batchName),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: BatchStatus.error,
        errorMessage: failure.message,
      ),
      (success) => state = state.copyWith(status: BatchStatus.updated),
    );
  }

  Future<void> deleteBatch(String batchId) async {
    state = state.copyWith(status: BatchStatus.loading);

    final result = await _deleteBatchUsecase(
      DeleteBatchUsecaseParams(batchId: batchId),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: BatchStatus.error,
        errorMessage: failure.message,
      ),
      (success) => state = state.copyWith(status: BatchStatus.deleted),
    );
  }
}
