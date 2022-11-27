// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:degree_app/admin_groups/src/model/speciality_model.dart';
import 'package:degree_app/admin_groups/src/repository/speciality_repository.dart';
import 'package:degree_app/dio_singletone.dart';

class MainSpecialityRepository implements SpecialityRepository {
  @override
  Future<Speciality> createSpeciality(String name) async {
    try {
      final response = await DioSingletone.dioMain.post<dynamic>(
        'schedule/spetialties',
        queryParameters: <String, dynamic>{
          'name': name,
        },
      );
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      return Speciality(
        name: data['Speciality']!['name'] as String,
        id: data['Speciality']!['id'] as int,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteSpeciality(int id) async {
    try {
      await DioSingletone.dioMain.delete<dynamic>(
        'schedule/spetialties/$id',
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Speciality>> getSpecialitiesList() async {
    try {
      final response =
          await DioSingletone.dioMain.get<dynamic>('schedule/spetialties');
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      final specialities = <Speciality>[];
      for (final speciality in data['specialitys'] as List<dynamic>) {
        specialities.add(
          Speciality(
            name: speciality['name'] as String,
            id: speciality['id'] as int,
          ),
        );
      }

      return specialities;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Speciality> getSpeciality(int id) async {
    try {
      final response = await DioSingletone.dioMain.get<dynamic>(
        'schedule/spetialties/$id',
      );
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      return Speciality(
        name: data['Speciality']!['name'] as String,
        id: data['Speciality']!['id'] as int,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
