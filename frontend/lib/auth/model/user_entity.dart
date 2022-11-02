import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.username,
    required this.role,
    this.accessToken,
    this.refreshToken,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  final int id;
  final String username;
  final String role;
  final String? refreshToken;
  final String? accessToken;

  @override
  List<Object?> get props => [id, username, role, refreshToken, accessToken];

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
