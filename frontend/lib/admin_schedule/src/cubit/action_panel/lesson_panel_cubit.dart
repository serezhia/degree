// import 'package:degree_app/admin_schedule/src/data/mock_lesson_types.dart';
// import 'package:degree_app/admin_schedule/src/repository/lesson_repository.dart';

// import '../../../admin_schedule.dart';

// part 'lesson_panel_state.dart';

// class LessonPanelCubit extends Cubit<LessonPanelState> {
//   LessonPanelCubit(this.lessonRepository) : super(EmptyLessonPanelState());

//   final LessonRepository lessonRepository;

//   Future<void> openAddPanel() async {
//     emit(AddLessonPanelState());
//   }

//   Future<void> openEditPanel(Lesson lesson) async {
//     emit(EditLessonPanelState(lesson: lesson));
//   }

//   Future<void> addLesson({
//     required String name,
//     required String specialityName,
//     required int course,
//     required int sublessonsCount,
//   }) async {
//     emit(LoadingLessonPanelState());
//     try {
//       emit(
//         InfoLessonPanelState(
//           lesson: await lessonRepository.addLesson(
//             nameSubject: nameSubject,
//             teacher: teacher,
//             lessonType: lessonType,
//             numberLesson: numberLesson,
//             date: date,
//           ),
//         ),
//       );
//     } catch (e) {
//       emit(ErrorLessonPanelState(message: e.toString()));
//     }
//   }

//   Future<void> getLesson(int id) async {
//     emit(LoadingLessonPanelState());
//     try {
//       emit(
//         InfoLessonPanelState(
//           lesson: await lessonRepository.getLesson(id),
//         ),
//       );
//     } catch (e) {
//       emit(ErrorLessonPanelState(message: e.toString()));
//     }
//   }

//   Future<void> editLesson(Lesson lesson) async {
//     emit(LoadingLessonPanelState());
//     try {
//       emit(
//         InfoLessonPanelState(
//           lesson: await lessonRepository.updateLesson(lesson),
//         ),
//       );
//     } catch (e) {
//       emit(ErrorLessonPanelState(message: e.toString()));
//     }
//   }

//   Future<void> deleteLesson(int id) async {
//     emit(LoadingLessonPanelState());
//     try {
//       await lessonRepository.deleteLesson(id);
//       emit(EmptyLessonPanelState());
//     } catch (e) {
//       emit(ErrorLessonPanelState(message: e.toString()));
//     }
//   }
// }
