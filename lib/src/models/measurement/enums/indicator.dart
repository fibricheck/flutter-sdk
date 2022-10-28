// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

enum Indicator {
  @JsonValue('no_result')
  noResult,
  normal,
  quality,
  urgent,
  warning,
}
