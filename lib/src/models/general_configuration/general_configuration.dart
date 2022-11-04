
// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'general_configuration.g.dart';

@JsonSerializable(explicitToJson: true)
class GeneralConfiguration {
  final String? id;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? userConfiguration;
  final Map<String, dynamic>? groupConfiguration;
  final Map<String, dynamic>? staffConfiguration;
  final Map<String, dynamic>? patientConfiguration;
  final DateTime? updateTimestamp;
  final DateTime? creationTimestamp;
  
  GeneralConfiguration({
    this.id,
    this.data,
    this.userConfiguration,
    this.groupConfiguration,
    this.staffConfiguration,
    this.patientConfiguration,
    this.updateTimestamp,
    this.creationTimestamp,
  });

  factory GeneralConfiguration.fromJson(Map<String, dynamic> json) => _$GeneralConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralConfigurationToJson(this);
}
