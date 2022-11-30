// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:developer';

import 'package:degree_app/dio_singletone.dart';
import 'package:degree_app/student_task/student_task.dart';

class MainTaskDataSource implements TaskRepository {
  @override
  Future<List<Task>> getCompletedTasks() async {
    try {
      final response = await DioSingletone.dioMain.get<String>(
        'task/tasks/student/true',
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
  Future<List<Task>> getUncompletedTasks() async {
    try {
      final response = await DioSingletone.dioMain.get<String>(
        'task/tasks/student/false',
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
  Future<void> completeTask(int id) async {
    try {
      await DioSingletone.dioMain.post<String>(
        'task/tasks/complete/$id',
      );
    } catch (e) {
      rethrow;
    }
  }
}
