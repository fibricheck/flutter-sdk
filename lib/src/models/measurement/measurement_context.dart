// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

import 'measurement.dart';

part 'measurement_context.g.dart';

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
