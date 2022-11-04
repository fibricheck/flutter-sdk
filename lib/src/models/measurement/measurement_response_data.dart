// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';


import 'measurement.dart';


part 'measurement_response_data.g.dart';

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
