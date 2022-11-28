// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:degree_app/admin_groups/admin_groups.dart';
import 'package:degree_app/admin_students/src/model/student_model.dart';
import 'package:degree_app/admin_students/src/repository/student_repository.dart';
import 'package:degree_app/dio_singletone.dart';

class MainStudentRepository implements StudentRepository {
  @override
  Future<Student> createStudent({
    required String firstName,
    required String secondName,
    required Group group,
    required Subgroup subgroup,
    String? middleName,
  }) async {
    final response = await DioSingletone.dioMain.post<String>(
      'schedule/students',
      queryParameters: <String, dynamic>{
        'first_name': firstName,
        'second_name': secondName,
        'middle_name': middleName,
        'group_id': group.id,
        'subgroup_id': subgroup.id,
      },
    );

    final data = jsonDecode(response.data!) as Map<String, dynamic>;

    return Student(
      firstName: data['student']!['firstName'] as String,
      secondName: data['student']!['secondName'] as String,
      middleName: data['student']!['middleName'] as String?,
      studentId: data['student']!['id'] as int,
      userId: data['student']!['user_id'] as int,
      registrationCode: data['student']!['register_code'] != null
          ? int.tryParse(data['student']!['register_code'] as String)
          : null,
      group: group,
      subgroup: subgroup,
    );
  }

  @override
  Future<void> deleteStudent({required int studentId}) async {
    try {
      await DioSingletone.dioMain
          .delete<String>('schedule/students/$studentId');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Student>> getStudentsList() async {
    try {
      final response =
          await DioSingletone.dioMain.get<String>('schedule/students/');

      final data = jsonDecode(response.data!) as Map<String, dynamic>;
      final students = <Student>[];

      for (final student in data['students'] as List<dynamic>) {
        students.add(
          Student(
            userId: student['user_id'] as int,
            firstName: student['firstName'] as String,
            secondName: student['secondName'] as String,
            middleName: student['middleName'] as String?,
            studentId: student['id'] as int,
            group: Group(
              id: -1,
              name: 'fakeGroup',
              speciality: Speciality(
                id: -1,
                name: 'fakeSpeciality',
              ),
              course: -1,
              subgroups: [],
            ),
            subgroup: Subgroup(
              id: -1,
              name: 'fakeSubgroup',
            ),
          ),
        );
      }
      return students;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Student> readStudent({required int studentId}) async {
    try {
      final studentResponse = await DioSingletone.dioMain
          .get<String>('schedule/students/$studentId');

      final studentData =
          jsonDecode(studentResponse.data!) as Map<String, dynamic>;

      final groupResponse = await DioSingletone.dioMain.get<dynamic>(
        'schedule/groups/${studentData['student']!['group_id']}',
      );
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

      final subgroupResponse = await DioSingletone.dioMain.get<dynamic>(
        'schedule/subgroups/${studentData['student']!['subgroup_id']}',
      );
      final subgroupData =
          jsonDecode(subgroupResponse.data as String) as Map<String, dynamic>;

      final subgroup = Subgroup(
        name: subgroupData['subgroup']!['name'] as String,
        id: subgroupData['subgroup']!['id'] as int,
      );

      final student = Student(
        userId: studentData['student']!['user_id'] as int,
        firstName: studentData['student']!['firstName'] as String,
        secondName: studentData['student']!['secondName'] as String,
        middleName: studentData['student']!['middleName'] as String?,
        studentId: studentData['student']!['id'] as int,
        registrationCode: studentData['student']!['register_code'] != null
            ? int.tryParse(studentData['student']!['register_code'] as String)
            : null,
        group: Group(
          id: groupData['Group']!['id'] as int,
          name: groupData['Group']!['name'] as String,
          speciality: speciality,
          course: groupData['Group']!['course'] as int,
          subgroups: [],
        ),
        subgroup: subgroup,
      );
      return student;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Student> updateStudent(Student student) {
    // TODO: implement updateStudent
    throw UnimplementedError();
  }
}
