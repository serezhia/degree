import 'package:degree_app/admin_schedule/admin_schedule.dart';

part 'schedules_page_state.dart';

class SchedulesPageCubit extends Cubit<SchedulesPageState> {
  SchedulesPageCubit(this.lessonRepository)
      : super(
          SchedulesPageInitial(
            date: DateTime.now(),
          ),
        );

  final LessonRepository lessonRepository;

  Future<void> setDate(DateTime date) async {
    emit(SchedulesPageLoading());
    try {
      emit(
        SchedulesPageLoaded(
          lessons: await lessonRepository.getLessonsByDay(date),
        ),
      );
    } catch (e) {
      emit(SchedulesPageError(message: e.toString()));
    }
  }

  Future<void> refreshPage(DateTime date) async {
    emit(SchedulesPageLoading());
    try {
      emit(
        SchedulesPageLoaded(
          lessons: await lessonRepository.getLessonsByDay(date),
        ),
      );
    } catch (e) {
      emit(SchedulesPageError(message: e.toString()));
    }
  }
}
