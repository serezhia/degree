// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer';

import 'package:degree_app/dio_singletone.dart';
import 'package:degree_app/teacher_task/teacher_task.dart';

class MainTaskDataSource implements TaskRepository {
  @override
  Future<Task> addTask({
    required Subject subject,
    required String content,
    required DeadLineType deadLineType,
    required DateTime? deadLineDate,
    List<TagTask>? tags,
    List<FileDegree>? files,
    Group? group,
    Subgroup? subgroup,
    Student? student,
  }) async {
    try {
      final response = await DioSingletone.dioMain.post<String>(
        'task/tasks/',
        queryParameters: <String, dynamic>{
          'subject_id': subject.id,
          'content': content,
          'deadline_type':
              deadLineType == DeadLineType.date ? 'date' : 'nextLesson',
          if (deadLineType == DeadLineType.date)
            'deadline': deadLineDate?.toIso8601String(),
          if (group != null) 'group_id': group.id,
          if (subgroup != null) 'subgroup_id': subgroup.id,
          if (student != null) 'student_id': student.studentId,
        },
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;
      return Task(
        id: data['task']['task_id'] as int,
        subject: subject,
        teacher: Teacher(
          firstName: data['task']['teacher']['firstName'] as String,
          secondName: data['task']['teacher']['secondName'] as String,
          teacherId: data['task']['teacher']['teacher_id'] as int,
        ),
        content: content,
        deadLineType: deadLineType,
        deadLineDate: deadLineDate,
        tags: tags,
        files: files,
        group: group,
        subgroup: subgroup,
        student: student,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(int id) async {
    try {
      // TODO: implement deleteTask
      throw UnimplementedError();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Task> getTask(int id) async {
    try {
      final response = await DioSingletone.dioMain.get<String>(
        'task/tasks/$id',
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;
      return Task(
        id: data['task']['task_id'] as int,
        subject: Subject(
          id: data['task']['subject']['id'] as int,
          name: data['task']['subject']['name'] as String,
        ),
        teacher: Teacher(
          teacherId: data['task']['teacher']['teacher_id'] as int,
          firstName: data['task']['teacher']['firstName'] as String,
          secondName: data['task']['teacher']['secondName'] as String,
        ),
        content: data['task']['content'] as String,
        deadLineType: data['task']['deadline_type'] as String == 'date'
            ? DeadLineType.date
            : DeadLineType.lesson,
        deadLineDate: data['task']['deadline'] != null
            ? DateTime.parse(data['task']['deadline'] as String)
            : null,
        tags: data['task']['tags'] != null
            ? (data['task']['tags'] as List<dynamic>)
                .map(
                  (dynamic e) => TagTask(
                    id: e['id'] as int,
                    name: e['name'] as String,
                  ),
                )
                .toList()
            : null,
        files: [],
        group: data['task']['group'] != null
            ? Group(
                id: data['task']['group']['id'] as int,
                name: data['task']['group']['name'] as String,
                speciality: Speciality(id: -1, name: ''),
                course: -1,
                subgroups: [],
              )
            : null,
        subgroup: data['task']['subgroup'] != null
            ? Subgroup(
                id: data['task']['subgroup']['id'] as int,
                name: data['task']['subgroup']['name'] as String,
              )
            : null,
        student: data['task']['student'] != null
            ? Student(
                studentId: data['task']['student']['id'] as int,
                firstName: data['task']['student']['firstName'] as String,
                secondName: data['task']['student']['secondName'] as String,
                group: Group(
                  id: -1,
                  name: '',
                  speciality: Speciality(id: -1, name: ''),
                  course: -1,
                  subgroups: [],
                ),
                subgroup: Subgroup(id: -1, name: ''),
              )
            : null,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Task>> getTasksByDay(DateTime date) async {
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

    try {
      final response = await DioSingletone.dioMain.get<String>(
        'task/tasks/teacher/${date.year}${month(date)}${day(date)}',
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;

      final tasks = <Task>[];
      if ((data['tasks'] as List<dynamic>).isEmpty) {
        log('tasks is empty');
        return tasks;
      }
      for (final dynamic task in data['tasks']!) {
        tasks.add(
          Task(
            id: task['task_id'] as int,
            subject: Subject(
              id: task['subject']['id'] as int,
              name: task['subject']['name'] as String,
            ),
            teacher: Teacher(
              teacherId: task['teacher']['teacher_id'] as int,
              firstName: task['teacher']['firstName'] as String,
              secondName: task['teacher']['secondName'] as String,
            ),
            content: task['content'] as String,
            deadLineType: task['deadline_type'] as String == 'date'
                ? DeadLineType.date
                : DeadLineType.lesson,
            deadLineDate: task['deadline_date'] != null
                ? DateTime.parse(task['deadline_date'] as String)
                : null,
            tags: task['tags'] != null
                ? (task['tags'] as List<dynamic>)
                    .map(
                      (dynamic e) => TagTask(
                        id: e['id'] as int,
                        name: e['name'] as String,
                      ),
                    )
                    .toList()
                : null,
            files: [],
            group: task['group'] != null
                ? Group(
                    id: task['group']['id'] as int,
                    name: task['group']['name'] as String,
                    speciality: Speciality(id: -1, name: ''),
                    course: -1,
                    subgroups: [],
                  )
                : null,
            subgroup: task['subgroup'] != null
                ? Subgroup(
                    id: task['subgroup']['id'] as int,
                    name: task['subgroup']['name'] as String,
                  )
                : null,
            student: task['student'] != null
                ? Student(
                    studentId: task['student']['id'] as int,
                    firstName: task['student']['firstName'] as String,
                    secondName: task['student']['secondName'] as String,
                    group: Group(
                      id: -1,
                      name: '',
                      speciality: Speciality(id: -1, name: ''),
                      course: -1,
                      subgroups: [],
                    ),
                    subgroup: Subgroup(id: -1, name: ''),
                  )
                : null,
          ),
        );
      }
      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Task> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
