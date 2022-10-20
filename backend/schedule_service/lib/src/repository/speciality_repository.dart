import 'package:schedule_service/schedule_service.dart';

abstract class SpecialityRepository {
  Future<bool> existsSpeciality({
    String? nameSpeciality,
    int? idSpeciality,
  });

  Future<Speciality> insertSpeciality(String name);

  Future<Speciality> updateSpeciality(Speciality speciality);

  Future<Speciality> getSpeciality(int idSpeciality);

  Future<List<Speciality>> getAllSpecialitys();

  Future<void> deleteSpeciality(int idSpeciality);
}
