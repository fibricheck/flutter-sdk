// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConfiguration _$UserConfigurationFromJson(Map<String, dynamic> json) =>
    UserConfiguration(
      id: json['id'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      staffConfigurations: (json['staffConfigurations'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      patientConfigurations: (json['patientConfigurations'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      updateTimestamp: json['updateTimestamp'] == null
          ? null
          : DateTime.parse(json['updateTimestamp'] as String),
      creationTimestamp: json['creationTimestamp'] == null
          ? null
          : DateTime.parse(json['creationTimestamp'] as String),
    );

Map<String, dynamic> _$UserConfigurationToJson(UserConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'staffConfigurations': instance.staffConfigurations,
      'patientConfigurations': instance.patientConfigurations,
      'updateTimestamp': instance.updateTimestamp?.toIso8601String(),
      'creationTimestamp': instance.creationTimestamp?.toIso8601String(),
    };
