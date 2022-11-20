import '../../admin_schedule.dart';

List<Lesson> lessons = <Lesson>[
  Lesson(
    id: 0,
    subject: subjects.firstWhere((element) => element.name == 'Математика'),
    teacher: users.firstWhere(
      (element) => element is Teacher && element.teacherId == 0,
    ) as Teacher,
    lessonType: lessonTypes.firstWhere((element) => element.name == 'Лекция'),
    numberLesson: 1,
    date: DateTime.now(),
    cabinet: 321,
  )
];
