// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementContext _$MeasurementContextFromJson(Map<String, dynamic> json) =>
    MeasurementContext(
      symptoms: (json['symptoms'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$SymptomsEnumMap, e))
          .toList(),
      activity: $enumDecodeNullable(_$ActivityEnumMap, json['activity']),
      symptomSeverity: $enumDecodeNullable(
          _$SymptomSeverityEnumMap, json['symptomSeverity']),
    );

Map<String, dynamic> _$MeasurementContextToJson(MeasurementContext instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('symptoms',
      instance.symptoms?.map((e) => _$SymptomsEnumMap[e]!).toList());
  writeNotNull('activity', _$ActivityEnumMap[instance.activity]);
  writeNotNull(
      'symptomSeverity', _$SymptomSeverityEnumMap[instance.symptomSeverity]);
  return val;
}

const _$SymptomsEnumMap = {
  Symptoms.noSymptoms: 'no_symptoms',
  Symptoms.lightheaded: 'lightheaded',
  Symptoms.confused: 'confused',
  Symptoms.fatigue: 'fatigue',
  Symptoms.other: 'other',
  Symptoms.palpitations: 'palpitations',
  Symptoms.chestPains: 'chest_pains',
  Symptoms.shortnessOfBreath: 'shortness_of_breath',
  Symptoms.racingHeart: 'racing_heart',
  Symptoms.dizziness: 'dizziness',
  Symptoms.feelingOfFainting: 'feeling_of_fainting',
};

const _$ActivityEnumMap = {
  Activity.resting: 'resting',
  Activity.sleeping: 'sleeping',
  Activity.sitting: 'sitting',
  Activity.walking: 'walking',
  Activity.working: 'working',
  Activity.exercising: 'exercising',
  Activity.other: 'other',
  Activity.standing: 'standing',
};

const _$SymptomSeverityEnumMap = {
  SymptomSeverity.severity_1: '1',
  SymptomSeverity.severity_2a: '2a',
  SymptomSeverity.severity_2b: '2b',
  SymptomSeverity.severity_3: '3',
  SymptomSeverity.severity_4: '4',
};
