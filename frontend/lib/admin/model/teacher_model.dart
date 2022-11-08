class Teacher {
  Teacher({
    required this.firstName,
    required this.secondName,
    this.middleName,
    this.subjects,
  });

  final String firstName;
  final String secondName;
  final String? middleName;
  final List<String>? subjects;
}
