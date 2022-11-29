// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer';

import 'package:degree_app/admin_schedule/admin_schedule.dart';
import 'package:degree_app/admin_schedule/src/model/cabinet_model.dart';
import 'package:degree_app/dio_singletone.dart';

class MainLessonRepository implements LessonRepository {
  @override
  Future<Lesson> addLesson({
    required Subject subject,
    required Teacher teacher,
    required LessonType lessonType,
    required int numberLesson,
    required DateTime date,
    required Cabinet cabinet,
    Group? group,
    Subgroup? subgroup,
  }) async {
    try {
      final response = await DioSingletone.dioMain.post<String>(
        'schedule/lessons',
        queryParameters: <String, dynamic>{
          'subject_id': subject.id,
          'teacher_id': teacher.teacherId,
          'lessonType_id': lessonType.id,
          'lessonNumber': numberLesson,
          'day': date.toIso8601String(),
          'cabinet_id': cabinet.id,
          if (group != null) 'group_id': group.id,
          if (subgroup != null) 'subgroup_id': subgroup.id,
        },
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;

      return Lesson(
        id: data['lesson']!['lesson_id'] as int,
        subject: subject,
        teacher: teacher,
        lessonType: lessonType,
        numberLesson: numberLesson,
        date: date,
        cabinet: cabinet,
        group: group,
        subgroup: subgroup,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteLesson(int id) {
    try {
      return DioSingletone.dioMain.delete<String>('schedule/lessons/$id');
    } catch (e) {
      rethrow;
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
  Future<List<Lesson>> getLessonsByDay(DateTime date) async {
    try {
      int month() {
        if (date.month < 10) {
          return int.parse('0${date.month}');
        } else {
          return date.month;
        }
      }

      String day() {
        if (date.day < 10) {
          return '0${date.day}';
        } else {
          return date.day.toString();
        }
      }

      final response = await DioSingletone.dioMain.get<String>(
        'schedule/lessons/day/${date.year}${month()}${day()}',
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;
      final lessons = <Lesson>[];
      log(data['lessons'].toString());
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
      return lessons;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Lesson> updateLesson(Lesson lesson) async {
    try {
      final response = await DioSingletone.dioMain.post<String>(
        'schedule/lessons/${lesson.id}',
        queryParameters: <String, dynamic>{
          'subject_id': lesson.subject.id,
          'teacher_id': lesson.teacher.teacherId,
          'lessonType_id': lesson.lessonType.id,
          'lessonNumber': lesson.numberLesson,
          'day': lesson.date.toIso8601String(),
          'cabinet_id': lesson.cabinet.id,
          if (lesson.group != null) 'group_id': lesson.group!.id,
          if (lesson.subgroup != null) 'subgroup_id': lesson.subgroup!.id,
        },
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;
      final lessonData = data['lesson'] as Map<String, dynamic>;
      return Lesson(
        id: lessonData['lesson_id'] as int,
        subject: Subject(
          id: lessonData['subject']['id'] as int,
          name: lessonData['subject']['name'] as String,
        ),
        teacher: Teacher(
          firstName: lessonData['teacher']['firstName'] as String,
          secondName: lessonData['teacher']['secondName'] as String,
          middleName: lessonData['teacher']['middleName'] as String?,
          userId: lessonData['teacher']['userId'] as int,
          teacherId: lessonData['teacher']['teacherId'] as int,
        ),
        lessonType: LessonType(
          id: lessonData['lessonType']['id'] as int,
          name: lessonData['lessonType']['name'] as String,
        ),
        numberLesson: lessonData['lessonNumber'] as int,
        date: DateTime.parse(lessonData['day'] as String),
        cabinet: Cabinet(
          id: lessonData['cabinet']['id'] as int,
          number: lessonData['cabinet']['number'] as int,
        ),
        group: lessonData['group'] != null
            ? Group(
                id: lessonData['group']['id'] as int,
                name: lessonData['group']['name'] as String,
                speciality: Speciality(id: -1, name: 'Не указано'),
                course: -1,
                subgroups: [],
              )
            : null,
        subgroup: lessonData['subgroup'] != null
            ? Subgroup(
                id: lessonData['subgroup']['id'] as int,
                name: lessonData['subgroup']['name'] as String,
              )
            : null,
      );
    } catch (e) {
      rethrow;
    }
  }
}
