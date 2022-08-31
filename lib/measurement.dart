// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'measurement.g.dart';

enum MeasurementStatus {
  measured,
  @JsonValue('preprocessing_selection')
  preprocessingSelection,
  @JsonValue('analysis_selection')
  analysisSelection,
  @JsonValue('pending_analysis')
  pendingAnalysis,
  @JsonValue('under_analysis')
  underAnalysis,
  @JsonValue('analysis_failed')
  analysisFailed,
  @JsonValue('processing_results')
  processingResults,
  analyzed,
  @JsonValue('pending_review')
  pendingReview,
  reviewed,
}

@JsonSerializable(explicitToJson: true)
class MotionData {
  final List<num> x;
  final List<num> y;
  final List<num> z;

  MotionData({
    required this.x,
    required this.y,
    required this.z,
  });

  factory MotionData.fromJson(Map<String, dynamic> json) => _$MotionDataFromJson(json);

  Map<String, dynamic> toJson() => _$MotionDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Yuv {
  final String? id;
  final List<num>? u;
  final List<num>? v;
  final List<num>? y;

  Yuv({
    this.u,
    this.v,
    this.y,
    this.id,
  });

  factory Yuv.fromJson(Map<String, dynamic> json) => _$YuvFromJson(json);

  Map<String, dynamic> toJson() => _$YuvToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TechnicalDetails {
  @JsonKey(name: 'camera_exposure_time')
  final int? cameraExposureTime;
  @JsonKey(name: 'camera_hardware_level')
  final String? cameraHardwareLevel;
  @JsonKey(name: 'camera_iso')
  final int? cameraIso;
  @JsonKey(name: 'camera_resolution')
  final String? cameraResolution;

  TechnicalDetails({
    required this.cameraExposureTime,
    required this.cameraHardwareLevel,
    required this.cameraIso,
    required this.cameraResolution,
  });

  factory TechnicalDetails.fromJson(Map<String, dynamic> json) => _$TechnicalDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicalDetailsToJson(this);
}

enum Abnormalities {
  inverted,
  @JsonValue('bad_signal_quality')
  badSignalQuality,
  @JsonValue('pulse_not_found')
  pulseNotFound,
  @JsonValue('saturated_rgb')
  saturatedRgb,
  @JsonValue('quality_flag')
  qualityFlag,
  @JsonValue('finger_not_found')
  fingerNotFound,
}

@JsonSerializable(explicitToJson: true)
class CameraData {
  final MotionData? acc;
  final MotionData? rotation;
  final MotionData? grav;
  final MotionData? gyro;
  final num? heartrate;
  @JsonKey(name: 'measurement_timestamp')
  final num? measurementTimestamp;
  final List<List<Yuv>>? quadrants;
  @JsonKey(name: 'technical_details')
  final TechnicalDetails? technicalDetails;
  final List<num>? time;
  final List<num>? yList;
  final List<Abnormalities>? abnormalities;
  final num? attempts;

  CameraData({
    this.heartrate,
    this.measurementTimestamp,
    this.quadrants,
    this.technicalDetails,
    this.time,
    this.yList,
    this.abnormalities,
    this.attempts,
    this.acc,
    this.rotation,
    this.grav,
    this.gyro,
  });

  factory CameraData.fromJson(Map<String, dynamic> json) => _$CameraDataFromJson(json);

  Map<String, dynamic> toJson() => _$CameraDataToJson(this);
}

enum Symptoms {
  @JsonValue('no_symptoms')
  noSymptoms,
  lightheaded,
  confused,
  fatigue,
  other,
  palpitations,
  @JsonValue('chest_pains')
  chestPains,
  @JsonValue('shortness_of_breath')
  shortnessOfBreath,
}

enum Activity {
  resting,
  sleeping,
  sitting,
  walking,
  working,
  exercising,
  other,
  standing,
}

enum SymptomSeverity {
  @JsonValue('1')
  severity_1,
  @JsonValue('2a')
  severity_2a,
  @JsonValue('2b')
  severity_2b,
  @JsonValue('3')
  severity_3,
  @JsonValue('4')
  severity_4,
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MeasurementContext {
  final List<Symptoms>? symptoms;
  final Activity? activity;
  final SymptomSeverity? symptomSeverity;

  MeasurementContext({
    required this.symptoms,
    required this.activity,
    this.symptomSeverity,
  });

  factory MeasurementContext.fromJson(Map<String, dynamic> json) => _$MeasurementContextFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementContextToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Device {
  final String? manufacturer;
  final String? model;
  final String? os;
  final String? type;

  Device({
    this.manufacturer,
    this.model,
    this.os,
    this.type,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class App {
  final String? name;
  final String version;
  final num? build;
  final String? branch;
  @JsonValue('camera_sdk_version')
  final String? cameraSdkVersion;
  @JsonValue('fibricheck_sdk_version')
  final String? fibricheckSdkVersion;

  App({
    this.name,
    required this.version,
    this.build,
    this.branch,
    this.cameraSdkVersion,
    this.fibricheckSdkVersion,
  });

  factory App.fromJson(Map<String, dynamic> json) => _$AppFromJson(json);

  Map<String, dynamic> toJson() => _$AppToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Location {
  final num latitude;
  final num longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignalValue {
  final List<int> time;
  final List<int> data;

  SignalValue({
    required this.time,
    required this.data,
  });

  factory SignalValue.fromJson(Map<String, dynamic> json) => _$SignalValueFromJson(json);

  Map<String, dynamic> toJson() => _$SignalValueToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Signal {
  final String key;
  final SignalValue value;

  Signal({
    required this.key,
    required this.value,
  });

  factory Signal.fromJson(Map<String, dynamic> json) => _$SignalFromJson(json);

  Map<String, dynamic> toJson() => _$SignalToJson(this);
}

enum MeasurementDiagnosis {
  @JsonValue('sinus_arrhythmia')
  sinusArrhythmia,
  @JsonValue('extrasystoles_trig_episode')
  extrasystolesTrigEpisode,
  other,
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
  @JsonValue('atrial_fibrillation')
  noDiagnosis,
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MeasurementCreationData extends CameraData {
  final List<Signal>? signals;
  final MeasurementContext? context;
  late Device? device;
  final Location? location;
  late App? app;
  late List<String>? tags;

  MeasurementCreationData({
    required super.heartrate,
    required super.measurementTimestamp,
    required super.quadrants,
    required super.technicalDetails,
    required super.time,
    required super.yList,
    super.abnormalities,
    super.attempts,
    super.acc,
    super.rotation,
    super.grav,
    super.gyro,
    this.context,
    this.device,
    this.location,
    this.signals,
    this.app,
    this.tags,
  });

  static MeasurementCreationData fromCameraSdk(String cameraMeasurement) {
    var json = jsonDecode(cameraMeasurement);
    var data = json["measurement"] != null ? jsonDecode(json["measurement"]!) : json;
    var mCreationData = MeasurementCreationData.fromJson(data);
    return mCreationData;
  }

  factory MeasurementCreationData.fromJson(Map<String, dynamic> json) => _$MeasurementCreationDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MeasurementCreationDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Diagnosis {
  final String text;
  final List<MeasurementDiagnosis> label;

  Diagnosis({
    required this.text,
    required this.label,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) => _$DiagnosisFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisToJson(this);
}

enum Indicator {
  @JsonValue('no_result')
  noResult,
  normal,
  quality,
  urgent,
  warning,
}

enum AlgoAnalysis {
  premium,
  essential,
  @JsonValue('semicontinuous')
  semiContinuous,
}

enum ReviewType {
  automatic,
  manual,
}

@JsonSerializable(explicitToJson: true)
class MeasurementResponseData extends MeasurementCreationData {
  final Diagnosis? diagnosis;
  final int? af;
  final Indicator? indicator;
  @JsonValue('algo_analysis')
  final AlgoAnalysis? algoAnalysis;
  @JsonValue('review_type')
  final ReviewType? reviewType;

  MeasurementResponseData({
    required super.heartrate,
    required super.measurementTimestamp,
    required super.quadrants,
    required super.technicalDetails,
    required super.time,
    required super.yList,
    super.abnormalities,
    super.attempts,
    super.acc,
    super.rotation,
    super.grav,
    super.gyro,
    super.context,
    required super.device,
    super.location,
    super.signals,
    required super.app,
    super.tags,
    this.diagnosis,
    this.af,
    this.indicator,
    this.algoAnalysis,
    this.reviewType,
  });

  factory MeasurementResponseData.fromJson(Map<String, dynamic> json) => _$MeasurementResponseDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MeasurementResponseDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TransitionLock {
  final DateTime? timestamp;

  TransitionLock({this.timestamp});

  factory TransitionLock.fromJson(Map<String, dynamic> json) => _$TransitionLockFromJson(json);

  Map<String, dynamic> toJson() => _$TransitionLockToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Measurement {
  final String? id;
  final List<String>? userIds;
  final List<String>? groupIds;
  final MeasurementStatus? status;
  final MeasurementResponseData? data;
  final TransitionLock? transitionLock;
  final int? commentCount;
  final DateTime? updateTimestamp;
  final DateTime? creationTimestamp;
  final DateTime? statusChangedTimestamp;
  final String? creatorId;

  Measurement({
    this.id,
    this.userIds,
    this.groupIds,
    this.status,
    this.data,
    this.transitionLock,
    this.commentCount,
    this.updateTimestamp,
    this.creationTimestamp,
    this.statusChangedTimestamp,
    this.creatorId,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) => _$MeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementToJson(this);
}
