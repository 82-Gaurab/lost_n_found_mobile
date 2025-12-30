import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/features/category/domain/usecases/get_all_category_usecase.dart';
import 'package:lost_n_found/features/category/presentation/states/category_state.dart';

class CategoryViewmodel extends Notifier<CategoryState> {
  late final GetAllCategoryUsecase _getAllCategoryUsecase;

  @override
  CategoryState build() {
    return const CategoryState();
  }

  Future<void> getAllCategory() async {
    state = state.copyWith(status: CategoryStatus.loading);

    final result = await _getAllCategoryUsecase();

    result.fold(
      (failure) => state = state.copyWith(
        status: CategoryStatus.error,
        errorMessage: failure.message,
      ),
      (categories) => state = state.copyWith(
        status: CategoryStatus.loaded,
        categories: categories,
      ),
    );
  }
}
