import 'package:degree_app/teacher_task/src/data/mock_tasks.dart';

import '../../teacher_task.dart';

class MockTaskRepository implements TaskRepository {
  @override
  Future<Task> addTask({
    required Subject subject,
    required Teacher teacher,
    required String content,
    required String date,
    required String time,
    required DeadLineType deadLineType,
    required DateTime? deadLineDate,
    List<TagTask>? tags,
    List<FileDegree>? files,
    Group? group,
    Subgroup? subgroup,
    Student? student,
  }) =>
      Future.delayed(const Duration(seconds: 2), () {
        final task = Task(
          id: mockListTasks.length + 1,
          subject: subject,
          teacher: teacher,
          content: content,
          deadLineType: deadLineType,
          deadLineDate: deadLineDate,
          tags: tags,
          files: files,
          group: group,
          subgroup: subgroup,
          student: student,
        );
        mockListTasks.add(task);
        return task;
      });

  @override
  Future<void> deleteTask(int id) => Future.delayed(
        const Duration(seconds: 2),
      );

  @override
  Future<Task> getTask(int id) => Future.delayed(
        const Duration(seconds: 2),
        () => mockListTasks.firstWhere((element) => element.id == id),
      );

  @override
  Future<List<Task>> getTasksByDay(DateTime date) => Future.delayed(
        const Duration(seconds: 2),
        () => mockListTasks
            .where(
              (element) =>
                  element.deadLineDate?.day == date.day &&
                  element.deadLineDate?.month == date.month &&
                  element.deadLineDate?.year == date.year,
            )
            .toList(),
      );

  @override
  Future<Task> updateTask(Task task) {
    final oldTaskIndex =
        mockListTasks.indexWhere((element) => element.id == task.id);
    mockListTasks[oldTaskIndex] = task;
    return Future.delayed(const Duration(seconds: 2), () => task);
  }
}
