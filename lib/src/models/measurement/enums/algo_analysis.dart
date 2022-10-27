// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

enum AlgoAnalysis {
  premium,
  essential,
  @JsonValue('semicontinuous')
  semiContinuous,
}