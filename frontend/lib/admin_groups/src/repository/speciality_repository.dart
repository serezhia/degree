import '../../admin_groups.dart';

abstract class SpecialityRepository {
  Future<List<Speciality>> getSpecialitiesList();

  Future<Speciality> getSpeciality(int id);

  Future<Speciality> createSpeciality(String name);

  Future<void> deleteSpeciality(int id);
}
