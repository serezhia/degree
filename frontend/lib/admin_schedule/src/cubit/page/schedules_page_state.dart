part of 'schedules_page_cubit.dart';

class SchedulesPageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SchedulesPageInitial extends SchedulesPageState {
  SchedulesPageInitial({required this.date});
  final DateTime date;
}

class SchedulesPageLoading extends SchedulesPageState {}

class SchedulesPageLoaded extends SchedulesPageState {
  final List<Lesson> lessons;
  SchedulesPageLoaded({required this.lessons});
}

class SchedulesPageError extends SchedulesPageState {
  final String message;
  SchedulesPageError({required this.message});
}
