// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fibricheck_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FibricheckInfo _$FibricheckInfoFromJson(Map<String, dynamic> json) =>
    FibricheckInfo(
      app: json['app'] == null
          ? null
          : App.fromJson(json['app'] as Map<String, dynamic>),
      device: json['device'] == null
          ? null
          : Device.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FibricheckInfoToJson(FibricheckInfo instance) =>
    <String, dynamic>{
      'app': instance.app?.toJson(),
      'device': instance.device?.toJson(),
    };
