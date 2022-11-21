// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_creation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementCreationData _$MeasurementCreationDataFromJson(
        Map<String, dynamic> json) =>
    MeasurementCreationData(
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
    );

Map<String, dynamic> _$MeasurementCreationDataToJson(
    MeasurementCreationData instance) {
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
  writeNotNull(
      'quadrants',
      instance.quadrants
          ?.map((e) => e.map((e) => e.toJson()).toList())
          .toList());
  writeNotNull('technical_details', instance.technicalDetails?.toJson());
  writeNotNull('time', instance.time);
  writeNotNull('yList', instance.yList);
  writeNotNull('abnormalities',
      instance.abnormalities?.map((e) => _$AbnormalitiesEnumMap[e]!).toList());
  writeNotNull('attempts', instance.attempts);
  writeNotNull('signals', instance.signals?.map((e) => e.toJson()).toList());
  writeNotNull('context', instance.context?.toJson());
  writeNotNull('device', instance.device?.toJson());
  writeNotNull('location', instance.location?.toJson());
  writeNotNull('app', instance.app?.toJson());
  writeNotNull('tags', instance.tags);
  return val;
}

const _$AbnormalitiesEnumMap = {
  Abnormalities.inverted: 'inverted',
  Abnormalities.badSignalQuality: 'bad_signal_quality',
  Abnormalities.pulseNotFound: 'pulse_not_found',
  Abnormalities.saturatedRgb: 'saturated_rgb',
  Abnormalities.qualityFlag: 'quality_flag',
  Abnormalities.fingerNotFound: 'finger_not_found',
};
