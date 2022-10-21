import 'dart:math';

String generateRegisterCode() {
  final random = Random.secure();
  final values = List<int>.generate(9, (i) => random.nextInt(10));
  return values.join();
}
