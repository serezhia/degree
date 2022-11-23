import '../../../teacher_schedule.dart';

part 'lesson_panel_state.dart';

class LessonPanelCubit extends Cubit<LessonPanelState> {
  LessonPanelCubit(
    this.repository,
  ) : super(EmptyLessonPanelState());

  final MainTeacherRepository repository;

  Future<void> getLesson(int id) async {
    emit(LoadingLessonPanelState());
    try {
      emit(
        InfoLessonPanelState(
          lesson: await repository.getLesson(id),
        ),
      );
    } catch (e) {
      emit(ErrorLessonPanelState(message: e.toString()));
    }
  }
}
