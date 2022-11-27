// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:degree_app/admin_teachers/admin_teachers.dart';
import 'package:degree_app/dio_singletone.dart';

class MainTeacherRepository implements TeacherRepository {
  @override
  Future<Teacher> createTeacher({
    required String firstName,
    required String secondName,
    String? middleName,
    List<Subject>? subjects,
  }) async {
    try {
      final response = await DioSingletone.dioMain.post<dynamic>(
        'schedule/teachers',
        queryParameters: <String, dynamic>{
          'first_name': firstName,
          'second_name': secondName,
          if (middleName != null) 'middle_name': middleName,
        },
      );
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      return Teacher(
        firstName: data['teacher']!['first_name'] as String,
        secondName: data['teacher']!['second_name'] as String,
        middleName: data['teacher']!['middle_name'] as String?,
        teacherId: data['teacher']!['id'] as int,
        userId: data['teacher']!['user_id'] as int?,
        registrationCode: data['teacher']!['register_code'] != null
            ? int.tryParse(data['teacher']!['register_code'] as String)
            : null,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteTeacher({required int teacherId}) async {
    await DioSingletone.dioMain.delete<dynamic>('schedule/teachers/$teacherId');
  }

  @override
  Future<List<Teacher>> getTeachersList() async {
    final response =
        await DioSingletone.dioMain.get<dynamic>('schedule/teachers');
    final data = jsonDecode(response.data as String) as Map<String, dynamic>;
    final teachers = <Teacher>[];
    for (final teacher in data['teachers'] as List<dynamic>) {
      teachers.add(
        Teacher(
          firstName: teacher['first_name'] as String,
          secondName: teacher['second_name'] as String,
          middleName: teacher['middle_name'] as String?,
          teacherId: teacher['id'] as int,
          userId: teacher['user_id'] as int?,
        ),
      );
    }
    return teachers;
  }

  @override
  Future<Teacher> readTeacher({required int teacherId}) async {
    final response = await DioSingletone.dioMain
        .get<dynamic>('schedule/teachers/$teacherId');
    final data = jsonDecode(response.data as String) as Map<String, dynamic>;

    return Teacher(
      firstName: data['teacher']!['first_name'] as String,
      secondName: data['teacher']!['second_name'] as String,
      middleName: data['teacher']!['middle_name'] as String?,
      teacherId: data['teacher']!['id'] as int,
      userId: data['teacher']!['user_id'] as int?,
      registrationCode: data['teacher']!['register_code'] != null
          ? int.tryParse(data['teacher']!['register_code'] as String)
          : null,
    );
  }

  @override
  Future<Teacher> updateTeacher({required Teacher teacher}) async {
    final response = await DioSingletone.dioMain.post<dynamic>(
      'schedule/teachers/${teacher.teacherId}',
      queryParameters: <String, dynamic>{
        'first_name': teacher.firstName,
        'second_name': teacher.secondName,
        if (teacher.middleName != null) 'middle_name': teacher.middleName,
      },
    );
    final data = jsonDecode(response.data as String) as Map<String, dynamic>;
    return Teacher(
      firstName: data['teacher']!['first_name'] as String,
      secondName: data['teacher']!['second_name'] as String,
      middleName: data['teacher']!['middle_name'] as String?,
      teacherId: data['teacher']!['id'] as int,
      userId: data['teacher']!['user_id'] as int?,
      registrationCode: data['teacher']!['register_code'] != null
          ? int.tryParse(data['teacher']!['register_code'] as String)
          : null,
    );
  }
}
