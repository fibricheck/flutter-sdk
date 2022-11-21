// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medication _$MedicationFromJson(Map<String, dynamic> json) => Medication(
      name: json['name'] as String,
      dosis: Dosis.fromJson(json['dosis'] as Map<String, dynamic>),
      medicationFrequency: $enumDecodeNullable(
          _$MedicationFrequencyEnumMap, json['medication_frequency']),
      count: json['count'] as int,
    );

Map<String, dynamic> _$MedicationToJson(Medication instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dosis': instance.dosis.toJson(),
      'medication_frequency':
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
