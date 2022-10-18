import 'package:schedule_service/src/models/subject_model.dart';

abstract class SubjectRepository {
  Future<bool> existsSubject({
    String? nameSubject,
    int? idSubject,
  });

  Future<Subject> insertSubject(String nameSubject);

  Future<Subject> updateSubject(Subject subject);

  Future<Subject> getSubject(int idSubject);

  Future<List<Subject>> getAllSubjects();

  Future<void> deleteSubject(int idSubject);
}
