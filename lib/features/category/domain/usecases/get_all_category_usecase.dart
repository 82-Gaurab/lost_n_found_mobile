import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/category/domain/repository/category_repository.dart';

class GetAllCategoryUsecase implements UseCaseWithoutParams {
  ICategoryRepository _categoryRepository;

  GetAllCategoryUsecase({required ICategoryRepository categoryRepository})
    : _categoryRepository = categoryRepository;

  @override
  Future<Either<Failure, dynamic>> call() {
    return _categoryRepository.getAllCategories();
  }
}
