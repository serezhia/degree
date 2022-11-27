// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer';

import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/dio_singletone.dart';

import 'package:dio/dio.dart';

class MainAuthRepository implements AuthRepository {
  @override
  Future<bool> checkRegisterCode({required String registerCode}) async {
    try {
      await DioSingletone.dioMain.get<dynamic>(
        'auth/users/codeIsAlive/$registerCode',
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> hostIsAlive({required String url}) async {
    try {
      final dio = await Dio().post<dynamic>(
        'https://degree.$url/api/auth/tokens',
        options: Options(
          validateStatus: (status) => true,
        ),
      );
      if (dio.statusCode == 400) {
        DioSingletone.dioMain.options.baseUrl = 'https://degree.$url/api/';

        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<void> refreshToken({required String refreshToken}) async {}

  @override
  Future<UserEntity> signIn({
    required String username,
    required String password,
  }) async {
    final response = await DioSingletone.dioMain.post<String>(
      'auth/tokens',
      queryParameters: <String, dynamic>{
        'username': username,
        'password': password,
      },
    );

    final data = jsonDecode(response.data!) as Map<String, dynamic>;
    return UserEntity(
      id: data['user']!['id'] as int,
      username: username,
      role: data['user']!['role'] as String,
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }

  @override
  Future<void> signOut({required String refreshToken}) async {
    if (refreshToken != '') {
      await DioSingletone.dioMain.delete<dynamic>(
        'auth/tokens',
        queryParameters: <String, dynamic>{
          'refresh_token': refreshToken,
        },
      );
    }
  }

  @override
  Future<UserEntity> signUp({
    required String username,
    required String password,
    required String registerCode,
  }) async {
    await DioSingletone.dioMain.post<String>(
      'auth/users/$registerCode',
      queryParameters: <String, dynamic>{
        'username': username,
        'password': password,
      },
    );

    final response = await DioSingletone.dioMain.post<String>(
      'auth/tokens',
      queryParameters: <String, dynamic>{
        'username': username,
        'password': password,
      },
    );

    final data = jsonDecode(response.data!) as Map<String, dynamic>;
    return UserEntity(
      id: data['user']!['id'] as int,
      username: username,
      role: data['user']!['role'] as String,
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }
}
