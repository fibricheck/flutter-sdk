// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CameraData _$CameraDataFromJson(Map<String, dynamic> json) => CameraData(
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
    );

Map<String, dynamic> _$CameraDataToJson(CameraData instance) =>
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
    };

const _$AbnormalitiesEnumMap = {
  Abnormalities.inverted: 'inverted',
  Abnormalities.badSignalQuality: 'bad_signal_quality',
  Abnormalities.pulseNotFound: 'pulse_not_found',
  Abnormalities.saturatedRgb: 'saturated_rgb',
  Abnormalities.qualityFlag: 'quality_flag',
  Abnormalities.fingerNotFound: 'finger_not_found',
};
