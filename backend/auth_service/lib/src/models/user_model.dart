import 'package:auth_service/src/models/token_model.dart';

class User {
  final int id;
  final String firstName;
  final String secondName;
  final String? middleName;
  final String? username;
  final String? hashedPassword;
  final String? salt;
  final Role role;
  final String? registerCode;
  final List<Token>? refreshTokens;

  User(
      {required this.id,
      required this.firstName,
      required this.secondName,
      required this.middleName,
      this.username,
      this.hashedPassword,
      this.salt,
      required this.role,
      required this.registerCode,
      this.refreshTokens});
}

enum Role {
  admin,
  teacher,
  student,
}
