import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/category/domain/entities/category_entity.dart';
import 'package:lost_n_found/features/category/domain/repository/category_repository.dart';

class UpdateCategoryUsecaseParams extends Equatable {
  final String categoryId;
  final String categoryName;
  final String? description;
  final String? status;

  const UpdateCategoryUsecaseParams({
    required this.categoryId,
    required this.categoryName,
    this.description,
    this.status,
  });

  @override
  List<Object?> get props => [categoryId, categoryName, description, status];
}

class UpdateCategoryUsecase
    implements UseCaseWithParams<void, UpdateCategoryUsecaseParams> {
  final ICategoryRepository _categoryRepository;

  UpdateCategoryUsecase(this._categoryRepository);

  @override
  Future<Either<Failure, void>> call(UpdateCategoryUsecaseParams params) {
    final category = CategoryEntity(
      categoryId: params.categoryId,
      categoryName: params.categoryName,
      description: params.description,
      status: params.status,
    );
    return _categoryRepository.updateCategory(category);
  }
}
