// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'app.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class App {
  final String? name;
  final String version;
  final num? build;
  final String? branch;
  @JsonValue('camera_sdk_version')
  final String? cameraSdkVersion;
  @JsonValue('fibricheck_sdk_version')
  final String? fibricheckSdkVersion;

  App({
    this.name,
    required this.version,
    this.build,
    this.branch,
    this.cameraSdkVersion,
    this.fibricheckSdkVersion,
  });

  factory App.fromJson(Map<String, dynamic> json) => _$AppFromJson(json);

  Map<String, dynamic> toJson() => _$AppToJson(this);
}
