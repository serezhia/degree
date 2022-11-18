import 'package:bloc/bloc.dart';
import 'package:degree_app/admin/admin.dart';
import 'package:equatable/equatable.dart';

part 'schedule_page_state.dart';

class SchedulePageCubit extends Cubit<SchedulePageState> {
  SchedulePageCubit() : super(InitialSchedulePageState());

  DateTime currentDate = DateTime.now();

  DateTimeRange currentRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 7)),
  );

  void setDate(DateTime date) {
    currentDate = date;
    emit(ChangeDaySchedulePageState(date: date));
    emit(PickedSchedulePageState(date: date));
  }

  void previosWeek() {
    currentRange = DateTimeRange(
      start: currentRange.start.subtract(const Duration(days: 7)),
      end: currentRange.end.subtract(const Duration(days: 7)),
    );
    emit(ChangeDaySchedulePageState(date: currentDate));
    emit(PickedSchedulePageState(date: currentRange.start));
  }

  void nextWeek() {
    currentRange = DateTimeRange(
      start: currentRange.start.add(const Duration(days: 7)),
      end: currentRange.end.add(const Duration(days: 7)),
    );
    emit(ChangeDaySchedulePageState(date: currentDate));
    emit(PickedSchedulePageState(date: currentRange.start));
  }
}
