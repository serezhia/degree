import 'package:degree_app/app/di/init_di.dart';
import 'package:degree_app/app/domain/app_builder.dart';
import 'package:degree_app/app/domain/app_runner.dart';
import 'package:flutter/widgets.dart';

class MainAppRunner implements AppRunner {
  final String env;

  const MainAppRunner(this.env);

  @override
  Future<void> preloadData() async {
    WidgetsFlutterBinding.ensureInitialized();

    // init app

    initDi(env);

    // init config
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    await preloadData();
    runApp(appBuilder.buildApp());
  }
}
