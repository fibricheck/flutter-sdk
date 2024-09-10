// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technical_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TechnicalDetails _$TechnicalDetailsFromJson(Map<String, dynamic> json) =>
    TechnicalDetails(
      cameraExposureTime: json['camera_exposure_time'] as num?,
      cameraHardwareLevel: json['camera_hardware_level'] as String?,
      cameraIso: json['camera_iso'] as num?,
      cameraResolution: json['camera_resolution'] as String?,
    );

Map<String, dynamic> _$TechnicalDetailsToJson(TechnicalDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('camera_exposure_time', instance.cameraExposureTime);
  writeNotNull('camera_hardware_level', instance.cameraHardwareLevel);
  writeNotNull('camera_iso', instance.cameraIso);
  writeNotNull('camera_resolution', instance.cameraResolution);
  return val;
}
