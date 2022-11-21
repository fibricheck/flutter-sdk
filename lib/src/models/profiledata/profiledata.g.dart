// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiledata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      country: json['country'] as String?,
      region: json['region'] as String?,
      addressLine1: json['address_line1'] as String?,
      addressLine2: json['address_line2'] as String?,
      city: json['city'] as String?,
      postalCode: json['postal_code'] as String?,
      weight: json['weight'] as int?,
      length: json['length'] as int?,
      birthday: json['birthday'] as String?,
      gender: json['gender'] as int?,
      comorbidities: (json['comorbidities'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ComorbiditiesEnumMap, e))
          .toList(),
      physician: json['physician'] as String?,
      smoker: json['smoker'] as bool?,
      activity: $enumDecodeNullable(_$ProfileActivityEnumMap, json['activity']),
      fibricheckInfo: json['fibricheck_info'] == null
          ? null
          : FibricheckInfo.fromJson(
              json['fibricheck_info'] as Map<String, dynamic>),
      impediments: (json['impediments'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ImpedimentsEnumMap, e))
          .toList(),
      customFields: (json['custom_fields'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      afHistory: json['afHistory'] as bool?,
      medication: (json['medication'] as List<dynamic>?)
          ?.map((e) => Medication.fromJson(e as Map<String, dynamic>))
          .toList(),
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
      creationTimestamp: json['creation_timestamp'] == null
          ? null
          : DateTime.parse(json['creation_timestamp'] as String),
      updateTimestamp: json['update_timestamp'] == null
          ? null
          : DateTime.parse(json['update_timestamp'] as String),
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'country': instance.country,
      'region': instance.region,
      'address_line1': instance.addressLine1,
      'address_line2': instance.addressLine2,
      'city': instance.city,
      'postal_code': instance.postalCode,
      'weight': instance.weight,
      'length': instance.length,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'comorbidities': instance.comorbidities
          ?.map((e) => _$ComorbiditiesEnumMap[e]!)
          .toList(),
      'physician': instance.physician,
      'smoker': instance.smoker,
      'activity': _$ProfileActivityEnumMap[instance.activity],
      'fibricheck_info': instance.fibricheckInfo?.toJson(),
      'impediments':
          instance.impediments?.map((e) => _$ImpedimentsEnumMap[e]!).toList(),
      'custom_fields': instance.customFields,
      'afHistory': instance.afHistory,
      'medication': instance.medication?.map((e) => e.toJson()).toList(),
      'groups': instance.groups?.map((e) => e.toJson()).toList(),
      'creation_timestamp': instance.creationTimestamp?.toIso8601String(),
      'update_timestamp': instance.updateTimestamp?.toIso8601String(),
    };

const _$ComorbiditiesEnumMap = {
  Comorbidities.heartFailure: 'HEART_FAILURE',
  Comorbidities.diabetes: 'DIABETES',
  Comorbidities.copd: 'COPD',
  Comorbidities.hypertension: 'HYPERTENSION',
  Comorbidities.vascularDisease: 'VASCULAR_DISEASE',
  Comorbidities.historyOfTiaStroke: 'HISTORY_OF_TIA_STROKE',
};

const _$ProfileActivityEnumMap = {
  ProfileActivity.notActive: 'NOT_ACTIVE',
  ProfileActivity.slightlyActive: 'SLIGHTLY_ACTIVE',
  ProfileActivity.moderatelyActive: 'MODERATELY_ACTIVE',
  ProfileActivity.active: 'ACTIVE',
  ProfileActivity.veryActive: 'VERY_ACTIVE',
};

const _$ImpedimentsEnumMap = {
  Impediments.tremor: 'TREMOR',
  Impediments.perniosis: 'PERNIOSIS',
  Impediments.callus: 'CALLUS',
};
