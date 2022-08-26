// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MotionData _$MotionDataFromJson(Map<String, dynamic> json) => MotionData(
      x: (json['x'] as List<dynamic>).map((e) => e as int).toList(),
      y: (json['y'] as List<dynamic>).map((e) => e as int).toList(),
      z: (json['z'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$MotionDataToJson(MotionData instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
    };

Yuv _$YuvFromJson(Map<String, dynamic> json) => Yuv(
      u: (json['u'] as List<dynamic>?)?.map((e) => e as num).toList(),
      v: (json['v'] as List<dynamic>?)?.map((e) => e as num).toList(),
      y: (json['y'] as List<dynamic>?)?.map((e) => e as num).toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$YuvToJson(Yuv instance) => <String, dynamic>{
      'id': instance.id,
      'u': instance.u,
      'v': instance.v,
      'y': instance.y,
    };

TechnicalDetails _$TechnicalDetailsFromJson(Map<String, dynamic> json) => TechnicalDetails(
      cameraExposureTime: json['camera_exposure_time'] as int,
      cameraHardwareLevel: json['camera_hardware_level'] as String,
      cameraIso: json['camera_iso'] as int,
    );

Map<String, dynamic> _$TechnicalDetailsToJson(TechnicalDetails instance) => <String, dynamic>{
      'camera_exposure_time': instance.cameraExposureTime,
      'camera_hardware_level': instance.cameraHardwareLevel,
      'camera_iso': instance.cameraIso,
    };

CameraData _$CameraDataFromJson(Map<String, dynamic> json) => CameraData(
      heartrate: json['heartrate'] as num?,
      measurementTimestamp: json['measurement_timestamp'] as num?,
      quadrants: (json['quadrants'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => Yuv.fromJson(e as Map<String, dynamic>)).toList())
          .toList(),
      technicalDetails: json['technical_details'] == null
          ? null
          : TechnicalDetails.fromJson(json['technical_details'] as Map<String, dynamic>),
      time: (json['time'] as List<dynamic>?)?.map((e) => e as num).toList(),
      yList: (json['yList'] as List<dynamic>?)?.map((e) => e as num).toList(),
      abnormalities:
          (json['abnormalities'] as List<dynamic>?)?.map((e) => $enumDecode(_$AbnormalitiesEnumMap, e)).toList(),
      attempts: json['attempts'] as num?,
      acc: json['acc'] == null ? null : MotionData.fromJson(json['acc'] as Map<String, dynamic>),
      rotation: json['rotation'] == null ? null : MotionData.fromJson(json['rotation'] as Map<String, dynamic>),
      grav: json['grav'] == null ? null : MotionData.fromJson(json['grav'] as Map<String, dynamic>),
      gyro: json['gyro'] == null ? null : MotionData.fromJson(json['gyro'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CameraDataToJson(CameraData instance) => <String, dynamic>{
      'acc': instance.acc?.toJson(),
      'rotation': instance.rotation?.toJson(),
      'grav': instance.grav?.toJson(),
      'gyro': instance.gyro?.toJson(),
      'heartrate': instance.heartrate,
      'measurement_timestamp': instance.measurementTimestamp,
      'quadrants': instance.quadrants?.map((e) => e.map((e) => e.toJson()).toList()).toList(),
      'technical_details': instance.technicalDetails?.toJson(),
      'time': instance.time,
      'yList': instance.yList,
      'abnormalities': instance.abnormalities?.map((e) => _$AbnormalitiesEnumMap[e]!).toList(),
      'attempts': instance.attempts,
    };

const _$AbnormalitiesEnumMap = {
  Abnormalities.inverted: 'inverted',
  Abnormalities.badSignalQuality: 'bad_signal_quality',
  Abnormalities.pulseNotFound: 'pulse_not_found',
  Abnormalities.saturatedRgb: 'saturated_rgb',
  Abnormalities.qualityFlag: 'quality_flag',
  Abnormalities.fingerNotFound: 'finger_not_found',
};

MeasurementContext _$MeasurementContextFromJson(Map<String, dynamic> json) => MeasurementContext(
      symptoms: (json['symptoms'] as List<dynamic>?)?.map((e) => $enumDecode(_$SymptomsEnumMap, e)).toList(),
      activity: $enumDecodeNullable(_$ActivityEnumMap, json['activity']),
      symptomSeverity: $enumDecodeNullable(_$SymptomSeverityEnumMap, json['symptomSeverity']),
    );

Map<String, dynamic> _$MeasurementContextToJson(MeasurementContext instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('symptoms', instance.symptoms?.map((e) => _$SymptomsEnumMap[e]!).toList());
  writeNotNull('activity', _$ActivityEnumMap[instance.activity]);
  writeNotNull('symptomSeverity', _$SymptomSeverityEnumMap[instance.symptomSeverity]);
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

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      manufacturer: json['manufacturer'] as String?,
      model: json['model'] as String?,
      os: json['os'] as String?,
      type: $enumDecodeNullable(_$DeviceTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'os': instance.os,
      'type': _$DeviceTypeEnumMap[instance.type],
    };

const _$DeviceTypeEnumMap = {
  DeviceType.android: 'android',
  DeviceType.ios: 'ios',
};

App _$AppFromJson(Map<String, dynamic> json) => App(
      name: json['name'] as String?,
      version: json['version'] as String,
      build: json['build'] as num?,
      branch: json['branch'] as String?,
      cameraSdkVersion: json['camera_sdk_version'] as String?,
      fibricheckSdkVersion: json['fibricheck_sdk_version'] as String?,
    );

Map<String, dynamic> _$AppToJson(App instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['version'] = instance.version;
  writeNotNull('build', instance.build);
  writeNotNull('branch', instance.branch);
  writeNotNull('camera_sdk_version', instance.cameraSdkVersion);
  writeNotNull('fibricheck_sdk_version', instance.fibricheckSdkVersion);
  return val;
}

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      latitude: json['latitude'] as int,
      longitude: json['longitude'] as int,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

SignalValue _$SignalValueFromJson(Map<String, dynamic> json) => SignalValue(
      time: (json['time'] as List<dynamic>).map((e) => e as int).toList(),
      data: (json['data'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$SignalValueToJson(SignalValue instance) => <String, dynamic>{
      'time': instance.time,
      'data': instance.data,
    };

Signal _$SignalFromJson(Map<String, dynamic> json) => Signal(
      key: json['key'] as String,
      value: SignalValue.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignalToJson(Signal instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value.toJson(),
    };

MeasurementCreationData _$MeasurementCreationDataFromJson(Map<String, dynamic> json) => MeasurementCreationData(
      heartrate: json['heartrate'] as num?,
      measurementTimestamp: json['measurement_timestamp'] as num?,
      quadrants: (json['quadrants'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => Yuv.fromJson(e as Map<String, dynamic>)).toList())
          .toList(),
      technicalDetails: json['technical_details'] == null
          ? null
          : TechnicalDetails.fromJson(json['technical_details'] as Map<String, dynamic>),
      time: (json['time'] as List<dynamic>?)?.map((e) => e as num).toList(),
      yList: (json['yList'] as List<dynamic>?)?.map((e) => e as num).toList(),
      abnormalities:
          (json['abnormalities'] as List<dynamic>?)?.map((e) => $enumDecode(_$AbnormalitiesEnumMap, e)).toList(),
      attempts: json['attempts'] as num?,
      acc: json['acc'] == null ? null : MotionData.fromJson(json['acc'] as Map<String, dynamic>),
      rotation: json['rotation'] == null ? null : MotionData.fromJson(json['rotation'] as Map<String, dynamic>),
      grav: json['grav'] == null ? null : MotionData.fromJson(json['grav'] as Map<String, dynamic>),
      gyro: json['gyro'] == null ? null : MotionData.fromJson(json['gyro'] as Map<String, dynamic>),
      context: json['context'] == null ? null : MeasurementContext.fromJson(json['context'] as Map<String, dynamic>),
      device: json['device'] == null ? null : Device.fromJson(json['device'] as Map<String, dynamic>),
      location: json['location'] == null ? null : Location.fromJson(json['location'] as Map<String, dynamic>),
      signals: (json['signals'] as List<dynamic>?)?.map((e) => Signal.fromJson(e as Map<String, dynamic>)).toList(),
      app: json['app'] == null ? null : App.fromJson(json['app'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MeasurementCreationDataToJson(MeasurementCreationData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('acc', instance.acc?.toJson());
  writeNotNull('rotation', instance.rotation?.toJson());
  writeNotNull('grav', instance.grav?.toJson());
  writeNotNull('gyro', instance.gyro?.toJson());
  writeNotNull('heartrate', instance.heartrate);
  writeNotNull('measurement_timestamp', instance.measurementTimestamp);
  writeNotNull('quadrants', instance.quadrants?.map((e) => e.map((e) => e.toJson()).toList()).toList());
  writeNotNull('technical_details', instance.technicalDetails?.toJson());
  writeNotNull('time', instance.time);
  writeNotNull('yList', instance.yList);
  writeNotNull('abnormalities', instance.abnormalities?.map((e) => _$AbnormalitiesEnumMap[e]!).toList());
  writeNotNull('attempts', instance.attempts);
  writeNotNull('signals', instance.signals?.map((e) => e.toJson()).toList());
  writeNotNull('context', instance.context?.toJson());
  writeNotNull('device', instance.device?.toJson());
  writeNotNull('location', instance.location?.toJson());
  writeNotNull('app', instance.app?.toJson());
  writeNotNull('tags', instance.tags);
  return val;
}

Diagnosis _$DiagnosisFromJson(Map<String, dynamic> json) => Diagnosis(
      text: json['text'] as String,
      label: (json['label'] as List<dynamic>).map((e) => $enumDecode(_$MeasurementDiagnosisEnumMap, e)).toList(),
    );

Map<String, dynamic> _$DiagnosisToJson(Diagnosis instance) => <String, dynamic>{
      'text': instance.text,
      'label': instance.label.map((e) => _$MeasurementDiagnosisEnumMap[e]!).toList(),
    };

const _$MeasurementDiagnosisEnumMap = {
  MeasurementDiagnosis.sinusArrhythmia: 'sinus_arrhythmia',
  MeasurementDiagnosis.extrasystolesTrigEpisode: 'extrasystoles_trig_episode',
  MeasurementDiagnosis.other: 'other',
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
  MeasurementDiagnosis.noDiagnosis: 'no_diagnosis',
};

MeasurementResponseData _$MeasurementResponseDataFromJson(Map<String, dynamic> json) => MeasurementResponseData(
      heartrate: json['heartrate'] as num?,
      measurementTimestamp: json['measurement_timestamp'] as num?,
      quadrants: (json['quadrants'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => Yuv.fromJson(e as Map<String, dynamic>)).toList())
          .toList(),
      technicalDetails: json['technical_details'] == null
          ? null
          : TechnicalDetails.fromJson(json['technical_details'] as Map<String, dynamic>),
      time: (json['time'] as List<dynamic>?)?.map((e) => e as num).toList(),
      yList: (json['yList'] as List<dynamic>?)?.map((e) => e as num).toList(),
      abnormalities:
          (json['abnormalities'] as List<dynamic>?)?.map((e) => $enumDecode(_$AbnormalitiesEnumMap, e)).toList(),
      attempts: json['attempts'] as num?,
      acc: json['acc'] == null ? null : MotionData.fromJson(json['acc'] as Map<String, dynamic>),
      rotation: json['rotation'] == null ? null : MotionData.fromJson(json['rotation'] as Map<String, dynamic>),
      grav: json['grav'] == null ? null : MotionData.fromJson(json['grav'] as Map<String, dynamic>),
      gyro: json['gyro'] == null ? null : MotionData.fromJson(json['gyro'] as Map<String, dynamic>),
      context: json['context'] == null ? null : MeasurementContext.fromJson(json['context'] as Map<String, dynamic>),
      device: json['device'] == null ? null : Device.fromJson(json['device'] as Map<String, dynamic>),
      location: json['location'] == null ? null : Location.fromJson(json['location'] as Map<String, dynamic>),
      signals: (json['signals'] as List<dynamic>?)?.map((e) => Signal.fromJson(e as Map<String, dynamic>)).toList(),
      app: json['app'] == null ? null : App.fromJson(json['app'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      diagnosis: json['diagnosis'] == null ? null : Diagnosis.fromJson(json['diagnosis'] as Map<String, dynamic>),
      af: json['af'] as int?,
      indicator: $enumDecodeNullable(_$IndicatorEnumMap, json['indicator']),
      algoAnalysis: $enumDecodeNullable(_$AlgoAnalysisEnumMap, json['algo_analysis']),
      reviewType: $enumDecodeNullable(_$ReviewTypeEnumMap, json['review_type']),
    );

Map<String, dynamic> _$MeasurementResponseDataToJson(MeasurementResponseData instance) => <String, dynamic>{
      'acc': instance.acc?.toJson(),
      'rotation': instance.rotation?.toJson(),
      'grav': instance.grav?.toJson(),
      'gyro': instance.gyro?.toJson(),
      'heartrate': instance.heartrate,
      'measurement_timestamp': instance.measurementTimestamp,
      'quadrants': instance.quadrants?.map((e) => e.map((e) => e.toJson()).toList()).toList(),
      'technical_details': instance.technicalDetails?.toJson(),
      'time': instance.time,
      'yList': instance.yList,
      'abnormalities': instance.abnormalities?.map((e) => _$AbnormalitiesEnumMap[e]!).toList(),
      'attempts': instance.attempts,
      'signals': instance.signals?.map((e) => e.toJson()).toList(),
      'context': instance.context?.toJson(),
      'device': instance.device?.toJson(),
      'location': instance.location?.toJson(),
      'app': instance.app?.toJson(),
      'tags': instance.tags,
      'diagnosis': instance.diagnosis?.toJson(),
      'af': instance.af,
      'indicator': _$IndicatorEnumMap[instance.indicator],
      'algo_analysis': _$AlgoAnalysisEnumMap[instance.algoAnalysis],
      'review_type': _$ReviewTypeEnumMap[instance.reviewType],
    };

const _$IndicatorEnumMap = {
  Indicator.noResult: 'no_result',
  Indicator.normal: 'normal',
  Indicator.quality: 'quality',
  Indicator.urgent: 'urgent',
  Indicator.warning: 'warning',
};

const _$AlgoAnalysisEnumMap = {
  AlgoAnalysis.premium: 'premium',
  AlgoAnalysis.essential: 'essential',
  AlgoAnalysis.semiContinuous: 'semi_continuous',
};

const _$ReviewTypeEnumMap = {
  ReviewType.automatic: 'automatic',
  ReviewType.manual: 'manual',
};

TransitionLock _$TransitionLockFromJson(Map<String, dynamic> json) => TransitionLock(
      timestamp: json['timestamp'] == null ? null : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$TransitionLockToJson(TransitionLock instance) => <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
    };

Measurement _$MeasurementFromJson(Map<String, dynamic> json) => Measurement(
      id: json['id'] as String?,
      userIds: (json['userIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
      groupIds: (json['groupIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
      status: $enumDecodeNullable(_$MeasurementStatusEnumMap, json['status']),
      data: json['data'] == null ? null : MeasurementResponseData.fromJson(json['data'] as Map<String, dynamic>),
      transitionLock: json['transitionLock'] == null
          ? null
          : TransitionLock.fromJson(json['transitionLock'] as Map<String, dynamic>),
      commentCount: json['commentCount'] as int?,
      updateTimestamp: json['updateTimestamp'] == null ? null : DateTime.parse(json['updateTimestamp'] as String),
      creationTimestamp: json['creationTimestamp'] == null ? null : DateTime.parse(json['creationTimestamp'] as String),
      statusChangedTimestamp:
          json['statusChangedTimestamp'] == null ? null : DateTime.parse(json['statusChangedTimestamp'] as String),
      creatorId: json['creatorId'] as String?,
    );

Map<String, dynamic> _$MeasurementToJson(Measurement instance) => <String, dynamic>{
      'id': instance.id,
      'userIds': instance.userIds,
      'groupIds': instance.groupIds,
      'status': _$MeasurementStatusEnumMap[instance.status],
      'data': instance.data?.toJson(),
      'transitionLock': instance.transitionLock?.toJson(),
      'commentCount': instance.commentCount,
      'updateTimestamp': instance.updateTimestamp?.toIso8601String(),
      'creationTimestamp': instance.creationTimestamp?.toIso8601String(),
      'statusChangedTimestamp': instance.statusChangedTimestamp?.toIso8601String(),
      'creatorId': instance.creatorId,
    };

const _$MeasurementStatusEnumMap = {
  MeasurementStatus.measured: 'measured',
  MeasurementStatus.preprocessingSelection: 'preprocessing_selection',
  MeasurementStatus.analysisSelection: 'analysis_selection',
  MeasurementStatus.pendingAnalysis: 'pending_analysis',
  MeasurementStatus.underAnalysis: 'under_analysis',
  MeasurementStatus.analysisFailed: 'analysis_failed',
  MeasurementStatus.processingResults: 'processing_results',
  MeasurementStatus.analyzed: 'analyzed',
  MeasurementStatus.pendingReview: 'pending_review',
  MeasurementStatus.reviewed: 'reviewed',
};
