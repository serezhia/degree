import 'package:degree_app/app/ui/main_app_builder.dart';
import 'package:degree_app/app/ui/main_app_runner.dart';

void main() {
  const env = String.fromEnvironment('env', defaultValue: 'test');
  const runner = MainAppRunner(env);
  final builder = MainAppBuilder();
  runner.run(builder);
}
