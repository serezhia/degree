import 'package:schedule_service/schedule_service.dart';

String generateAccessToken(int subjectId) {
  final jwt = JWT(
    {
      'iat': DateTime.now(),
    },
    issuer: 'degree_auth',
    subject: subjectId.toString(),
  );
  return jwt.sign(SecretKey(env['SECRET_KEY'] ?? 'secret'),
      expiresIn: Duration(days: 30));
}

String generateRefreshToken(int subjectId) {
  final jwt = JWT(
    {
      'iat': DateTime.now(),
    },
    issuer: 'degree_auth_refresh',
    subject: subjectId.toString(),
  );
  return jwt.sign(SecretKey(env['SECRET_KEY'] ?? 'secret'),
      expiresIn: Duration(minutes: 15));
}

dynamic verifyToken(String token, {bool isRefreshToken = false}) {
  if (isRefreshToken == false) {
    try {
      return JWT.verify(
        token,
        SecretKey(env['SECRET_KEY'] ?? 'secret'),
      );
    } on JWTExpiredError {
      return false;
    } on JWTError catch (_) {
      print(_);
      return false;
    }
  } else {
    return JWT.verify(token, SecretKey(env['SECRET_KEY'] ?? 'secret'),
        issuer: 'degree_auth_refresh');
  }
}
