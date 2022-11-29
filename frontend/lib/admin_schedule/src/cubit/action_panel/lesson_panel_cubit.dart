import 'package:degree_app/admin_schedule/src/model/cabinet_model.dart';
import 'package:degree_app/admin_schedule/src/repository/cabinet_repository.dart';

import '../../../admin_schedule.dart';

part 'lesson_panel_state.dart';

class LessonPanelCubit extends Cubit<LessonPanelState> {
  LessonPanelCubit(
    this.lessonRepository,
    this.lessonTypeRepository,
    this.cabinetRepository,
  ) : super(EmptyLessonPanelState());

  final LessonRepository lessonRepository;
  final LessonTypeRepository lessonTypeRepository;
  final CabinetRepository cabinetRepository;

  Future<List<LessonType>> getLessonTypesForField() async =>
      lessonTypes = await lessonTypeRepository.getLessonTypes();

  Future<LessonType> addLessonType(String name) async {
    final lessonType = await lessonTypeRepository.addLessonType(name);
    return lessonType;
  }

  Future<List<Cabinet>> getCabinetsForField() async =>
      cabinetRepository.getCabinets();

  Future<Cabinet> addCabinet(int number) async {
    final cabinet = await cabinetRepository.addCabinet(number);
    return cabinet;
  }

  Future<void> openAddPanel() async {
    emit(AddLessonPanelState());
  }

  Future<void> openEditPanel(Lesson lesson) async {
    emit(EditLessonPanelState(lesson: lesson));
  }

  Future<void> addLesson({
    required Subject subject,
    required int numberLesson,
    required DateTime date,
    required LessonType lessonType,
    required Cabinet cabinet,
    required Teacher teacher,
    Group? group,
    Subgroup? subgroup,
  }) async {
    emit(LoadingLessonPanelState());
    try {
      emit(
        InfoLessonPanelState(
          lesson: await lessonRepository.addLesson(
            subject: subject,
            teacher: teacher,
            lessonType: lessonType,
            numberLesson: numberLesson,
            date: date,
            cabinet: cabinet,
            group: group,
            subgroup: subgroup,
          ),
        ),
      );
    } catch (e) {
      emit(ErrorLessonPanelState(message: e.toString()));
    }
  }

  Future<void> getLesson(int id) async {
    emit(LoadingLessonPanelState());
    try {
      emit(
        InfoLessonPanelState(
          lesson: await lessonRepository.getLesson(id),
        ),
      );
    } catch (e) {
      emit(ErrorLessonPanelState(message: e.toString()));
    }
  }

  Future<void> editLesson(Lesson lesson) async {
    emit(LoadingLessonPanelState());
    try {
      emit(
        InfoLessonPanelState(
          lesson: await lessonRepository.updateLesson(lesson),
        ),
      );
    } catch (e) {
      emit(ErrorLessonPanelState(message: e.toString()));
    }
  }

  Future<void> deleteLesson(int id) async {
    emit(LoadingLessonPanelState());
    try {
      await lessonRepository.deleteLesson(id);
      emit(EmptyLessonPanelState());
    } catch (e) {
      emit(ErrorLessonPanelState(message: e.toString()));
    }
  }
}
