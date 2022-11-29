// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: json['id'] as int,
      subject: Subject.fromJson(json['subject'] as Map<String, dynamic>),
      teacher: Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      lessonType:
          LessonType.fromJson(json['lessonType'] as Map<String, dynamic>),
      numberLesson: json['numberLesson'] as int,
      date: DateTime.parse(json['date'] as String),
      cabinet: Cabinet.fromJson(json['cabinet'] as Map<String, dynamic>),
      group: json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
      subgroup: json['subgroup'] == null
          ? null
          : Subgroup.fromJson(json['subgroup'] as Map<String, dynamic>),
      student: json['student'] == null
          ? null
          : Student.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'teacher': instance.teacher,
      'lessonType': instance.lessonType,
      'numberLesson': instance.numberLesson,
      'date': instance.date.toIso8601String(),
      'cabinet': instance.cabinet,
      'group': instance.group,
      'subgroup': instance.subgroup,
      'student': instance.student,
    };
