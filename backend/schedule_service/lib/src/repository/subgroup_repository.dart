import 'package:schedule_service/schedule_service.dart';

abstract class SubgroupRepository {
  Future<bool> existsSubgroup({
    String? nameSubgroup,
    int? idSubgroup,
  });

  Future<Subgroup> insertSubgroup(String name);

  Future<Subgroup> updateSubgroup(Subgroup subgroup);

  Future<Subgroup> getSubgroup(int idSubgroup);

  Future<List<Subgroup>> getAllSubgroups();

  Future<void> deleteSubgroup(int idSubgroup);

  Future<Subject> addSubjectToSubgroup(int idCabinet, int idSubject);

  Future<bool> existsSubgroupsSubject(int idCabinet, int idSubject);

  Future<List<Subgroup>> getSubgroupsBySubject(int idSubject);

  Future<void> deleteSubjectFromSubgroup(int idCabinet, int idSubject);

  Future<List<Subject>> getSubjectsBySubgroup(int idCabinet);
}
