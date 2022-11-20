part of 'lesson_panel_cubit.dart';

abstract class LessonPanelState extends Equatable {
  const LessonPanelState();

  @override
  List<Object> get props => [];
}

class EmptyLessonPanelState extends LessonPanelState {}

class LoadingLessonPanelState extends LessonPanelState {}

class AddLessonPanelState extends LessonPanelState {}

class InfoLessonPanelState extends LessonPanelState {
  final Lesson lesson;

  const InfoLessonPanelState({required this.lesson});

  @override
  List<Object> get props => [lesson];
}

class EditLessonPanelState extends LessonPanelState {
  final Lesson lesson;

  const EditLessonPanelState({required this.lesson});

  @override
  List<Object> get props => [lesson];
}

class ErrorLessonPanelState extends LessonPanelState {
  final String message;

  const ErrorLessonPanelState({required this.message});

  @override
  List<Object> get props => [message];
}
