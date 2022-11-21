import 'package:bloc/bloc.dart';
import 'package:degree_app/admin/admin.dart';
import 'package:equatable/equatable.dart';

part 'task_page_state.dart';

class TaskPageCubit extends Cubit<TaskPageState> {
  TaskPageCubit() : super(InitialTaskPageState());

  DateTime currentDate = DateTime.now();

  DateTimeRange currentRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 7)),
  );

  void setDate(DateTime date) {
    currentDate = date;
    emit(ChangeDayTaskPageState(date: date));
    emit(PickedTaskPageState(date: date));
  }

  void previosWeek() {
    currentRange = DateTimeRange(
      start: currentRange.start.subtract(const Duration(days: 7)),
      end: currentRange.end.subtract(const Duration(days: 7)),
    );
    emit(ChangeDayTaskPageState(date: currentDate));
    emit(PickedTaskPageState(date: currentRange.start));
  }

  void nextWeek() {
    currentRange = DateTimeRange(
      start: currentRange.start.add(const Duration(days: 7)),
      end: currentRange.end.add(const Duration(days: 7)),
    );
    emit(ChangeDayTaskPageState(date: currentDate));
    emit(PickedTaskPageState(date: currentRange.start));
  }
}
