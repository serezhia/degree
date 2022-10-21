import 'package:auth_service/auth_service.dart';

String generateAccessToken(int subjectId, Role role) {
  final jwt = JWT(
    {'iat': DateTime.now(), 'role': role.toString()},
    issuer: 'degree_auth',
    subject: subjectId.toString(),
  );
  return jwt.sign(SecretKey(secretKey()), expiresIn: Duration(minutes: 15));
}

String generateRefreshToken(int subjectId) {
  final jwt = JWT(
    {
      'iat': DateTime.now(),
    },
    issuer: 'degree_auth_refresh',
    subject: subjectId.toString(),
  );
  return jwt.sign(SecretKey(secretKey()),
      expiresIn: Duration(minutes: expiredTimeRefreshToken()));
}

dynamic verifyToken(String token, {bool isRefreshToken = false}) {
  if (isRefreshToken == false) {
    try {
      return JWT.verify(
        token,
        SecretKey(secretKey()),
      );
    } on JWTExpiredError {
      return false;
    } on JWTError catch (_) {
      print(_);
      return false;
    }
  } else {
    return JWT.verify(token, SecretKey(secretKey()),
        issuer: 'degree_auth_refresh');
  }
}
