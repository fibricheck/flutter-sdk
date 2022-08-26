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
      medicationFrequency: $enumDecodeNullable(
          _$MedicationFrequencyEnumMap, json['medicationFrequency']),
      count: json['count'] as int,
    );

Map<String, dynamic> _$MedicationToJson(Medication instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dosis': instance.dosis.toJson(),
      'medicationFrequency':
          _$MedicationFrequencyEnumMap[instance.medicationFrequency],
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

FibricheckInfo _$FibricheckInfoFromJson(Map<String, dynamic> json) =>
    FibricheckInfo(
      app: json['app'] == null
          ? null
          : App.fromJson(json['app'] as Map<String, dynamic>),
      device: json['device'] == null
          ? null
          : Device.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FibricheckInfoToJson(FibricheckInfo instance) =>
    <String, dynamic>{
      'app': instance.app?.toJson(),
      'device': instance.device?.toJson(),
    };

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      country: json['country'] as String?,
      region: json['region'] as String?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String?,
      postalCode: json['postalCode'] as String?,
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
      fibricheckInfo: json['fibricheckInfo'] == null
          ? null
          : FibricheckInfo.fromJson(
              json['fibricheckInfo'] as Map<String, dynamic>),
      impediments: (json['impediments'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ImpedimentsEnumMap, e))
          .toList(),
      customFields: (json['customFields'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      afHistory: json['afHistory'] as bool?,
      medication: (json['medication'] as List<dynamic>?)
          ?.map((e) => Medication.fromJson(e as Map<String, dynamic>))
          .toList(),
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
      creationTimestamp: json['creationTimestamp'] == null
          ? null
          : DateTime.parse(json['creationTimestamp'] as String),
      updateTimestamp: json['updateTimestamp'] == null
          ? null
          : DateTime.parse(json['updateTimestamp'] as String),
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'country': instance.country,
      'region': instance.region,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'postalCode': instance.postalCode,
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
      'fibricheckInfo': instance.fibricheckInfo?.toJson(),
      'impediments':
          instance.impediments?.map((e) => _$ImpedimentsEnumMap[e]!).toList(),
      'customFields': instance.customFields,
      'afHistory': instance.afHistory,
      'medication': instance.medication?.map((e) => e.toJson()).toList(),
      'groups': instance.groups?.map((e) => e.toJson()).toList(),
      'creationTimestamp': instance.creationTimestamp?.toIso8601String(),
      'updateTimestamp': instance.updateTimestamp?.toIso8601String(),
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
