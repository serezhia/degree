import 'package:degree_app/app/view/app.dart';
import 'package:degree_app/auth/data/mock_auth_repository.dart';
import 'package:degree_app/bootstrap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  const host = 'serezhia.ru';
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
