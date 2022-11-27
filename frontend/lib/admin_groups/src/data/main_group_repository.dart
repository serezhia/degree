// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:degree_app/dio_singletone.dart';

import '../../admin_groups.dart';

class MainGroupRepository implements GroupRepository {
  @override
  Future<Group> createGroup(
    String name,
    Speciality speciality,
    int course,
    List<Subgroup> subgroups,
  ) async {
    try {
      final response = await DioSingletone.dioMain.post<dynamic>(
        'schedule/groups',
        queryParameters: <String, dynamic>{
          'name': name,
          'idSpeciality': speciality.id,
          'course': course,
        },
      );
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      return Group(
        speciality: speciality,
        course: course,
        name: name,
        id: data['Group']!['id'] as int,
        subgroups: subgroups,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteGroup(int id) async {
    try {
      final groupResponse =
          await DioSingletone.dioMain.get<dynamic>('schedule/groups/$id');
      final groupData =
          jsonDecode(groupResponse.data as String) as Map<String, dynamic>;
      final subgroupsResponse =
          await DioSingletone.dioMain.get<dynamic>('schedule/subgroups');

      final subgroupsData =
          jsonDecode(subgroupsResponse.data as String) as Map<String, dynamic>;
      final subgroups = <Subgroup>[];
      for (final subgroup in subgroupsData['subgroups'] as List<dynamic>) {
        subgroups.add(
          Subgroup(
            name: subgroup['name'] as String,
            id: subgroup['id'] as int,
          ),
        );
      }

      final groupSubgroups = subgroups
          .where(
            (subgroup) =>
                subgroup.name.split('/').first ==
                groupData['Group']!['name'] as String,
          )
          .toList();
      for (final subgroup in groupSubgroups) {
        await DioSingletone.dioMain.delete<dynamic>(
          'schedule/subgroups/${subgroup.id}',
        );
      }
      await DioSingletone.dioMain.delete<dynamic>(
        'schedule/groups/$id',
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Group> editGroup(Group group) async {
    try {
      await DioSingletone.dioMain.put<dynamic>(
        'schedule/groups/${group.id}',
        queryParameters: <String, dynamic>{
          'name': group.name,
          'idSpeciality': group.speciality.id,
          'course': group.course,
        },
      );
      return group;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Group> getGroup(int id) async {
    try {
      final groupResponse =
          await DioSingletone.dioMain.get<dynamic>('schedule/groups/$id');
      final groupData =
          jsonDecode(groupResponse.data as String) as Map<String, dynamic>;

      final specialityResponse = await DioSingletone.dioMain.get<dynamic>(
        'schedule/spetialties/${groupData['Group']!['idSpeciality']}',
      );

      final specialityData =
          jsonDecode(specialityResponse.data as String) as Map<String, dynamic>;

      final speciality = Speciality(
        id: specialityData['Speciality']!['id'] as int,
        name: specialityData['Speciality']!['name'] as String,
      );

      final subgroupsResponse =
          await DioSingletone.dioMain.get<dynamic>('schedule/subgroups');

      final subgroupsData =
          jsonDecode(subgroupsResponse.data as String) as Map<String, dynamic>;
      final subgroups = <Subgroup>[];
      for (final subgroup in subgroupsData['subgroups'] as List<dynamic>) {
        subgroups.add(
          Subgroup(
            name: subgroup['name'] as String,
            id: subgroup['id'] as int,
          ),
        );
      }

      final groupSubgroups = subgroups
          .where(
            (subgroup) =>
                subgroup.name.split('/').first ==
                groupData['Group']!['name'] as String,
          )
          .toList();

      return Group(
        speciality: speciality,
        course: groupData['Group']!['course'] as int,
        name: groupData['Group']!['name'] as String,
        id: groupData['Group']!['id'] as int,
        subgroups: groupSubgroups,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Group>> getGroups() async {
    try {
      final response =
          await DioSingletone.dioMain.get<dynamic>('schedule/groups');
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;

      final specialitiesResponse =
          await DioSingletone.dioMain.get<dynamic>('schedule/spetialties');
      final specialitiesData = jsonDecode(specialitiesResponse.data as String)
          as Map<String, dynamic>;

      final specialities = <Speciality>[];
      for (final speciality
          in specialitiesData['specialitys'] as List<dynamic>) {
        specialities.add(
          Speciality(
            id: speciality['id'] as int,
            name: speciality['name'] as String,
          ),
        );
      }
      final groups = <Group>[];
      for (final group in data['Groups'] as List<dynamic>) {
        final speciality = specialities.firstWhere(
          (speciality) => speciality.id == group['idSpeciality'] as int,
        );
        groups.add(
          Group(
            speciality: speciality,
            course: group['course'] as int,
            name: group['name'] as String,
            id: group['id'] as int,
            subgroups: <Subgroup>[],
          ),
        );
      }
      return groups;
    } catch (e) {
      throw Exception(e);
    }
  }
}
