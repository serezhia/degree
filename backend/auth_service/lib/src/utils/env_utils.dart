import 'package:auth_service/auth_service.dart';

final env = DotEnv(includePlatformEnvironment: true)..load(['../../.env']);

int servicePort() {
  if (env['AUTH_SERVICE_PORT'] == null) {
    return int.parse(Platform.environment['AUTH_SERVICE_PORT'] ?? '2000');
  } else {
    return int.parse(env['AUTH_SERVICE_PORT']!);
  }
}

String serviceHost() {
  if (env['AUTH_SERVICE_HOST'] == null) {
    return Platform.environment['AUTH_SERVICE_HOST'] ?? 'localhost';
  } else {
    return env['AUTH_SERVICE_HOST']!;
  }
}

int dbPort() {
  if (env['AUTH_DATABASE_PORT'] == null) {
    return int.parse(Platform.environment['AUTH_DATABASE_PORT'] ?? '2001');
  } else {
    return int.parse(env['AUTH_DATABASE_PORT']!);
  }
}

String dbHost() {
  if (env['AUTH_DATABASE_HOST'] == null) {
    return Platform.environment['AUTH_DATABASE_HOST'] ?? 'localhost';
  } else {
    return env['AUTH_DATABASE_HOST']!;
  }
}

String dbName() {
  if (env['AUTH_DATABASE_NAME'] == null) {
    return Platform.environment['AUTH_DATABASE_NAME'] ?? 'auth_db';
  } else {
    return env['AUTH_DATABASE_NAME']!;
  }
}

String dbUsername() {
  if (env['AUTH_DATABASE_USERNAME'] == null) {
    return Platform.environment['AUTH_DATABASE_USERNAME'] ?? 'serezhia';
  } else {
    return env['AUTH_DATABASE_USERNAME']!;
  }
}

String dbPassword() {
  if (env['AUTH_DATABASE_PASSWORD'] == null) {
    return Platform.environment['AUTH_DATABASE_PASSWORD'] ?? 'pass';
  } else {
    return env['AUTH_DATABASE_PASSWORD']!;
  }
}
