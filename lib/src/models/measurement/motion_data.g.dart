// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motion_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MotionData _$MotionDataFromJson(Map<String, dynamic> json) => MotionData(
      x: (json['x'] as List<dynamic>).map((e) => e as num).toList(),
      y: (json['y'] as List<dynamic>).map((e) => e as num).toList(),
      z: (json['z'] as List<dynamic>).map((e) => e as num).toList(),
    );

Map<String, dynamic> _$MotionDataToJson(MotionData instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
    };
