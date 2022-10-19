import 'package:schedule_service/schedule_service.dart';

class PostgreCabinetDataSource extends CabinetRepository {
  final PostgreSQLConnection connection;

  PostgreCabinetDataSource(this.connection);
  @override
  Future<Subject> addSubjectToCabinet(int idCabinet, int idSubject) async {
    return await connection.transaction((ctx) async {
      await ctx.query('''
      INSERT INTO cabinet_subjects (subject_id, cabinet_id) VALUES (@subject_id,@cabinet_id);
    ''', substitutionValues: {
        'cabinet_id': idCabinet,
        'subject_id': idSubject,
      });
      return await ctx.query('''
      SELECT * FROM subjects WHERE subject_id = @id;
    ''', substitutionValues: {
        'id': idSubject,
      }).then((value) => Subject(
            id: value.first[0] as int,
            name: value.first[1] as String,
          ));
    });
  }

  @override
  Future<void> deleteCabinet(int idCabinet) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.query(
          'DELETE FROM cabinets WHERE cabinet_id = @idCabinet RETURNING cabinet_id',
          substitutionValues: {
            'idCabinet': idCabinet,
          });
      if (result.isEmpty) {
        throw Exception('Cabinet not found');
      }
    });
  }

  @override
  Future<void> deleteSubjectFromCabinet(int idCabinet, int idSubject) async {
    await connection.transaction((ctx) async {
      final result = await ctx.query(
          'DELETE FROM cabinet_subjects WHERE cabinet_id = @idCabinet AND subject_id = @idSubject RETURNING cabinet_id, subject_id',
          substitutionValues: {
            'idCabinet': idCabinet,
            'idSubject': idSubject,
          });
      if (result.isEmpty) {
        throw Exception('Cabinet or subject not found');
      }
    });
  }

  @override
  Future<bool> existsCabinet(
      {int? idCabinet, String? adress, int? floor, int? number}) async {
    if (idCabinet != null) {
      final result = await connection.query(
          'SELECT cabinet_id FROM cabinets WHERE cabinet_id = @idCabinet',
          substitutionValues: {
            'idCabinet': idCabinet,
          });
      return result.isNotEmpty;
    } else if (adress != null && floor != null && number != null) {
      final result = await connection.query(
          'SELECT cabinet_id FROM cabinets WHERE adress = @adress AND floor = @floor AND number = @number',
          substitutionValues: {
            'adress': adress,
            'floor': floor,
            'number': number,
          });
      return result.isNotEmpty;
    } else {
      throw Exception('Wrong arguments');
    }
  }

  @override
  Future<bool> existsCabinetsSubject(int idCabinet, int idSubject) {
    return connection.query(
        'SELECT cabinet_id, subject_id FROM cabinet_subjects WHERE cabinet_id = @idCabinet AND subject_id = @idSubject',
        substitutionValues: {
          'idCabinet': idCabinet,
          'idSubject': idSubject,
        }).then((value) => value.isNotEmpty);
  }

  @override
  Future<List<Cabinet>> getAllCabinets() {
    return connection
        .mappedResultsQuery(
            'SELECT cabinet_id, adress, floor, number, seats FROM cabinets')
        .then(
      (result) {
        if (result.isEmpty) {
          throw Exception('Wrong arguments');
        } else {
          return result.map((e) {
            return Cabinet(
              id: e['cabinets']!['cabinet_id'] as int,
              adress: e['cabinets']!['adress'] as String,
              floor: e['cabinets']!['floor'] as int,
              number: e['cabinets']!['number'] as int,
              seats: e['cabinets']!['seats'] as int,
            );
          }).toList();
        }
      },
    );
  }

  @override
  Future<Cabinet> getCabinet(int idCabinet) async {
    return await connection.mappedResultsQuery(
        'SELECT cabinet_id, adress, floor, number, seats FROM cabinets WHERE cabinet_id = @idCabinet',
        substitutionValues: {
          'idCabinet': idCabinet,
        }).then(
      (result) {
        if (result.isEmpty) {
          throw Exception('Cabinet not found');
        }

        return Cabinet(
          id: result[0]['cabinets']!['cabinet_id'] as int,
          adress: result[0]['cabinets']!['adress'] as String,
          floor: result[0]['cabinets']!['floor'] as int,
          number: result[0]['cabinets']!['number'] as int,
          seats: result[0]['cabinets']!['seats'] as int,
        );
      },
    );
  }

  @override
  Future<List<Cabinet>> getCabinetsBySubject(int idSubject) async {
    return await connection.mappedResultsQuery(
        'SELECT cabinet_id, adress, floor, number, seats FROM cabinets WHERE cabinet_id IN (SELECT id_cabinet FROM cabinet_subjects WHERE id_subject = @idSubject)',
        substitutionValues: {
          'idSubject': idSubject,
        }).then(
      (result) {
        return result.map((e) {
          return Cabinet(
            id: e[0]!['cabinet_id'] as int,
            adress: e['adress'] as String,
            floor: e['floor'] as int,
            number: e['number'] as int,
            seats: e['seats'] as int,
          );
        }).toList();
      },
    );
  }

  @override
  Future<List<Subject>> getSubjectsByCabinet(int idCabinet) async {
    return await connection.mappedResultsQuery(
        'SELECT subject_id, name FROM subjects WHERE subject_id IN (SELECT subject_id FROM cabinet_subjects WHERE cabinet_id = @idCabinet)',
        substitutionValues: {
          'idCabinet': idCabinet,
        }).then((value) => value.map((e) {
          print(e);
          return Subject(
            id: e['subjects']!['subject_id'] as int,
            name: e['subjects']!['name'] as String,
          );
        }).toList());
  }

  @override
  Future<Cabinet> insertCabinet(
      String adress, int floor, int number, int seats) async {
    return await connection.query('''  
    INSERT INTO cabinets (adress, floor, number, seats) VALUES (@adress, @floor, @number, @seats) RETURNING *;
    ''', substitutionValues: {
      'adress': adress,
      'floor': floor,
      'number': number,
      'seats': seats,
    }).then((value) => Cabinet(
          id: value.first[0] as int,
          adress: value.first[1] as String,
          floor: value.first[2] as int,
          number: value.first[3] as int,
          seats: value.first[4] as int,
        ));
  }

  @override
  Future<Cabinet> updateCabinet(Cabinet cabinet) async {
    return await connection.query('''
      UPDATE cabinets SET adress = @adress, floor = @floor, number = @number, seats = @seats WHERE cabinet_id = @id RETURNING *;
      ''', substitutionValues: {
      'id': cabinet.id,
      'adress': cabinet.adress,
      'floor': cabinet.floor,
      'number': cabinet.number,
      'seats': cabinet.seats,
    }).then((value) => Cabinet(
          id: value.first[0] as int,
          adress: value.first[1] as String,
          floor: value.first[2] as int,
          number: value.first[3] as int,
          seats: value.first[4] as int,
        ));
  }
}
