import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/features/category/data/datasource/category_datasource.dart';
import 'package:lost_n_found/features/category/data/model/category_hive_model.dart';
import 'package:lost_n_found/features/category/domain/entities/category_entity.dart';
import 'package:lost_n_found/features/category/domain/repository/category_repository.dart';

class CategoryRepository implements ICategoryRepository {
  final ICategoryDatasource _categoryDatasource;

  const CategoryRepository({required ICategoryDatasource categoryDatasource})
    : _categoryDatasource = categoryDatasource;

  @override
  Future<Either<Failure, bool>> createCategory(CategoryEntity category) async {
    try {
      final model = CategoryHiveModel.fromEntity(category);
      final result = await _categoryDatasource.createCategory(model);

      if (result) {
        return const Right(true);
      }

      return const Left(
        LocalDatabaseFailure(message: "Failed to create category"),
      );
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCategory(String categoryId) async {
    try {
      final result = await _categoryDatasource.deleteCategory(categoryId);

      if (result) {
        return Right(true);
      }

      return Left(LocalDatabaseFailure(message: "Failed to delete category"));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      final models = await _categoryDatasource.getAllCategory();
      final entities = CategoryHiveModel.toEntityList(models);
      return Right(entities);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryById(
    String categoryId,
  ) async {
    try {
      final model = await _categoryDatasource.getCategoryById(categoryId);
      if (model != null) {
        final entity = model.toEntity();
        return Right(entity);
      }
      return Left(LocalDatabaseFailure(message: "No such category exists"));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateCategory(CategoryEntity category) async {
    try {
      final model = CategoryHiveModel.fromEntity(category);
      final result = await _categoryDatasource.updateCategory(model);

      if (result) {
        return Right(true);
      }

      return Left(LocalDatabaseFailure(message: "Failed to update category"));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
