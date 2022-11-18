import '../../admin_schedule.dart';

class MockLessonTypesRepository implements LessonTypeRepository {
  @override
  Future<LessonType> addLessonType(String name) {
    final lessonType = LessonType(
      id: lessonTypes.length,
      name: name,
    );
    lessonTypes.add(lessonType);
    return Future.delayed(const Duration(seconds: 2), () => lessonType);
  }

  @override
  Future<void> deleteLessonType(String name) {
    lessonTypes.removeWhere((element) => element.name == name);
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<LessonType> getLessonType(String name) => Future.delayed(
        const Duration(seconds: 2),
        () => lessonTypes.firstWhere((element) => element.name == name),
      );

  @override
  Future<List<LessonType>> getLessonTypes() =>
      Future.delayed(const Duration(seconds: 2), () => lessonTypes);

  @override
  Future<LessonType> updateLessonType(LessonType lessonType) {
    final index =
        lessonTypes.indexWhere((element) => element.id == lessonType.id);
    lessonTypes[index] = lessonType;
    return Future.delayed(const Duration(seconds: 2), () => lessonType);
  }
}
