import 'package:degree_app/teacher/teacher.dart';

part 'schedules_page_state.dart';

class SchedulesPageCubit extends Cubit<SchedulesPageState> {
  SchedulesPageCubit(this.repository)
      : super(
          SchedulesPageInitial(
            week: DateTimeRange(
              start: DateTime.now(),
              end: DateTime.now().add(const Duration(days: 7)),
            ),
          ),
        );

  final MainTeacherRepository repository;

  Future<void> setWeek(DateTimeRange week) async {
    emit(SchedulesPageLoading());
    try {
      emit(
        SchedulesPageLoaded(
          lessons: await repository.getLessonsByTeacherOnWeek(1, week),
        ),
      );
    } catch (e) {
      emit(SchedulesPageError(message: e.toString()));
    }
  }

  Future<void> refreshPage(DateTimeRange week) async {
    emit(SchedulesPageLoading());
    try {
      emit(
        SchedulesPageLoaded(
          lessons: await repository.getLessonsByTeacherOnWeek(1, week),
        ),
      );
    } catch (e) {
      emit(SchedulesPageError(message: e.toString()));
    }
  }
}
