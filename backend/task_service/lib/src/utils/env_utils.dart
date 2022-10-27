import 'package:task_service/task_service.dart';

final env = DotEnv(includePlatformEnvironment: true)..load(['../.env']);

final String nameService = 'TASK';
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
        Platform.environment['${nameService}_SERVICE_PORT'] ?? '2020');
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
    return int.parse(Platform.environment['SCHEDULE_DATABASE_PORT'] ?? '2021');
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

String scheduleDbHost() {
  if (env['SCHEDULE_DATABASE_HOST'] == null) {
    return Platform.environment['SCHEDULE_DATABASE_HOST'] ?? 'localhost';
  } else {
    return env['SCHEDULE_DATABASE_HOST']!;
  }
}

int scheduleDbPort() {
  if (env['SCHEDULE_DATABASE_PORT'] == null) {
    return int.parse(Platform.environment['SCHEDULE_DATABASE_PORT'] ?? '2021');
  } else {
    return int.parse(env['SCHEDULE_DATABASE_PORT']!);
  }
}

String scheduleDbName() {
  if (env['SCHEDULE_DATABASE_NAME'] == null) {
    return Platform.environment['SCHEDULE_DATABASE_NAME'] ?? 'schedule_db';
  } else {
    return env['SCHEDULE_DATABASE_NAME']!;
  }
}

String scheduleDbUsername() {
  if (env['SCHEDULE_DATABASE_USERNAME'] == null) {
    return Platform.environment['SCHEDULE_DATABASE_USERNAME'] ?? 'admin';
  } else {
    return env['SCHEDULE_DATABASE_USERNAME']!;
  }
}

String scheduleDbPassword() {
  if (env['SCHEDULE_DATABASE_PASSWORD'] == null) {
    return Platform.environment['SCHEDULE_DATABASE_PASSWORD'] ?? 'pass';
  } else {
    return env['SCHEDULE_DATABASE_PASSWORD']!;
  }
}
