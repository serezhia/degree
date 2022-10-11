import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

String createSalt() {
  final rand = Random.secure();
  final saltBytesBase = List<int>.generate(32, (_) => rand.nextInt(256));
  final salt = base64.encode(saltBytesBase);

  return salt.toString();
}

String createHashedPassword(String password, String salt) {
  final codec = Utf8Codec();
  final key = codec.encode(password);
  final saltBytes = codec.encode(salt);
  final hmac = Hmac(sha256, key);
  return hmac.convert(saltBytes).toString();
}
