import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/api/api_client.dart';
import 'package:lost_n_found/features/batch/data/datasources/batch_datasource.dart';
import 'package:lost_n_found/features/batch/data/models/batch_api_model.dart';

final batchRemoteProvider = Provider<IBatchRemoteDatasource>((ref) {
  return BatchRemoteDatasource(apiClient: ref.read(apiClientProvider));
});

class BatchRemoteDatasource implements IBatchRemoteDatasource {
  final ApiClient _apiClient;

  BatchRemoteDatasource({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<bool> createBatch(BatchApiModel batch) {
    // TODO: implement createBatch
    throw UnimplementedError();
  }

  @override
  Future<List<BatchApiModel>> getAllBatches() {
    // TODO: implement getAllBatches
    throw UnimplementedError();
  }

  @override
  Future<BatchApiModel?> getBatchById(String batchId) {
    // TODO: implement getBatchById
    throw UnimplementedError();
  }

  @override
  Future<bool> updateBatch(BatchApiModel batch) {
    // TODO: implement updateBatch
    throw UnimplementedError();
  }
}
