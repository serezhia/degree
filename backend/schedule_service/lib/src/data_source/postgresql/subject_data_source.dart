import 'package:schedule_service/schedule_service.dart';

class PostgreSubjectDataSource implements SubjectRepository {
  final PostgreSQLConnection connection;

  PostgreSubjectDataSource(this.connection);

  @override
  Future<bool> existsSubject({String? nameSubject, int? idSubject}) async {
    if (idSubject == null) {
      final result = await connection.query('''
    SELECT * FROM subjects WHERE name = @name;
  ''', substitutionValues: {
        'name': nameSubject,
      });
      return result.isNotEmpty;
    } else if (nameSubject == null) {
      {
        final result = await connection.query('''
    SELECT * FROM subjects WHERE subject_id = @id;
  ''', substitutionValues: {
          'id': idSubject,
        });
        return result.isNotEmpty;
      }
    }
    return false;
  }

  @override
  Future<List<Subject>> getAllSubjects() async {
    final result = await connection.query('''
    SELECT * FROM subjects;
  ''');
    return result
        .map((e) => Subject(
              id: e[0] as int,
              name: e[1] as String,
            ))
        .toList();
  }

  @override
  Future<void> deleteSubject(int idSubject) async {
    await connection.query('''
    DELETE FROM subjects WHERE subject_id = @id;
  ''', substitutionValues: {
      'id': idSubject,
    });
  }

  @override
  Future<Subject> getSubject(int idSubject) async {
    final result = await connection.query('''
    SELECT * FROM subjects WHERE subject_id = @id;
  ''', substitutionValues: {
      'id': idSubject,
    });
    return Subject(id: result.first[0] as int, name: result.first[1] as String);
  }

  @override
  Future<Subject> insertSubject(String nameSubject) async {
    await connection.query('''
    INSERT INTO subjects (name) VALUES (@name);
  ''', substitutionValues: {
      'name': nameSubject,
    });
    final newSubject = await connection.query('''
    SELECT * FROM subjects WHERE name = @name;
  ''', substitutionValues: {
      'name': nameSubject,
    });
    return Subject(
      id: newSubject.first[0] as int,
      name: newSubject.first[1] as String,
    );
  }
}
