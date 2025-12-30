import 'package:either_dart/either.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/features/category/domain/entities/catergory_entity.dart';

abstract interface class ICategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategory();
}
