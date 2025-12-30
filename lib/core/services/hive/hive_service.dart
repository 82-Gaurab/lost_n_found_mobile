import 'package:hive/hive.dart';
import 'package:lost_n_found/core/constants/hive_table_constant.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';
import 'package:lost_n_found/features/category/data/model/category_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  // Initialize Hive

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${HiveTableConstant.dbName}';

    Hive.init(path);
    _registerAdapters();
    await _openBoxes();
  }

  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveTableConstant.batchTypeId)) {
      Hive.registerAdapter(BatchHiveModelAdapter());
    }
  }

  // Open all boxes
  Future<void> _openBoxes() async {
    await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchTable);
  }

  // CLose all boxes
  Future<void> close() async {
    await Hive.close();
  }

  // =================== Batch CRUD Operations ===========================

  // Get batch box
  Box<BatchHiveModel> get _batchBox =>
      Hive.box<BatchHiveModel>(HiveTableConstant.batchTable);

  // Create a new batch
  Future<BatchHiveModel> createBatch(BatchHiveModel batch) async {
    await _batchBox.put(batch.batchId, batch);
    return batch;
  }

  // Get all batches
  List<BatchHiveModel> getAllBatches() {
    return _batchBox.values.toList();
  }

  // Get batch by ID
  BatchHiveModel? getBatchById(String batchId) {
    return _batchBox.get(batchId);
  }

  // Update a batch
  Future<void> updateBatch(BatchHiveModel batch) async {
    await _batchBox.put(batch.batchId, batch);
  }

  // Delete a batch
  Future<void> deleteBatch(String batchId) async {
    await _batchBox.delete(batchId);
  }

  // Delete all batches
  Future<void> deleteAllBatches() async {
    await _batchBox.clear();
  }

  // =================== Category CRUD Operations ===========================
  Box<CategoryHiveModel> get _categoryBox =>
      Hive.box<CategoryHiveModel>(HiveTableConstant.categoryTable);

  // get all category
  List<CategoryHiveModel> getAllCategories() {
    return _categoryBox.values.toList();
  }

  // get category by ID
  CategoryHiveModel? getCategoryById(String categoryId) {
    return _categoryBox.get(categoryId);
  }

  // create category
  Future<CategoryHiveModel> createCategory(CategoryHiveModel category) async {
    await _categoryBox.put(category.categoryId, category);
    return category;
  }

  // update category
  Future<void> updateCategory(CategoryHiveModel category) async {
    await _categoryBox.put(category.categoryId, category);
  }

  // delete category
  Future<void> deleteCategory(String categoryId) async {
    await _categoryBox.delete(categoryId);
  }

  // delete All category
  Future<void> deleteAllCategory() async {
    await _categoryBox.clear();
  }
}
