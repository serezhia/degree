import 'package:dio/dio.dart';

class DioContainer {
  late final Dio dio;
  final String baseUrl;

  DioContainer({required this.baseUrl}) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 15000,
      receiveTimeout: 15000,
    );

    dio = Dio(options);
  }

  void addInterceptor(Interceptor interceptor) {
    removeInterceptor(interceptor.runtimeType);
    dio.interceptors.add(interceptor);
  }

  void removeInterceptor(Type type) {
    dio.interceptors.removeWhere((element) => element.runtimeType == type);
  }
}
