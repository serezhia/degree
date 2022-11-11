import 'package:degree_app/admin_teachers/admin_teachers.dart';

class MockSubjectRepository implements SubjectRepository {
  @override
  Future<Subject> createSubject(String name) =>
      Future.delayed(const Duration(seconds: 1), () {
        final subject = Subject(
          id: subjects.length,
          name: name,
        );
        subjects.add(subject);
        return subject;
      });

  @override
  Future<void> deleteSubject(int id) => Future.delayed(
        const Duration(seconds: 1),
        () => subjects.removeWhere((subject) => subject.id == id),
      );

  @override
  Future<Subject> getSubject(int id) => Future.delayed(
        const Duration(seconds: 1),
        () => subjects.firstWhere((subject) => subject.id == id),
      );

  @override
  Future<List<Subject>> getSubjectsList() => Future.delayed(
        const Duration(seconds: 1),
        () => subjects,
      );

  @override
  Future<Subject> updateSubject(Subject subject) => Future.delayed(
        const Duration(seconds: 1),
        () {
          final newSubject = Subject(
            id: subject.id,
            name: subject.name,
          );
          final oldSubjectIndex = subjects.indexWhere(
            (subject) => subject.id == newSubject.id,
          );
          subjects[oldSubjectIndex] = newSubject;
          return newSubject;
        },
      );
}
