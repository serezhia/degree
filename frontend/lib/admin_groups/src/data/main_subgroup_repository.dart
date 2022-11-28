// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:degree_app/admin_groups/src/model/subgroup_model.dart';
import 'package:degree_app/admin_groups/src/repository/subgroup_repository.dart';
import 'package:degree_app/dio_singletone.dart';

class MainSubgroupRepository implements SubgroupRepository {
  @override
  Future<List<Subgroup>> createSubgroups(
    String nameGroup,
    int numberSubgroups,
  ) async {
    try {
      final subgroups = <Subgroup>[];
      for (var i = 0; i < numberSubgroups; i++) {
        final response = await DioSingletone.dioMain.post<dynamic>(
          'schedule/subgroups',
          queryParameters: <String, dynamic>{
            'name': '$nameGroup/${i + 1}',
          },
        );
        final data =
            jsonDecode(response.data as String) as Map<String, dynamic>;
        subgroups.add(
          Subgroup(
            name: '$nameGroup/${i + 1}',
            id: data['subgroup']!['id'] as int,
          ),
        );
      }
      return subgroups;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteSubgroup(int id) {
    try {
      return DioSingletone.dioMain.delete<dynamic>(
        'schedule/subgroups/$id',
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Subgroup> getSubgroup(int id) async {
    try {
      final response = await DioSingletone.dioMain.get<dynamic>(
        'schedule/subgroups/$id',
      );
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;

      return Subgroup(
        name: data['subgroup']!['name'] as String,
        id: data['subgroup']!['id'] as int,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Subgroup>> getSubgroups() async {
    try {
      final response =
          await DioSingletone.dioMain.get<dynamic>('schedule/subgroups');

      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      final subgroups = <Subgroup>[];
      for (final subgroup in data['subgroups'] as List<dynamic>) {
        subgroups.add(
          Subgroup(
            name: subgroup['name'] as String,
            id: subgroup['id'] as int,
          ),
        );
      }

      return subgroups;
    } catch (e) {
      throw Exception(e);
    }
  }
}
