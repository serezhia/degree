import 'dart:developer';

import 'package:schedule_service/schedule_service.dart';

class PostgresLessonDataSource implements LessonRepository {
  final PostgreSQLConnection connection;

  PostgresLessonDataSource(this.connection);

  @override
  Future<void> deleteLesson(int lessonId) {
    return connection.mappedResultsQuery(
      'DELETE FROM lessons WHERE lesson_id = @lessonId',
      substitutionValues: {'lessonId': lessonId},
    );
  }

  @override
  Future<List<Lesson>> getAllLessons() async {
    final result = await connection.mappedResultsQuery(
      'SELECT * FROM lessons',
    );
    return result
        .map((e) => Lesson(
              lessonId: e['lessons']!['lesson_id'] as int,
              groupId: e['lessons']!['group_id'] as int?,
              subgroupId: e['lessons']!['subgroup_id'] as int?,
              subjectId: e['lessons']!['subject_id'] as int,
              cabinetId: e['lessons']!['cabinet_id'] as int,
              teacherId: e['lessons']!['teacher_id'] as int,
              day: e['lessons']!['day'] as DateTime,
              lessonNumber: e['lessons']!['number_lesson'] as int,
              lessonTypeId: e['lessons']!['type_lesson_id'] as int,
            ))
        .toList();
  }

  @override
  Future<Lesson> getLesson(int lessonId) {
    return connection.mappedResultsQuery(
      'SELECT * FROM lessons WHERE lesson_id = @lessonId',
      substitutionValues: {'lessonId': lessonId},
    ).then((value) => Lesson(
          lessonId: value.first['lessons']!['lesson_id'] as int,
          groupId: value.first['lessons']!['group_id'] as int?,
          subgroupId: value.first['lessons']!['subgroup_id'] as int?,
          subjectId: value.first['lessons']!['subject_id'] as int,
          cabinetId: value.first['lessons']!['cabinet_id'] as int,
          teacherId: value.first['lessons']!['teacher_id'] as int,
          day: value.first['lessons']!['day'] as DateTime,
          lessonNumber: value.first['lessons']!['number_lesson'] as int,
          lessonTypeId: value.first['lessons']!['type_lesson_id'] as int,
        ));
  }

  @override
  Future<List<Lesson>> getLessonsByDay(DateTime day) {
    return connection.mappedResultsQuery(
      'SELECT * FROM lessons WHERE day = @day',
      substitutionValues: {'day': day},
    ).then((value) => value
        .map((e) => Lesson(
              lessonId: e['lessons']!['lesson_id'] as int,
              groupId: e['lessons']!['group_id'] as int?,
              subgroupId: e['lessons']!['subgroup_id'] as int?,
              subjectId: e['lessons']!['subject_id'] as int,
              teacherId: e['lessons']!['teacher_id'] as int,
              cabinetId: e['lessons']!['cabinet_id'] as int,
              lessonTypeId: e['lessons']!['type_lesson_id'] as int,
              lessonNumber: e['lessons']!['number_lesson'] as int,
              day: e['lessons']!['day'] as DateTime,
            ))
        .toList());
  }

  @override
  Future<List<Lesson>> getLessonsByGroup(int groupId) {
    return connection.mappedResultsQuery(
      'SELECT * FROM lessons WHERE group_id = @groupId',
      substitutionValues: {'groupId': groupId},
    ).then((value) => value
        .map((e) => Lesson(
              lessonId: e['lessons']!['lesson_id'] as int,
              groupId: e['lessons']!['group_id'] as int?,
              subgroupId: e['lessons']!['subgroup_id'] as int?,
              subjectId: e['lessons']!['subject_id'] as int,
              teacherId: e['lessons']!['teacher_id'] as int,
              cabinetId: e['lessons']!['cabinet_id'] as int,
              lessonTypeId: e['lessons']!['type_lesson_id'] as int,
              lessonNumber: e['lessons']!['number_lesson'] as int,
              day: e['lessons']!['day'] as DateTime,
            ))
        .toList());
  }

  @override
  Future<List<Lesson>> getLessonsByStudent(int studentId) async {
    final groupId = await connection.mappedResultsQuery(
        'SELECT group_id FROM students WHERE student_id = @studentId',
        substitutionValues: {'studentId': studentId});

    final subgroupId = await connection.mappedResultsQuery(
        'SELECT subgroup_id FROM students WHERE student_id = @studentId',
        substitutionValues: {'studentId': studentId});

    final groupLesson = await connection.mappedResultsQuery(
        'SELECT * FROM lessons WHERE group_id = @groupId',
        substitutionValues: {
          'groupId': groupId.first['students']!['group_id']
        }).then((value) => value
        .map((e) => Lesson(
              lessonId: e['lessons']!['lesson_id'] as int,
              groupId: e['lessons']!['group_id'] as int?,
              subgroupId: e['lessons']!['subgroup_id'] as int?,
              subjectId: e['lessons']!['subject_id'] as int,
              teacherId: e['lessons']!['teacher_id'] as int,
              cabinetId: e['lessons']!['cabinet_id'] as int,
              lessonTypeId: e['lessons']!['type_lesson_id'] as int,
              lessonNumber: e['lessons']!['number_lesson'] as int,
              day: e['lessons']!['day'] as DateTime,
            ))
        .toList());

    final subgroupLesson = await connection.mappedResultsQuery(
        'SELECT * FROM lessons WHERE subgroup_id = @subgroupId',
        substitutionValues: {
          'subgroupId': subgroupId.first['students']!['subgroup_id']
        }).then((value) => value
        .map((e) => Lesson(
              lessonId: e['lessons']!['lesson_id'] as int,
              groupId: e['lessons']!['group_id'] as int?,
              subgroupId: e['lessons']!['subgroup_id'] as int?,
              subjectId: e['lessons']!['subject_id'] as int,
              teacherId: e['lessons']!['teacher_id'] as int,
              cabinetId: e['lessons']!['cabinet_id'] as int,
              lessonTypeId: e['lessons']!['type_lesson_id'] as int,
              lessonNumber: e['lessons']!['number_lesson'] as int,
              day: e['lessons']!['day'] as DateTime,
            ))
        .toList());

    return groupLesson + subgroupLesson;
  }

  @override
  Future<List<Lesson>> getLessonsBySubgroup(int subgroupId) {
    return connection.mappedResultsQuery(
      'SELECT * FROM lessons WHERE subgroup_id = @subgroupId',
      substitutionValues: {'subgroupId': subgroupId},
    ).then((value) => value
        .map((e) => Lesson(
              lessonId: e['lessons']!['lesson_id'] as int,
              groupId: e['lessons']!['group_id'] as int?,
              subgroupId: e['lessons']!['subgroup_id'] as int?,
              subjectId: e['lessons']!['subject_id'] as int,
              cabinetId: e['lessons']!['cabinet_id'] as int,
              teacherId: e['lessons']!['teacher_id'] as int,
              day: e['lessons']!['day'] as DateTime,
              lessonNumber: e['lessons']!['number_lesson'] as int,
              lessonTypeId: e['lessons']!['type_lesson_id'] as int,
            ))
        .toList());
  }

  @override
  Future<List<Lesson>> getLessonsByTeacher(int teacherId) {
    return connection.mappedResultsQuery(
      'SELECT * FROM lessons WHERE teacher_id = @teacherid',
      substitutionValues: {'teacherid': teacherId},
    ).then((value) => value
        .map((e) => Lesson(
              lessonId: e['lessons']!['lesson_id'] as int,
              groupId: e['lessons']!['group_id'] as int?,
              subgroupId: e['lessons']!['subgroup_id'] as int?,
              subjectId: e['lessons']!['subject_id'] as int,
              cabinetId: e['lessons']!['cabinet_id'] as int,
              teacherId: e['lessons']!['teacher_id'] as int,
              day: e['lessons']!['day'] as DateTime,
              lessonNumber: e['lessons']!['number_lesson'] as int,
              lessonTypeId: e['lessons']!['type_lesson_id'] as int,
            ))
        .toList());
  }

  @override
  Future<Lesson> insertLesson(
      {int? groupId,
      int? subgroupId,
      required int subjectId,
      required int teacherId,
      required int cabinetId,
      required int lessonTypeId,
      required int lessonNumber,
      required DateTime day}) async {
    return await connection.transaction((ctx) async {
      if (groupId != null) {
        log('insert lesson by group');
        return await ctx.mappedResultsQuery(
          'INSERT INTO lessons (group_id, subject_id, teacher_id, cabinet_id, type_lesson_id, number_lesson, day) VALUES (@groupId, @subjectId, @teacherId, @cabinetId, @lessonTypeId, @lessonNumber, @day) RETURNING *',
          substitutionValues: {
            'groupId': groupId,
            'subjectId': subjectId,
            'teacherId': teacherId,
            'cabinetId': cabinetId,
            'lessonTypeId': lessonTypeId,
            'lessonNumber': lessonNumber,
            'day': day,
          },
        ).then((value) {
          log(value.first['lessons'].toString());
          return Lesson(
            lessonId: value.first['lessons']!['lesson_id'] as int,
            groupId: groupId,
            subgroupId: subgroupId,
            subjectId: subjectId,
            teacherId: teacherId,
            cabinetId: cabinetId,
            lessonTypeId: lessonTypeId,
            lessonNumber: lessonNumber,
            day: day,
          );
        });
      } else {
        return await ctx.mappedResultsQuery(
          'INSERT INTO lessons (subgroup_id, subject_id, teacher_id, cabinet_id, type_lesson_id, number_lesson, day) VALUES (@subgroupId, @subjectId, @teacherId, @cabinetId, @lessonTypeId, @lessonNumber, @day) RETURNING *',
          substitutionValues: {
            'subgroupId': subgroupId,
            'subjectId': subjectId,
            'teacherId': teacherId,
            'cabinetId': cabinetId,
            'lessonTypeId': lessonTypeId,
            'lessonNumber': lessonNumber,
            'day': day,
          },
        ).then(
          (value) => Lesson(
            lessonId: value.first['lessons']!['lesson_id'] as int,
            groupId: groupId,
            subgroupId: subgroupId,
            subjectId: subjectId,
            teacherId: teacherId,
            cabinetId: cabinetId,
            lessonTypeId: lessonTypeId,
            lessonNumber: lessonNumber,
            day: day,
          ),
        );
      }
    });
  }

  @override
  Future<Lesson> updateLesson(Lesson lesson) async {
    return await connection.transaction((ctx) async {
      return await ctx.mappedResultsQuery(
        'UPDATE lessons SET group_id = @groupId, subgroup_id = @subgroupId, subject_id = @subjectId, teacher_id = @teacherId, cabinet_id = @cabinetId, type_lesson_id = @lessonTypeId, number_lesson = @lessonNumber, day = @day WHERE lesson_id = @lessonId RETURNING *',
        substitutionValues: {
          'lessonId': lesson.lessonId,
          'groupId': lesson.groupId,
          'subgroupId': lesson.subgroupId,
          'subjectId': lesson.subjectId,
          'teacherId': lesson.teacherId,
          'cabinetId': lesson.cabinetId,
          'lessonTypeId': lesson.lessonTypeId,
          'lessonNumber': lesson.lessonNumber,
          'day': lesson.day,
        },
      ).then(
        (value) => Lesson(
            lessonId: value.first['lessons']!['lesson_id'] as int,
            groupId: lesson.groupId,
            subjectId: lesson.subjectId,
            subgroupId: lesson.subgroupId,
            teacherId: lesson.teacherId,
            cabinetId: lesson.cabinetId,
            lessonTypeId: lesson.lessonTypeId,
            lessonNumber: lesson.lessonNumber,
            day: lesson.day),
      );
    });
  }

  @override
  Future<bool> existsLesson(
      {int? lessonId,
      int? groupId,
      int? subgroupId,
      int? subjectId,
      int? teacherId,
      int? cabinetId,
      int? lessonTypeId,
      int? lessonNumber,
      DateTime? day}) {
    if (lessonId != null) {
      return connection.mappedResultsQuery(
        'SELECT * FROM lessons WHERE lesson_id = @lessonId',
        substitutionValues: {'lessonId': lessonId},
      ).then((value) => value.isNotEmpty);
    } else {
      if (groupId != null) {
        return connection.mappedResultsQuery(
          'SELECT * FROM lessons WHERE group_id = @groupId AND subject_id = @subjectId AND teacher_id = @teacherId AND cabinet_id = @cabinetId AND type_lesson_id = @lessonTypeId AND number_lesson = @lessonNumber AND day = @day',
          substitutionValues: {
            'groupId': groupId,
            'subjectId': subjectId,
            'teacherId': teacherId,
            'cabinetId': cabinetId,
            'lessonTypeId': lessonTypeId,
            'lessonNumber': lessonNumber,
            'day': day,
          },
        ).then((value) => value.isNotEmpty);
      } else {
        return connection.mappedResultsQuery(
          'SELECT * FROM lessons WHERE subgroup_id = @subgroupId AND subject_id = @subjectId AND teacher_id = @teacherId AND cabinet_id = @cabinetId AND type_lesson_id = @lessonTypeId AND number_lesson = @lessonNumber AND day = @day',
          substitutionValues: {
            'subgroupId': subgroupId,
            'subjectId': subjectId,
            'teacherId': teacherId,
            'cabinetId': cabinetId,
            'lessonTypeId': lessonTypeId,
            'lessonNumber': lessonNumber,
            'day': day,
          },
        ).then((value) => value.isNotEmpty);
      }
    }
  }

  @override
  Future<List<LessonType>> getAllLessonTypes() {
    return connection
        .mappedResultsQuery(
          'SELECT * FROM lesson_types',
        )
        .then((value) => value
            .map((e) => LessonType(
                  id: e['lesson_types']!['lesson_type_id'] as int,
                  name: e['lesson_types']!['name'] as String,
                ))
            .toList());
  }

  @override
  Future<LessonType> getLessonType(int lessonTypeId) {
    return connection.mappedResultsQuery(
      'SELECT * FROM lesson_types WHERE lesson_type_id = @lessonTypeId',
      substitutionValues: {
        'lessonTypeId': lessonTypeId,
      },
    ).then((value) => LessonType(
          id: value.first['lesson_types']!['lesson_type_id'] as int,
          name: value.first['lesson_types']!['name'] as String,
        ));
  }

  @override
  Future<LessonType> insertLessonType(String name) async {
    return await connection.transaction((ctx) async {
      return await ctx.mappedResultsQuery(
        'INSERT INTO lesson_types (name) VALUES (@name) RETURNING *',
        substitutionValues: {
          'name': name,
        },
      ).then(
        (value) => LessonType(
          id: value.first['lesson_types']!['lesson_type_id'] as int,
          name: value.first['lesson_types']!['name'] as String,
        ),
      );
    });
  }

  @override
  Future<LessonType> updateLessonType(LessonType lessonType) async {
    return await connection.transaction((ctx) async {
      return await ctx.mappedResultsQuery(
        'UPDATE lesson_types SET name = @name WHERE lesson_type_id = @lessonTypeId RETURNING *',
        substitutionValues: {
          'lessonTypeId': lessonType.id,
          'name': lessonType.name,
        },
      ).then(
        (value) => LessonType(
          id: value.first['lesson_types']!['lesson_type_id'] as int,
          name: value.first['lesson_types']!['name'] as String,
        ),
      );
    });
  }

  @override
  Future<void> deleteLessonType(int lessonTypeId) {
    return connection.mappedResultsQuery(
      'DELETE FROM lesson_types WHERE lesson_type_id = @lessonTypeId',
      substitutionValues: {
        'lessonTypeId': lessonTypeId,
      },
    );
  }

  @override
  Future<bool> existsLessonType({int? lessonTypeId, String? name}) {
    if (lessonTypeId != null) {
      return connection.mappedResultsQuery(
        'SELECT * FROM lesson_types WHERE lesson_type_id = @lessonTypeId',
        substitutionValues: {
          'lessonTypeId': lessonTypeId,
        },
      ).then((value) => value.isNotEmpty);
    } else {
      return connection.mappedResultsQuery(
        'SELECT * FROM lesson_types WHERE name = @name',
        substitutionValues: {
          'name': name,
        },
      ).then((value) => value.isNotEmpty);
    }
  }
}
