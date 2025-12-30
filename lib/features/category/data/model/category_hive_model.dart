import 'package:hive/hive.dart';
import 'package:lost_n_found/core/constants/hive_table_constant.dart';
import 'package:lost_n_found/features/category/domain/entities/category_entity.dart';
import 'package:uuid/uuid.dart';

part "category_hive_model.g.dart";

@HiveType(typeId: HiveTableConstant.categoryTypeId)
class CategoryHiveModel extends HiveObject {
  @HiveField(0)
  final String? categoryId;

  @HiveField(1)
  final String categoryName;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? status;

  CategoryHiveModel({
    String? categoryId,
    required this.categoryName,
    String? description,
    String? status,
  }) : categoryId = categoryId ?? Uuid().v4(),
       description = description ?? "description",
       status = status ?? "active";

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      categoryName: categoryName,
      description: description,
      status: status,
    );
  }

  factory CategoryHiveModel.fromEntity(CategoryEntity entity) {
    return CategoryHiveModel(categoryName: entity.categoryName);
  }

  static List<CategoryEntity> toEntityList(List<CategoryHiveModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
