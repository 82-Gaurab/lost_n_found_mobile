import 'package:hive/hive.dart';
import 'package:lost_n_found/core/constants/hive_table_constant.dart';
import 'package:lost_n_found/features/auth/domain/entities/auth_entity.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

// INFO: dart run build_runner build -d
@HiveType(typeId: HiveTableConstant.authTypeId)
class AuthHiveModel extends HiveObject {
  @HiveField(0)
  final String? authId;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? batchId;

  @HiveField(4)
  final String username;

  @HiveField(5)
  final String? password;

  @HiveField(6)
  final String? profilePicture;

  @HiveField(7)
  final String? phoneNumber;

  AuthHiveModel({
    String? authId,
    required this.fullName,
    required this.email,
    this.batchId,
    required this.username,
    this.password,
    this.profilePicture,
    this.phoneNumber,
  }) : authId = authId ?? Uuid().v4();

  // INFO: TO Entity

  AuthEntity toEntity({BatchEntity? batchEntity}) {
    return AuthEntity(
      authId: authId,
      fullName: fullName,
      email: email,
      username: username,
      password: password,
      phoneNumber: phoneNumber,
      profilePicture: profilePicture,
      batch: batchEntity,
    );
  }

  // INFO: TO Entity List
  static List<AuthEntity> toEntityList(List<AuthHiveModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  // INFO: FROM Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      authId: entity.authId,
      fullName: entity.fullName,
      email: entity.email,
      batchId: entity.batchId,
      username: entity.username,
      password: entity.password,
      profilePicture: entity.profilePicture,
      phoneNumber: entity.phoneNumber,
    );
  }
}
