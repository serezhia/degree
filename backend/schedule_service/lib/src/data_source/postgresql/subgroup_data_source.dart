import 'package:schedule_service/schedule_service.dart';

class PostgreSubgroupDataSource extends SubgroupRepository {
  final PostgreSQLConnection connection;

  PostgreSubgroupDataSource(this.connection);

  @override
  Future<Subject> addSubjectToSubgroup(int idCabinet, int idSubject) async {
    return await connection.transaction((ctx) async {
      await ctx
          .query(''' INSERT INTO subgroup_subjects (subject_id, subgroup_id) VALUES (@subject_id,@subgroup_id); ''',
              substitutionValues: {
            'subgroup_id': idCabinet,
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
  Future<void> deleteSubgroup(int idSubgroup) async {
    await connection.query(
        'DELETE FROM subgroups WHERE subgroup_id = @idSubgroup',
        substitutionValues: {
          'idSubgroup': idSubgroup,
        });
  }

  @override
  Future<void> deleteSubjectFromSubgroup(int idCabinet, int idSubject) async {
    await connection.query(
        'DELETE FROM subgroup_subjects WHERE subgroup_id = @idSubgroup AND subject_id = @idSubject',
        substitutionValues: {
          'idSubgroup': idCabinet,
          'idSubject': idSubject,
        });
  }

  @override
  Future<bool> existsSubgroup({String? nameSubgroup, int? idSubgroup}) async {
    return await connection.query(
      'SELECT * FROM subgroups WHERE subgroup_id = @idSubgroup OR name = @nameSubgroup',
      substitutionValues: {
        'idSubgroup': idSubgroup,
        'nameSubgroup': nameSubgroup,
      },
    ).then((value) => value.isNotEmpty);
  }

  @override
  Future<bool> existsSubgroupsSubject(int idCabinet, int idSubject) {
    return connection.query(
      'SELECT * FROM subgroup_subjects WHERE subgroup_id = @idSubgroup AND subject_id = @idSubject',
      substitutionValues: {
        'idSubgroup': idCabinet,
        'idSubject': idSubject,
      },
    ).then((value) => value.isNotEmpty);
  }

  @override
  Future<List<Subgroup>> getAllSubgroups() async {
    final result = await connection.query('''
      SELECT * FROM subgroups;
    ''');
    return result
        .map((e) => Subgroup(
              id: e[0] as int,
              name: e[1] as String,
            ))
        .toList();
  }

  @override
  Future<Subgroup> getSubgroup(int idSubgroup) {
    return connection.query('''
      SELECT * FROM subgroups WHERE subgroup_id = @id;
    ''', substitutionValues: {
      'id': idSubgroup,
    }).then((value) {
      if (value.isEmpty) {
        throw Exception('Subgroup not found');
      }

      return Subgroup(
        id: value.first[0] as int,
        name: value.first[1] as String,
      );
    });
  }

  @override
  Future<List<Subgroup>> getSubgroupsBySubject(int idSubject) async {
    return await connection.mappedResultsQuery('''
      SELECT subgroup_id, name FROM subgroups WHERE subgroup_id IN (SELECT subgroup_id FROM subgroup_subjects WHERE subject_id = @id);
    ''', substitutionValues: {
      'id': idSubject,
    }).then((value) => value.map((e) {
          print(e);
          return Subgroup(
            id: e['subgroups']!['subgroup_id'] as int,
            name: e['subgroups']!['name'] as String,
          );
        }).toList());
  }

  @override
  Future<List<Subject>> getSubjectsBySubgroup(int idCabinet) {
    return connection.mappedResultsQuery('''
      SELECT * FROM subjects WHERE subject_id IN (SELECT subject_id FROM subgroup_subjects WHERE subgroup_id = @id);
    ''', substitutionValues: {
      'id': idCabinet,
    }).then((value) => value
        .map((e) => Subject(
              id: e['subjects']!['subject_id'] as int,
              name: e['subjects']!['name'] as String,
            ))
        .toList());
  }

  @override
  Future<Subgroup> insertSubgroup(String name) async {
    return await connection.transaction((ctx) async {
      return await ctx.query('''
        INSERT INTO subgroups (name)
        VALUES (@name)
        RETURNING subgroup_id, name
      ''', substitutionValues: {
        'name': name,
      }).then((value) {
        return Subgroup(
          id: value.first[0] as int,
          name: name,
        );
      });
    });
  }

  @override
  Future<Subgroup> updateSubgroup(Subgroup subgroup) async {
    return await connection.transaction((ctx) async {
      await ctx.query('''
        UPDATE subgroups
        SET name = @name
        WHERE subgroup_id = @id
        RETURNING subgroup_id, name
      ''', substitutionValues: {
        'id': subgroup.id,
        'name': subgroup.name,
      });
      return await ctx.query('''
        SELECT * FROM subgroups WHERE subgroup_id = @id;
      ''', substitutionValues: {
        'id': subgroup.id,
      }).then((value) {
        print(value.first[0]);
        return Subgroup(
          id: value.first[0] as int,
          name: value.first[1] as String,
        );
      });
    });
  }
}
