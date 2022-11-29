part of 'schedule_page_cubit.dart';

abstract class SchedulePageState extends Equatable {
  const SchedulePageState();

  @override
  List<Object> get props => [];
}

class InitialSchedulePageState extends SchedulePageState {}

class PickedSchedulePageState extends SchedulePageState {
  final DateTimeRange week;

  const PickedSchedulePageState({required this.week});
}

class ChangeWeekSchedulePageState extends SchedulePageState {
  final DateTimeRange week;

  const ChangeWeekSchedulePageState({required this.week});
}
