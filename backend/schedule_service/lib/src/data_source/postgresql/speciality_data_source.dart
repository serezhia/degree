import 'package:schedule_service/schedule_service.dart';

class PostgreSpecialityDataSource extends SpecialityRepository {
  final PostgreSQLConnection connection;

  PostgreSpecialityDataSource(this.connection);

  @override
  Future<void> deleteSpeciality(int idSpeciality) async {
    await connection.query('''
    DELETE FROM specialties WHERE speciality_id = @id;
  ''', substitutionValues: {
      'id': idSpeciality,
    });
  }

  @override
  Future<bool> existsSpeciality(
      {String? nameSpeciality, int? idSpeciality}) async {
    if (idSpeciality == null) {
      final result = await connection.query('''
    SELECT * FROM specialties WHERE name = @name;
  ''', substitutionValues: {
        'name': nameSpeciality,
      });
      return result.isNotEmpty;
    } else if (nameSpeciality == null) {
      {
        final result = await connection.query('''
    SELECT * FROM specialties WHERE speciality_id = @id;
  ''', substitutionValues: {
          'id': idSpeciality,
        });
        return result.isNotEmpty;
      }
    }
    return false;
  }

  @override
  Future<List<Speciality>> getAllSpecialitys() async {
    final result = await connection.query('''
    SELECT * FROM specialties;
  ''');
    return result
        .map((e) => Speciality(
              id: e[0] as int,
              name: e[1] as String,
            ))
        .toList();
  }

  @override
  Future<Speciality> getSpeciality(int idSpeciality) async {
    final result = await connection.query('''
    SELECT * FROM specialties WHERE speciality_id = @id;
  ''', substitutionValues: {
      'id': idSpeciality,
    });
    return Speciality(
      id: result.first[0] as int,
      name: result.first[1] as String,
    );
  }

  @override
  Future<Speciality> insertSpeciality(String name) async {
    await connection.query('''
    INSERT INTO specialties (name) VALUES (@name);
  ''', substitutionValues: {
      'name': name,
    });
    final newSpeciality = await connection.query('''
    SELECT * FROM specialties WHERE name = @name;
  ''', substitutionValues: {
      'name': name,
    });
    return Speciality(
      id: newSpeciality.first[0] as int,
      name: newSpeciality.first[1] as String,
    );
  }

  @override
  Future<Speciality> updateSpeciality(Speciality speciality) async {
    await connection.query('''
    UPDATE specialties SET name = @name WHERE speciality_id = @id;
  ''', substitutionValues: {
      'name': speciality.name,
      'id': speciality.id,
    });
    final newSpeciality = await connection.query('''
    SELECT * FROM specialties WHERE speciality_id = @id;
  ''', substitutionValues: {
      'id': speciality.id,
    });
    return Speciality(
      id: newSpeciality.first[0] as int,
      name: newSpeciality.first[1] as String,
    );
  }
}
