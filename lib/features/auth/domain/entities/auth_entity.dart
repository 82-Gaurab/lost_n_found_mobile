import 'package:equatable/equatable.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';

class AuthEntity extends Equatable {
  final String? authId;
  final String fullName;
  final String email;
  final String? batchId;
  final String username;
  final String? password;
  final String? profilePicture;
  final String? phoneNumber;
  final BatchEntity? batch;

  const AuthEntity({
    this.authId,
    required this.fullName,
    required this.email,
    this.batchId,
    required this.username,
    this.password,
    this.profilePicture,
    this.phoneNumber,
    this.batch,
  });

  @override
  List<Object?> get props => [
    authId,
    fullName,
    email,
    batchId,
    username,
    password,
    phoneNumber,
    profilePicture,
    batch,
  ];
}
