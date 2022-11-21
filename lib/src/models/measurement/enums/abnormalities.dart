// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

enum Abnormalities {
  inverted,
  @JsonValue('bad_signal_quality')
  badSignalQuality,
  @JsonValue('pulse_not_found')
  pulseNotFound,
  @JsonValue('saturated_rgb')
  saturatedRgb,
  @JsonValue('quality_flag')
  qualityFlag,
  @JsonValue('finger_not_found')
  fingerNotFound,
}
