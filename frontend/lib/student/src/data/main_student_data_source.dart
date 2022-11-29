// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:degree_app/dio_singletone.dart';

import '../../student.dart';

class MainStudentDataSource implements MainStudentRepository {
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

  @override
  Future<Lesson> getLesson(int id) async {
    try {
      final response = await DioSingletone.dioMain.get<String>(
        'schedule/lessons/$id',
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;
      final lesson = data['lesson'] as Map<String, dynamic>;
      return Lesson(
        id: lesson['lesson_id'] as int,
        subject: Subject(
          id: lesson['subject']['id'] as int,
          name: lesson['subject']['name'] as String,
        ),
        teacher: Teacher(
          firstName: lesson['teacher']['firstName'] as String,
          secondName: lesson['teacher']['secondName'] as String,
          middleName: lesson['teacher']['middleName'] as String?,
          userId: lesson['teacher']['userId'] as int,
          teacherId: lesson['teacher']['teacherId'] as int,
        ),
        lessonType: LessonType(
          id: lesson['lessonType']['id'] as int,
          name: lesson['lessonType']['name'] as String,
        ),
        numberLesson: lesson['lessonNumber'] as int,
        date: DateTime.parse(lesson['day'] as String),
        cabinet: Cabinet(
          id: lesson['cabinet']['id'] as int,
          number: lesson['cabinet']['number'] as int,
        ),
        group: lesson['group'] != null
            ? Group(
                id: lesson['group']['id'] as int,
                name: lesson['group']['name'] as String,
                speciality: Speciality(id: -1, name: 'Не указано'),
                course: -1,
                subgroups: [],
              )
            : null,
        subgroup: lesson['subgroup'] != null
            ? Subgroup(
                id: lesson['subgroup']['id'] as int,
                name: lesson['subgroup']['name'] as String,
              )
            : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Lesson>> getLessonsByStudentOnWeek(
    DateTimeRange week,
  ) async {
    int month(DateTime date) {
      if (date.month < 10) {
        return int.parse('0${date.month}');
      } else {
        return date.month;
      }
    }

    String day(DateTime date) {
      if (date.day < 10) {
        return '0${date.day}';
      } else {
        return date.day.toString();
      }
    }

    final lessons = <Lesson>[];
    for (var i = 0; i < 7; i++) {
      final date = week.start.add(Duration(days: i));
      final response = await DioSingletone.dioMain.get<dynamic>(
        'schedule/lessons/day/${date.year}${month(date)}${day(date)}',
      );
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      for (final dynamic lesson in data['lessons']!) {
        lessons.add(
          Lesson(
            id: lesson['lesson_id'] as int,
            subject: Subject(
              id: lesson['subject']['id'] as int,
              name: lesson['subject']['name'] as String,
            ),
            teacher: Teacher(
              firstName: lesson['teacher']['firstName'] as String,
              secondName: lesson['teacher']['secondName'] as String,
              middleName: lesson['teacher']['middleName'] as String?,
              userId: lesson['teacher']['userId'] as int,
              teacherId: lesson['teacher']['teacherId'] as int,
            ),
            lessonType: LessonType(
              id: lesson['lessonType']['id'] as int,
              name: lesson['lessonType']['name'] as String,
            ),
            numberLesson: lesson['lessonNumber'] as int,
            date: DateTime.parse(lesson['day'] as String),
            cabinet: Cabinet(
              id: lesson['cabinet']['id'] as int,
              number: lesson['cabinet']['number'] as int,
            ),
            group: lesson['group'] != null
                ? Group(
                    id: lesson['group']['id'] as int,
                    name: lesson['group']['name'] as String,
                    speciality: Speciality(id: -1, name: 'Не указано'),
                    course: -1,
                    subgroups: [],
                  )
                : null,
            subgroup: lesson['subgroup'] != null
                ? Subgroup(
                    id: lesson['subgroup']['id'] as int,
                    name: lesson['subgroup']['name'] as String,
                  )
                : null,
          ),
        );
      }
    }

    return lessons;
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

  @override
  Future<Subject> getSubject(int id) async {
    try {
      final response = await DioSingletone.dioMain.get<dynamic>(
        'schedule/subjects/$id',
      );
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      return Subject(
        name: data['subject']!['name'] as String,
        id: data['subject']!['id'] as int,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Subject>> getSubjectsList() async {
    try {
      final response = await DioSingletone.dioMain.get<dynamic>(
        'schedule/subjects/',
      );
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      final subjects = <Subject>[];
      for (final subject in data['subjects'] as List<dynamic>) {
        subjects.add(
          Subject(
            name: subject['name'] as String,
            id: subject['id'] as int,
          ),
        );
      }
      return subjects;
    } catch (e) {
      throw Exception(e);
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
  Future<Teacher> readTeacher({required int teacherId}) async {
    try {
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
    } catch (e) {
      rethrow;
    }
  }
}
