import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/api/api_client.dart';
import 'package:lost_n_found/core/api/api_endpoints.dart';
import 'package:lost_n_found/features/batch/data/datasources/batch_datasource.dart';
import 'package:lost_n_found/features/batch/data/models/batch_api_model.dart';

final batchRemoteDatasourceProvider = Provider<IBatchRemoteDatasource>((ref) {
  return BatchRemoteDatasource(apiClient: ref.read(apiClientProvider));
});

class BatchRemoteDatasource implements IBatchRemoteDatasource {
  final ApiClient _apiClient;

  BatchRemoteDatasource({required ApiClient apiClient})
    : _apiClient = apiClient;

  // Note: entity -> api model -> json : to json   -> yo conversion yata bata patauda kheri garene ho jun repo le garxa
  @override
  Future<bool> createBatch(BatchApiModel batch) async {
    final response = await _apiClient.post(ApiEndpoints.batches);
    return response.data["success"] == true;
  }

  @override
  Future<List<BatchApiModel>> getAllBatches() async {
    final response = await _apiClient.get(ApiEndpoints.batches);
    final data = response.data["data"] as List;

    // Note: json -> api model -> entity : from json
    return data.map((json) => BatchApiModel.fromEntity(json)).toList();
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
