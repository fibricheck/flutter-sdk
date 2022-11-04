// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

App _$AppFromJson(Map<String, dynamic> json) => App(
      name: json['name'] as String?,
      version: json['version'] as String,
      build: json['build'] as num?,
      branch: json['branch'] as String?,
      cameraSdkVersion: json['cameraSdkVersion'] as String?,
      fibricheckSdkVersion: json['fibricheckSdkVersion'] as String?,
    );

Map<String, dynamic> _$AppToJson(App instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['version'] = instance.version;
  writeNotNull('build', instance.build);
  writeNotNull('branch', instance.branch);
  writeNotNull('cameraSdkVersion', instance.cameraSdkVersion);
  writeNotNull('fibricheckSdkVersion', instance.fibricheckSdkVersion);
  return val;
}
