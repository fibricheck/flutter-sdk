// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

enum SymptomSeverity {
  @JsonValue('1')
  severity_1,
  @JsonValue('2a')
  severity_2a,
  @JsonValue('2b')
  severity_2b,
  @JsonValue('3')
  severity_3,
  @JsonValue('4')
  severity_4,
}
