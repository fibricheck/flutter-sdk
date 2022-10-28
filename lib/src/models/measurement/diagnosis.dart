// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

import 'measurement.dart';

part 'diagnosis.g.dart';

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
