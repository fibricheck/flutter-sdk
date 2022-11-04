// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      manufacturer: json['manufacturer'] as String?,
      model: json['model'] as String?,
      os: json['os'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'os': instance.os,
      'type': instance.type,
    };
