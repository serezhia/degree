// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      firstName: json['firstName'] as String,
      secondName: json['secondName'] as String,
      teacherId: json['teacherId'] as int,
      userId: json['userId'] as int?,
      middleName: json['middleName'] as String?,
      registrationCode: json['registrationCode'] as int?,
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => Subject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'middleName': instance.middleName,
      'registrationCode': instance.registrationCode,
      'teacherId': instance.teacherId,
      'subjects': instance.subjects,
    };
