// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiledata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dosis _$DosisFromJson(Map<String, dynamic> json) => Dosis(
      number: json['number'] as int?,
      unit: $enumDecodeNullable(_$MedicationUnitEnumMap, json['unit']),
    );

Map<String, dynamic> _$DosisToJson(Dosis instance) => <String, dynamic>{
      'number': instance.number,
      'unit': _$MedicationUnitEnumMap[instance.unit],
    };

const _$MedicationUnitEnumMap = {
  MedicationUnit.mg: 'mg',
  MedicationUnit.ml: 'ml',
  MedicationUnit.pill: 'pill',
};

Medication _$MedicationFromJson(Map<String, dynamic> json) => Medication(
      name: json['name'] as String,
      dosis: Dosis.fromJson(json['dosis'] as Map<String, dynamic>),
      medicationFrequency: $enumDecodeNullable(_$MedicationFrequencyEnumMap, json['medication_frequency']),
      count: json['count'] as int,
    );

Map<String, dynamic> _$MedicationToJson(Medication instance) => <String, dynamic>{
      'name': instance.name,
      'dosis': instance.dosis.toJson(),
      'medication_frequency': _$MedicationFrequencyEnumMap[instance.medicationFrequency],
      'count': instance.count,
    };

const _$MedicationFrequencyEnumMap = {
  MedicationFrequency.asNeeded: 'AS_NEEDED',
  MedicationFrequency.everyDay: 'EVERY_DAY',
  MedicationFrequency.everyWeek: 'EVERY_WEEK',
  MedicationFrequency.everyMonth: 'EVERY_MONTH',
  MedicationFrequency.birthControl: 'BIRTH_CONTROL',
};

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      groupId: json['groupId'] as String?,
      reason: json['reason'] as String?,
      patientId: json['patient_id'] as String?,
      customFields: (json['custom_fields'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'groupId': instance.groupId,
      'reason': instance.reason,
      'patient_id': instance.patientId,
      'custom_fields': instance.customFields,
    };

FibricheckInfo _$FibricheckInfoFromJson(Map<String, dynamic> json) => FibricheckInfo(
      app: json['app'] == null ? null : App.fromJson(json['app'] as Map<String, dynamic>),
      device: json['device'] == null ? null : Device.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FibricheckInfoToJson(FibricheckInfo instance) => <String, dynamic>{
      'app': instance.app?.toJson(),
      'device': instance.device?.toJson(),
    };

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
      comorbidities:
          (json['comorbidities'] as List<dynamic>?)?.map((e) => $enumDecode(_$ComorbiditiesEnumMap, e)).toList(),
      physician: json['physician'] as String?,
      smoker: json['smoker'] as bool?,
      activity: $enumDecodeNullable(_$ProfileActivityEnumMap, json['activity']),
      fibricheckInfo: json['fibricheck_info'] == null
          ? null
          : FibricheckInfo.fromJson(json['fibricheck_info'] as Map<String, dynamic>),
      impediments: (json['impediments'] as List<dynamic>?)?.map((e) => $enumDecode(_$ImpedimentsEnumMap, e)).toList(),
      customFields: (json['custom_fields'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      afHistory: json['afHistory'] as bool?,
      medication:
          (json['medication'] as List<dynamic>?)?.map((e) => Medication.fromJson(e as Map<String, dynamic>)).toList(),
      groups: (json['groups'] as List<dynamic>?)?.map((e) => Group.fromJson(e as Map<String, dynamic>)).toList(),
      creationTimestamp:
          json['creation_timestamp'] == null ? null : DateTime.parse(json['creation_timestamp'] as String),
      updateTimestamp: json['update_timestamp'] == null ? null : DateTime.parse(json['update_timestamp'] as String),
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) => <String, dynamic>{
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
      'comorbidities': instance.comorbidities?.map((e) => _$ComorbiditiesEnumMap[e]!).toList(),
      'physician': instance.physician,
      'smoker': instance.smoker,
      'activity': _$ProfileActivityEnumMap[instance.activity],
      'fibricheck_info': instance.fibricheckInfo?.toJson(),
      'impediments': instance.impediments?.map((e) => _$ImpedimentsEnumMap[e]!).toList(),
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
