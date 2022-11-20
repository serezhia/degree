import '../../../admin_schedule.dart';

part 'lesson_panel_state.dart';

class LessonPanelCubit extends Cubit<LessonPanelState> {
  LessonPanelCubit(
    this.lessonRepository,
  ) : super(EmptyLessonPanelState());

  final LessonRepository lessonRepository;

  Future<void> openAddPanel() async {
    emit(AddLessonPanelState());
  }

  Future<void> openEditPanel(Lesson lesson) async {
    emit(EditLessonPanelState(lesson: lesson));
  }

  Future<void> addLesson({
    required int subjectId,
    required int numberLesson,
    required DateTime date,
    required LessonType lessonType,
    required int cabinetNumberm,
    required int teacherId,
    int? groupId,
    int? studentId,
    int? subgroupId,
  }) async {
    emit(LoadingLessonPanelState());
    try {
      emit(
        InfoLessonPanelState(
          lesson: await lessonRepository.addLesson(
            subjectId: subjectId,
            teacherId: teacherId,
            lessonType: lessonType,
            numberLesson: numberLesson,
            date: date,
            cabinetNumber: cabinetNumberm,
            groupId: groupId,
            studentId: studentId,
            subgroupId: subgroupId,
          ),
        ),
      );
    } catch (e) {
      emit(ErrorLessonPanelState(message: e.toString()));
    }
  }

  Future<void> getLesson(int id) async {
    emit(LoadingLessonPanelState());
    try {
      emit(
        InfoLessonPanelState(
          lesson: await lessonRepository.getLesson(id),
        ),
      );
    } catch (e) {
      emit(ErrorLessonPanelState(message: e.toString()));
    }
  }

  Future<void> editLesson(Lesson lesson) async {
    emit(LoadingLessonPanelState());
    try {
      emit(
        InfoLessonPanelState(
          lesson: await lessonRepository.updateLesson(lesson),
        ),
      );
    } catch (e) {
      emit(ErrorLessonPanelState(message: e.toString()));
    }
  }

  Future<void> deleteLesson(int id) async {
    emit(LoadingLessonPanelState());
    try {
      await lessonRepository.deleteLesson(id);
      emit(EmptyLessonPanelState());
    } catch (e) {
      emit(ErrorLessonPanelState(message: e.toString()));
    }
  }
}
