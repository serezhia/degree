import '../../admin_groups.dart';

abstract class SubgroupRepository {
  Future<List<Subgroup>> getSubgroups();

  Future<Subgroup> getSubgroup(int id);

  Future<List<Subgroup>> createSubgroups(String nameGroup, int numberSubgroups);

  Future<void> deleteSubgroup(int id);
}
