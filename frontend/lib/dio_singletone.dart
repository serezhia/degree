// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: avoid_classes_with_only_static_members
class DioSingletone {
  static Dio dioMain = Dio();

  static Future<void> addAccessTokenInterceptor() async {
    dioMain.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.queryParameters.addAll(<String, String>{
            'access_token':
                (await const FlutterSecureStorage().read(key: 'accessToken')) ??
                    'nullAccessToken',
          });

          return handler.next(options);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) async {
          if (e.response?.statusCode == 401) {
            final oldRefreshToken =
                await const FlutterSecureStorage().read(key: 'refreshToken');
            final response = await dioMain.post<dynamic>(
              '/auth/tokens/refresh',
              queryParameters: <String, dynamic>{
                'refresh_token': oldRefreshToken,
              },
            );
            final data =
                jsonDecode(response.data as String) as Map<String, dynamic>;
            final accessToken = data['access_token'] as String;
            final refreshToken = data['refresh_token'] as String;
            await const FlutterSecureStorage()
                .write(key: 'refreshToken', value: refreshToken);
            await const FlutterSecureStorage()
                .write(key: 'accessToken', value: accessToken);

            final opts = Options(
              method: e.requestOptions.method,
              headers: e.requestOptions.headers,
            );
            final cloneReq = await dioMain.request<dynamic>(
              e.requestOptions.path,
              options: opts,
              data: e.requestOptions.data,
              queryParameters: e.requestOptions.queryParameters,
            );
            return handler.resolve(cloneReq);
          }
          return handler.next(e);
        },
      ),
    );
  }
}
