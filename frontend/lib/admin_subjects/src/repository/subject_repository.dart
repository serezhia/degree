import '../../admin_subjects.dart';

abstract class SubjectRepository {
  Future<List<Subject>> getSubjectsList();

  Future<Subject> getSubject(int id);

  Future<Subject> createSubject(String name);

  Future<void> deleteSubject(int id);
}
