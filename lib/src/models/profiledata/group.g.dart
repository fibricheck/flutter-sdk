// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      groupId: json['groupId'] as String?,
      reason: json['reason'] as String?,
      patientId: json['patientId'] as String?,
      customFields: (json['customFields'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'groupId': instance.groupId,
      'reason': instance.reason,
      'patientId': instance.patientId,
      'customFields': instance.customFields,
    };
