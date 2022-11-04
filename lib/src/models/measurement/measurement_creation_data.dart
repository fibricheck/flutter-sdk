// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

import 'measurement.dart';

part 'measurement_creation_data.g.dart';

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

  static MeasurementCreationData fromCameraSdk(Map<String, dynamic> cameraMeasurement) {
    var mCreationData = MeasurementCreationData.fromJson(cameraMeasurement);
    return mCreationData;
  }

  factory MeasurementCreationData.fromJson(Map<String, dynamic> json) => _$MeasurementCreationDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MeasurementCreationDataToJson(this);
}
