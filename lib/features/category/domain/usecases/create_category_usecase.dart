import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/category/domain/entities/category_entity.dart';
import 'package:lost_n_found/features/category/domain/repository/category_repository.dart';

class CreateCategoryUsecaseParams extends Equatable {
  final String categoryName;

  const CreateCategoryUsecaseParams({required this.categoryName});

  @override
  List<Object?> get props => [categoryName];
}

class CreateCategoryUsecase
    implements UseCaseWithParams<void, CreateCategoryUsecaseParams> {
  final ICategoryRepository _categoryRepository;
  CreateCategoryUsecase(this._categoryRepository);

  @override
  Future<Either<Failure, void>> call(CreateCategoryUsecaseParams params) {
    final category = CategoryEntity(categoryName: params.categoryName);
    return _categoryRepository.createCategory(category);
  }
}
