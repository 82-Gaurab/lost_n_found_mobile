import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:lost_n_found/core/constants/hive_table_constant.dart';
import 'package:lost_n_found/features/auth/data/models/auth_hive_model.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';
import 'package:lost_n_found/features/category/data/models/category_hive_model.dart';
import 'package:lost_n_found/features/item/data/models/item_hive_model.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});

class HiveService {
  // Initialize Hive

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${HiveTableConstant.dbName}';

    Hive.init(path);
    _registerAdapters();
    await _openBoxes();
    await insertBatchDummyData();
    await insertCategoryDummyData();
  }

  Future<void> insertBatchDummyData() async {
    final batchBox = Hive.box<BatchHiveModel>(HiveTableConstant.batchTable);

    if (batchBox.isNotEmpty) {
      return;
    }

    final dummyBatches = [
      BatchHiveModel(batchName: '35A'),
      BatchHiveModel(batchName: '35B'),
      BatchHiveModel(batchName: '35C'),
      BatchHiveModel(batchName: '36A'),
      BatchHiveModel(batchName: '36B'),
      BatchHiveModel(batchName: '37A'),
      BatchHiveModel(batchName: '38B'),
    ];

    for (var batch in dummyBatches) {
      await batchBox.put(batch.batchId, batch);
    }
  }

  Future<void> insertCategoryDummyData() async {
    final categoryBox = Hive.box<CategoryHiveModel>(
      HiveTableConstant.categoryTable,
    );

    if (categoryBox.isNotEmpty) {
      return;
    }

    final dummyCategories = [
      CategoryHiveModel(
        name: 'Electronics',
        description: 'Phones, laptops, tablets, etc.',
      ),
      CategoryHiveModel(name: 'Personal', description: 'Personal belongings'),
      CategoryHiveModel(
        name: 'Accessories',
        description: 'Watches, jewelry, etc.',
      ),
      CategoryHiveModel(
        name: 'Documents',
        description: 'IDs, certificates, papers',
      ),
      CategoryHiveModel(
        name: 'Keys',
        description: 'House keys, car keys, etc.',
      ),
      CategoryHiveModel(
        name: 'Bags',
        description: 'Backpacks, handbags, wallets',
      ),
      CategoryHiveModel(name: 'Other', description: 'Miscellaneous items'),
    ];

    for (var category in dummyCategories) {
      await categoryBox.put(category.categoryId, category);
    }
  }

  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveTableConstant.batchTypeId)) {
      Hive.registerAdapter(BatchHiveModelAdapter());
    }

    // category register
    if (!Hive.isAdapterRegistered(HiveTableConstant.categoryTypeId)) {
      Hive.registerAdapter(CategoryHiveModelAdapter());
    }

    // auth register
    if (!Hive.isAdapterRegistered(HiveTableConstant.authTypeId)) {
      Hive.registerAdapter(AuthHiveModelAdapter());
    }
  }

  // Open all boxes
  Future<void> _openBoxes() async {
    await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchTable);
    await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryTable);
    await Hive.openBox<AuthHiveModel>(HiveTableConstant.authTable);
  }

  // CLose all boxes
  Future<void> close() async {
    await Hive.close();
  }

  // Hack: =================== Batch CRUD Operations ===========================

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

  // Hack: =================== Category CRUD Operations ===========================
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

  // Hack: =================== Auth CRUD Operations ===========================
  Box<AuthHiveModel> get _authBox =>
      Hive.box<AuthHiveModel>(HiveTableConstant.authTable);

  // register user
  Future<AuthHiveModel> registerUser(AuthHiveModel model) async {
    await _authBox.put(model.authId, model);
    return model;
  }

  // login
  Future<AuthHiveModel?> loginUser(String email, String password) async {
    final user = _authBox.values.where(
      (user) => user.email == email && user.password == password,
    );

    if (user.isNotEmpty) return user.first;
    return null;
  }

  // logout
  Future<void> logoutUser() async {}

  // get current user
  AuthHiveModel? getCurrentUser(String authId) {
    return _authBox.get(authId);
  }

  // is email exists
  Future<bool> isEmailExists(String email) async {
    final users = _authBox.values.where((user) => user.email == email);
    return users.isNotEmpty;
  }

  //hack: ======================= Item Queries =========================

  Box<ItemHiveModel> get _itemBox =>
      Hive.box<ItemHiveModel>(HiveTableConstant.itemTable);

  Future<ItemHiveModel> createItem(ItemHiveModel item) async {
    await _itemBox.put(item.itemId, item);
    return item;
  }

  List<ItemHiveModel> getAllItems() {
    return _itemBox.values.toList();
  }

  ItemHiveModel? getItemById(String itemId) {
    return _itemBox.get(itemId);
  }

  List<ItemHiveModel> getItemsByUser(String userId) {
    return _itemBox.values.where((item) => item.reportedBy == userId).toList();
  }

  List<ItemHiveModel> getLostItems() {
    return _itemBox.values.where((item) => item.type == 'lost').toList();
  }

  List<ItemHiveModel> getFoundItems() {
    return _itemBox.values.where((item) => item.type == 'found').toList();
  }

  List<ItemHiveModel> getItemsByCategory(String categoryId) {
    return _itemBox.values
        .where((item) => item.categoryId == categoryId)
        .toList();
  }

  Future<bool> updateItem(ItemHiveModel item) async {
    if (_itemBox.containsKey(item.itemId)) {
      await _itemBox.put(item.itemId, item);
      return true;
    }
    return false;
  }

  Future<void> deleteItem(String itemId) async {
    await _itemBox.delete(itemId);
  }
}
