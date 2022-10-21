import 'package:schedule_service/schedule_service.dart';

final env = DotEnv(includePlatformEnvironment: true)..load(['../.env']);

final String nameService = 'SCHEDULE';
String secretKey() {
  if (env['SECRET_KEY'] == null) {
    return Platform.environment['SECRET_KEY'] ?? 'secret';
  } else {
    return env['SECRET_KEY']!;
  }
}

int servicePort() {
  if (env['${nameService}_SERVICE_PORT'] == null) {
    return int.parse(
        Platform.environment['${nameService}_SERVICE_PORT'] ?? '2010');
  } else {
    return int.parse(env['${nameService}_SERVICE_PORT']!);
  }
}

String serviceHost() {
  if (env['${nameService}_SERVICE_HOST'] == null) {
    return Platform.environment['${nameService}_SERVICE_HOST'] ?? '0.0.0.0';
  } else {
    return env['${nameService}_SERVICE_HOST']!;
  }
}

int dbPort() {
  if (env['${nameService}_DATABASE_PORT'] == null) {
    return int.parse(Platform.environment['SCHEDULE_DATABASE_PORT'] ?? '2011');
  } else {
    return int.parse(env['${nameService}_DATABASE_PORT']!);
  }
}

String dbHost() {
  if (env['${nameService}_DATABASE_HOST'] == null) {
    return Platform.environment['${nameService}_DATABASE_HOST'] ?? 'localhost';
  } else {
    return env['${nameService}_DATABASE_HOST']!;
  }
}

String dbName() {
  if (env['${nameService}_DATABASE_NAME'] == null) {
    return Platform.environment['${nameService}_DATABASE_NAME'] ??
        'schedule_db';
  } else {
    return env['${nameService}_DATABASE_NAME']!;
  }
}

String dbUsername() {
  if (env['${nameService}_DATABASE_USERNAME'] == null) {
    return Platform.environment['${nameService}_DATABASE_USERNAME'] ?? 'admin';
  } else {
    return env['${nameService}_DATABASE_USERNAME']!;
  }
}

String dbPassword() {
  if (env['${nameService}_DATABASE_PASSWORD'] == null) {
    return Platform.environment['${nameService}_DATABASE_PASSWORD'] ?? 'pass';
  } else {
    return env['${nameService}_DATABASE_PASSWORD']!;
  }
}

String authServiceHost() {
  if (env['AUTH_SERVICE_HOST'] == null) {
    return Platform.environment['AUTH_SERVICE_HOST'] ?? '0.0.0.0';
  } else {
    return env['AUTH_SERVICE_HOST']!;
  }
}

int authServicePort() {
  if (env['AUTH_SERVICE_PORT'] == null) {
    return int.parse(Platform.environment['AUTH_SERVICE_PORT'] ?? '2000');
  } else {
    return int.parse(env['AUTH_SERVICE_PORT']!);
  }
}
