// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'technical_details.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TechnicalDetails {
  @JsonKey(name: 'camera_exposure_time')
  final num? cameraExposureTime;
  @JsonKey(name: 'camera_hardware_level')
  final String? cameraHardwareLevel;
  @JsonKey(name: 'camera_iso')
  final num? cameraIso;
  @JsonKey(name: 'camera_resolution')
  final String? cameraResolution;

  TechnicalDetails({
    required this.cameraExposureTime,
    required this.cameraHardwareLevel,
    required this.cameraIso,
    required this.cameraResolution,
  });

  factory TechnicalDetails.fromJson(Map<String, dynamic> json) => _$TechnicalDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicalDetailsToJson(this);
}
