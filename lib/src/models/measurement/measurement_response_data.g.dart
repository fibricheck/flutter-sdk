// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementResponseData _$MeasurementResponseDataFromJson(
        Map<String, dynamic> json) =>
    MeasurementResponseData(
      heartrate: json['heartrate'] as num?,
      measurementTimestamp: json['measurement_timestamp'] as num?,
      quadrants: (json['quadrants'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => Yuv.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      technicalDetails: json['technical_details'] == null
          ? null
          : TechnicalDetails.fromJson(
              json['technical_details'] as Map<String, dynamic>),
      time: (json['time'] as List<dynamic>?)?.map((e) => e as num).toList(),
      yList: (json['yList'] as List<dynamic>?)?.map((e) => e as num).toList(),
      abnormalities: (json['abnormalities'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$AbnormalitiesEnumMap, e))
          .toList(),
      attempts: json['attempts'] as num?,
      acc: json['acc'] == null
          ? null
          : MotionData.fromJson(json['acc'] as Map<String, dynamic>),
      rotation: json['rotation'] == null
          ? null
          : MotionData.fromJson(json['rotation'] as Map<String, dynamic>),
      grav: json['grav'] == null
          ? null
          : MotionData.fromJson(json['grav'] as Map<String, dynamic>),
      gyro: json['gyro'] == null
          ? null
          : MotionData.fromJson(json['gyro'] as Map<String, dynamic>),
      context: json['context'] == null
          ? null
          : MeasurementContext.fromJson(
              json['context'] as Map<String, dynamic>),
      device: json['device'] == null
          ? null
          : Device.fromJson(json['device'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      signals: (json['signals'] as List<dynamic>?)
          ?.map((e) => Signal.fromJson(e as Map<String, dynamic>))
          .toList(),
      app: json['app'] == null
          ? null
          : App.fromJson(json['app'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      diagnosis: json['diagnosis'] == null
          ? null
          : Diagnosis.fromJson(json['diagnosis'] as Map<String, dynamic>),
      af: json['af'] as int?,
      indicator: $enumDecodeNullable(_$IndicatorEnumMap, json['indicator']),
      algoAnalysis:
          $enumDecodeNullable(_$AlgoAnalysisEnumMap, json['algoAnalysis']),
      reviewType: $enumDecodeNullable(_$ReviewTypeEnumMap, json['reviewType']),
    );

Map<String, dynamic> _$MeasurementResponseDataToJson(
        MeasurementResponseData instance) =>
    <String, dynamic>{
      'acc': instance.acc?.toJson(),
      'rotation': instance.rotation?.toJson(),
      'grav': instance.grav?.toJson(),
      'gyro': instance.gyro?.toJson(),
      'heartrate': instance.heartrate,
      'measurement_timestamp': instance.measurementTimestamp,
      'quadrants': instance.quadrants
          ?.map((e) => e.map((e) => e.toJson()).toList())
          .toList(),
      'technical_details': instance.technicalDetails?.toJson(),
      'time': instance.time,
      'yList': instance.yList,
      'abnormalities': instance.abnormalities
          ?.map((e) => _$AbnormalitiesEnumMap[e]!)
          .toList(),
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
      'algoAnalysis': _$AlgoAnalysisEnumMap[instance.algoAnalysis],
      'reviewType': _$ReviewTypeEnumMap[instance.reviewType],
    };

const _$AbnormalitiesEnumMap = {
  Abnormalities.inverted: 'inverted',
  Abnormalities.badSignalQuality: 'bad_signal_quality',
  Abnormalities.pulseNotFound: 'pulse_not_found',
  Abnormalities.saturatedRgb: 'saturated_rgb',
  Abnormalities.qualityFlag: 'quality_flag',
  Abnormalities.fingerNotFound: 'finger_not_found',
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
  AlgoAnalysis.semiContinuous: 'semicontinuous',
};

const _$ReviewTypeEnumMap = {
  ReviewType.automatic: 'automatic',
  ReviewType.manual: 'manual',
};
