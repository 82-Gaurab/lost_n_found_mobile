import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/item/data/repositories/item_repository.dart';
import 'package:lost_n_found/features/item/domain/repositories/item_repository.dart';

class UploadImageUsecaseParams extends Equatable {
  final File image;
  const UploadImageUsecaseParams({required this.image});
  @override
  List<Object?> get props => [image];
}

final uploadImageUsecaseProvider = Provider<UploadImageUsecase>((ref) {
  final itemRepository = ref.read(itemRepositoryProvider);
  return UploadImageUsecase(iItemRepository: itemRepository);
});

class UploadImageUsecase
    implements UseCaseWithParams<String, UploadImageUsecaseParams> {
  final IItemRepository _iItemRepository;
  UploadImageUsecase({required IItemRepository iItemRepository})
    : _iItemRepository = iItemRepository;

  @override
  Future<Either<Failure, String>> call(UploadImageUsecaseParams params) {
    return _iItemRepository.uploadImage(params.image);
  }
}
