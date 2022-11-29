import '../../../../student.dart';

part 'schedule_page_state.dart';

class SchedulePageCubit extends Cubit<SchedulePageState> {
  SchedulePageCubit() : super(InitialSchedulePageState());

  DateTimeRange currentRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 7)),
  );

  void previosWeek() {
    currentRange = DateTimeRange(
      start: currentRange.start.subtract(const Duration(days: 8)),
      end: currentRange.end.subtract(const Duration(days: 8)),
    );
    emit(ChangeWeekSchedulePageState(week: currentRange));
    emit(PickedSchedulePageState(week: currentRange));
  }

  void nextWeek() {
    currentRange = DateTimeRange(
      start: currentRange.start.add(const Duration(days: 8)),
      end: currentRange.end.add(const Duration(days: 8)),
    );
    emit(ChangeWeekSchedulePageState(week: currentRange));
    emit(PickedSchedulePageState(week: currentRange));
  }
}
