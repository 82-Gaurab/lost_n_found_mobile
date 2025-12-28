import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';

// For Use case with params
abstract interface class UseCaseWithParams<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

// For Use case without parameters like getAllBatch();
abstract interface class UseCaseWithoutParams<SuccessType> {
  Future<Either<Failure, SuccessType>> call();
}
