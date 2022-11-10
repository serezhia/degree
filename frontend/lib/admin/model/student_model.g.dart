// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      firstName: json['firstName'] as String,
      secondName: json['secondName'] as String,
      studentId: json['studentId'] as int,
      groupId: json['groupId'] as int,
      subgroupId: json['subgroupId'] as int,
      userId: json['userId'] as int?,
      middleName: json['middleName'] as String?,
      registrationCode: json['registrationCode'] as int?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'middleName': instance.middleName,
      'registrationCode': instance.registrationCode,
      'studentId': instance.studentId,
      'groupId': instance.groupId,
      'subgroupId': instance.subgroupId,
    };
