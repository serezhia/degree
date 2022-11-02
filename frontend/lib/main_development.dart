import 'package:degree_app/app/app.dart';
import 'package:degree_app/auth/data/mock_auth_repository.dart';
import 'package:degree_app/bootstrap.dart';
import 'package:flutter/material.dart';

void main() {
  const host = 'https://degree.serezhia.ru';

  bootstrap(
    () => App(
      authRepository: MockAuthRepository(),
      url: host,
    ),
  );
}
