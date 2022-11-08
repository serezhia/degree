import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver(this.logger);

  final Logger logger;

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    logger.i('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    logger.e('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  HydratedStorage storage,
) async {
  final logger = Logger();
  FlutterError.onError = (details) {
    logger.e(details.exceptionAsString(), null, details.stack);
  };

  Bloc.observer = AppBlocObserver(logger);

  await runZonedGuarded(
    () async => HydratedBlocOverrides.runZoned(
      () async {
        runApp(await builder());
      },
      storage: storage,
    ),
    (error, stackTrace) => logger.e(error.toString(), null, stackTrace),
  );
}
