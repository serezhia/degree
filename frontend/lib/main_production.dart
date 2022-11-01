import 'package:degree_app/app/app.dart';
import 'package:degree_app/auth/data/mock_auth_repository.dart';
import 'package:degree_app/bootstrap.dart';

void main() {
  bootstrap(
    () => App(
      authRepository: MockAuthRepository(),
    ),
  );
}
