import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/category/domain/repository/category_repository.dart';

class GetCategoryByIdUsecaseParams extends Equatable {
  final String categoryId;

  const GetCategoryByIdUsecaseParams({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

class GetCategoryByIdUsecase
    implements UseCaseWithParams<void, GetCategoryByIdUsecaseParams> {
  final ICategoryRepository _categoryRepository;

  GetCategoryByIdUsecase(this._categoryRepository);

  @override
  Future<Either<Failure, void>> call(GetCategoryByIdUsecaseParams params) {
    return _categoryRepository.getCategoryById(params.categoryId);
  }
}
