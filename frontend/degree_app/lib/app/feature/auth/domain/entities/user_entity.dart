import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String role,
    required String username,
    String? accessToken,
    String? refreshToken,
  }) = _UserEntity;
}
