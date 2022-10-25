class Lesson {
  final int lessonId;
  final int? groupId;
  final int? subgroupId;
  final int subjectId;
  final int cabinetId;
  final int teacherId;
  final DateTime day;
  final int lessonNumber;
  final int lessonTypeId;

  Lesson(
      {required this.lessonId,
      this.groupId,
      this.subgroupId,
      required this.subjectId,
      required this.cabinetId,
      required this.teacherId,
      required this.day,
      required this.lessonNumber,
      required this.lessonTypeId});
}
