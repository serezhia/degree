abstract class User {
  final int? userId;
  final String firstName;
  final String secondName;
  final String? middleName;
  final int? registrationCode;

  User({
    required this.firstName,
    required this.secondName,
    this.userId,
    this.middleName,
    this.registrationCode,
  });
}
