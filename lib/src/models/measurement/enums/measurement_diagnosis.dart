// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

enum MeasurementDiagnosis {
  @JsonValue('sinus_arrhythmia')
  sinusArrhythmia,
  @JsonValue('extrasystoles_trig_episode')
  extrasystolesTrigEpisode,
  undiagnosable,
  @JsonValue('extrasystoles_isolated')
  extrasystolesIsolated,
  @JsonValue('dubious_rhythm')
  dubiousRhythm,
  extrasystoles,
  @JsonValue('extrasystoles_trigeminy')
  extrasystolesTrigeminy,
  @JsonValue('tachy_episode')
  tachyEpisode,
  @JsonValue('extrasystoles_frequent')
  extrasystolesFrequent,
  @JsonValue('phone_incompatible')
  phoneIncompatible,
  @JsonValue('extrasystoles_big_episode')
  extrasystolesBigEpisode,
  @JsonValue('increased_hrv')
  increasedHrv,
  sinus,
  @JsonValue('atrial_flutter')
  atrialFlutter,
  @JsonValue('brady_episode')
  bradyEpisode,
  tachycardia,
  @JsonValue('extrasystoles_bigminy')
  extrasystolesBigminy,
  @JsonValue('tachy_arrhytmia')
  tachyArrhytmia,
  @JsonValue('pacemaker_rhythm')
  pacemakerRhythm,
  bradycardia,
  @JsonValue('brady_arrhytmia')
  bradyArrhytmia,
  @JsonValue('quality_to_low')
  qualityToLow,
  @JsonValue('atrial_fibrillation')
  atrialFibrillation,
  other,
  @JsonValue('no_diagnosis')
  noDiagnosis,
}

extension MeasurementDiagnosisSortable on MeasurementDiagnosis {
  int compareTo(MeasurementDiagnosis other) => index.compareTo(other.index);
}
