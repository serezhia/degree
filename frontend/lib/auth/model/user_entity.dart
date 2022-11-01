import 'package:degree_app/auth/auth.dart';

@immutable
class UserEntity {
  const UserEntity({
    required this.id,
    required this.username,
    required this.role,
  });

  final int id;
  final String username;
  final String role;
}
