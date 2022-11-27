import 'package:degree_app/app/view/app.dart';
import 'package:degree_app/auth/data/main_auth_repository.dart';
import 'package:degree_app/bootstrap.dart';
import 'package:degree_app/dio_singletone.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

const host = 'serezhia.ru';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  const secureStorage = FlutterSecureStorage();
  if (kIsWeb) {
    DioSingletone.dioMain.options.baseUrl = 'https://degree.$host/api/';
  } else if (await secureStorage.read(key: 'url') != null) {
    DioSingletone.dioMain.options.baseUrl =
        'https://degree.${await secureStorage.read(key: 'url')}/api/';
  }

  await DioSingletone.addAccessTokenInterceptor();
  await bootstrap(
    () => App(
      authRepository: MainAuthRepository(),
      url: host,
    ),
    storage,
  );
}
