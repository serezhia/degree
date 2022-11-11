import 'package:degree_app/admin_teachers/admin_teachers.dart';
import 'package:degree_app/app/view/app.dart';
import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/bootstrap.dart';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  for (var i = 0; i < 100; i++) {
    users.add(
      Teacher(
        userId: i,
        teacherId: i,
        firstName: firstNames[i % firstNames.length],
        secondName: secondNames[i % secondNames.length],
        middleName: middleNames[i % middleNames.length],
      ),
    );
  }
  users.sort((a, b) => a.secondName.compareTo(b.secondName));

  const host = kIsWeb ? 'serezhia.ru' : null;
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  await bootstrap(
    () => App(
      authRepository: MockAuthRepository(),
      url: host,
    ),
    storage,
  );
}
