// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

import 'measurement.dart';

part 'camera_data.g.dart';

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
