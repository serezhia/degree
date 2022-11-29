// import 'dart:math';

// import '../../admin_schedule.dart';

// List<Lesson> lessons = <Lesson>[];

// List<Lesson> addLessons() {
//   final lessons = <Lesson>[];
//   for (var i = 0; i < 1000; i++) {
//     lessons.add(
//       Lesson(
//         id: i,
//         subject: subjects.firstWhereOrNull(
//               (element) => element.id == Random().nextInt(subjects.length),
//             ) ??
//             subjects.first,
//         lessonType: lessonTypes[Random().nextInt(lessonTypes.length)],
//         teacher: users.firstWhereOrNull(
//               (element) =>
//                   element is Teacher &&
//                   element.teacherId == Random().nextInt(100),
//             ) as Teacher? ??
//             users.firstWhere((element) => element is Teacher) as Teacher,
//         group: groups[Random().nextInt(groups.length)],
//         numberLesson: Random().nextInt(6),
//         date: DateTime.now().add(
//           Duration(days: Random().nextInt(7)),
//         ),
//         cabinet: Random().nextInt(200),
//       ),
//     );
//   }

//   return lessons;
// }
