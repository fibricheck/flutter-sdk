// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralConfiguration _$GeneralConfigurationFromJson(
        Map<String, dynamic> json) =>
    GeneralConfiguration(
      id: json['id'] as String?,
      updateTimestamp: json['updateTimestamp'] == null
          ? null
          : DateTime.parse(json['updateTimestamp'] as String),
      creationTimestamp: json['creationTimestamp'] == null
          ? null
          : DateTime.parse(json['creationTimestamp'] as String),
      data: json['data'] as Map<String, dynamic>?,
      userConfiguration: json['userConfiguration'] as Map<String, dynamic>?,
      groupConfiguration: json['groupConfiguration'] as Map<String, dynamic>?,
      staffConfiguration: json['staffConfiguration'] as Map<String, dynamic>?,
      patientConfiguration:
          json['patientConfiguration'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GeneralConfigurationToJson(
        GeneralConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'userConfiguration': instance.userConfiguration,
      'groupConfiguration': instance.groupConfiguration,
      'staffConfiguration': instance.staffConfiguration,
      'patientConfiguration': instance.patientConfiguration,
      'updateTimestamp': instance.updateTimestamp?.toIso8601String(),
      'creationTimestamp': instance.creationTimestamp?.toIso8601String(),
    };
