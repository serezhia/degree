import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/bootstrap.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
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
