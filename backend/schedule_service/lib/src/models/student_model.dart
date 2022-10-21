class Student {
  final int id;
  final int userId;
  final String firstName;
  final String secondName;
  final String? middleName;
  final int groupId;
  final int subgroupId;

  Student(
      {required this.id,
      required this.userId,
      required this.firstName,
      required this.secondName,
      this.middleName,
      required this.groupId,
      required this.subgroupId});
}
