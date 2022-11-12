import '../../admin_groups.dart';

class MockGroupRepository implements GroupRepository {
  @override
  Future<Group> createGroup(
    String name,
    String specialityName,
    int course,
    int subgroupsCount,
  ) =>
      Future.delayed(const Duration(seconds: 1), () {
        late Speciality speciality;
        if (specialities.isEmpty) {
          specialities.add(Speciality(id: 0, name: specialityName));
          speciality = specialities[0];
        } else {
          speciality = specialities.firstWhereOrNull(
                (speciality) => speciality.name == specialityName,
              ) ??
              Speciality(id: specialities.length, name: specialityName);
          specialities.add(speciality);
        }
        final currentSubgroups = <Subgroup>[];
        for (var i = 0; i < subgroupsCount; i++) {
          if (subgroups.isEmpty) {
            subgroups.add(Subgroup(id: 0, name: '$name/1'));
          } else {
            final subgroup = subgroups.firstWhereOrNull(
              (subgroup) => subgroup.name == '$name/${i + 1}',
            );
            if (subgroup != null) {
              currentSubgroups.add(subgroup);
            } else {
              final subgroup =
                  Subgroup(id: subgroups.length, name: '$name/${i + 1}');
              subgroups.add(subgroup);
              currentSubgroups.add(subgroup);
            }
          }
        }

        final group = Group(
          id: groups.length,
          name: name,
          speciality: speciality,
          course: course,
          subgroups: currentSubgroups,
        );
        groups.add(group);
        return group;
      });
  @override
  Future<void> deleteGroup(int id) => Future.delayed(
        const Duration(seconds: 1),
        () => groups.removeWhere((group) => group.id == id),
      );

  @override
  Future<Group> editGroup(Group group) {
    final index = groups.indexWhere((element) => element.id == group.id);

    return Future.delayed(
      const Duration(seconds: 1),
      () {
        groups[index] = group;
        return group;
      },
    );
  }

  @override
  Future<Group> getGroup(int id) => Future.delayed(
        const Duration(seconds: 1),
        () => groups.firstWhere((group) => group.id == id),
      );

  @override
  Future<List<Group>> getGroups() => Future.delayed(
        const Duration(seconds: 1),
        () => groups,
      );
}
