// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diagnosis _$DiagnosisFromJson(Map<String, dynamic> json) => Diagnosis(
      text: json['text'] as String,
      label: (json['label'] as List<dynamic>)
          .map((e) => $enumDecode(_$MeasurementDiagnosisEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$DiagnosisToJson(Diagnosis instance) => <String, dynamic>{
      'text': instance.text,
      'label':
          instance.label.map((e) => _$MeasurementDiagnosisEnumMap[e]!).toList(),
    };

const _$MeasurementDiagnosisEnumMap = {
  MeasurementDiagnosis.sinusArrhythmia: 'sinus_arrhythmia',
  MeasurementDiagnosis.extrasystolesTrigEpisode: 'extrasystoles_trig_episode',
  MeasurementDiagnosis.undiagnosable: 'undiagnosable',
  MeasurementDiagnosis.extrasystolesIsolated: 'extrasystoles_isolated',
  MeasurementDiagnosis.dubiousRhythm: 'dubious_rhythm',
  MeasurementDiagnosis.extrasystoles: 'extrasystoles',
  MeasurementDiagnosis.extrasystolesTrigeminy: 'extrasystoles_trigeminy',
  MeasurementDiagnosis.tachyEpisode: 'tachy_episode',
  MeasurementDiagnosis.extrasystolesFrequent: 'extrasystoles_frequent',
  MeasurementDiagnosis.phoneIncompatible: 'phone_incompatible',
  MeasurementDiagnosis.extrasystolesBigEpisode: 'extrasystoles_big_episode',
  MeasurementDiagnosis.increasedHrv: 'increased_hrv',
  MeasurementDiagnosis.sinus: 'sinus',
  MeasurementDiagnosis.atrialFlutter: 'atrial_flutter',
  MeasurementDiagnosis.bradyEpisode: 'brady_episode',
  MeasurementDiagnosis.tachycardia: 'tachycardia',
  MeasurementDiagnosis.extrasystolesBigminy: 'extrasystoles_bigminy',
  MeasurementDiagnosis.tachyArrhytmia: 'tachy_arrhytmia',
  MeasurementDiagnosis.pacemakerRhythm: 'pacemaker_rhythm',
  MeasurementDiagnosis.bradycardia: 'bradycardia',
  MeasurementDiagnosis.bradyArrhytmia: 'brady_arrhytmia',
  MeasurementDiagnosis.qualityToLow: 'quality_to_low',
  MeasurementDiagnosis.atrialFibrillation: 'atrial_fibrillation',
  MeasurementDiagnosis.other: 'other',
  MeasurementDiagnosis.noDiagnosis: 'no_diagnosis',
};
