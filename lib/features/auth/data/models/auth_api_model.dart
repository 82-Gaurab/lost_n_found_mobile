import 'package:lost_n_found/features/auth/domain/entities/auth_entity.dart';
import 'package:lost_n_found/features/batch/data/models/batch_api_model.dart';

class AuthApiModel {
  final String? authId;
  final String fullName;
  final String email;
  final String username;
  final String? password;
  final String? batchId;
  final String? phoneNumber;
  final String? profilePicture;
  final BatchApiModel? batch;

  AuthApiModel({
    this.authId,
    required this.fullName,
    required this.email,
    required this.username,
    this.password,
    this.batchId,
    this.phoneNumber,
    this.profilePicture,
    this.batch,
  });

  // info: To JSON
  Map<String, dynamic> toJson() {
    return {
      "name": fullName,
      "email": email,
      "username": username,
      "phoneNumber": phoneNumber,
      "password": password,
      "batchId": batchId,
      "profilePicture": profilePicture,
    };
  }

  // info: from JSON
  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
      authId: json["_id"] as String,
      fullName: json["name"] as String,
      email: json["email"] as String,
      username: json["username"] as String,
      phoneNumber: json["phoneNumber"] as String?,
      batchId: json["batchId"] as String?,
      profilePicture: json["profilePicture"] as String?,
      batch: json['batch'] != null
          ? BatchApiModel.fromJson(json['batch'] as Map<String, dynamic>)
          : null,
    );
  }

  // info: to entity
  AuthEntity toEntity() {
    return AuthEntity(
      authId: authId,
      fullName: fullName,
      email: email,
      username: username,
      batchId: batchId,
      batch: batch?.toEntity(),
      phoneNumber: phoneNumber,
      profilePicture: profilePicture,
    );
  }

  // info: from entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      authId: entity.authId,
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
      username: entity.username,
      batchId: entity.batchId,
      phoneNumber: entity.phoneNumber,
      profilePicture: entity.profilePicture,
      batch: entity.batch != null
          ? BatchApiModel.fromEntity(entity.batch!)
          : null,
    );
  }

  // info: to entity list
  static List<AuthEntity> toEntityList(List<AuthApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
