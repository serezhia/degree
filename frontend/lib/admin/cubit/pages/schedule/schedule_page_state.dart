part of 'schedule_page_cubit.dart';

abstract class SchedulePageState extends Equatable {
  const SchedulePageState();

  @override
  List<Object> get props => [];
}

class InitialSchedulePageState extends SchedulePageState {}

class PickedSchedulePageState extends SchedulePageState {
  final DateTime date;

  const PickedSchedulePageState({required this.date});
}

class ChangeDaySchedulePageState extends SchedulePageState {
  final DateTime date;

  const ChangeDaySchedulePageState({required this.date});
}
