// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'user_configuration.g.dart';

@JsonSerializable(explicitToJson: true)
class UserConfiguration {
  final String? id;
  final Map<String, dynamic>? data;
  final List<Map<String, dynamic>>? staffConfigurations;
  final List<Map<String, dynamic>>? patientConfigurations;
  final DateTime? updateTimestamp;
  final DateTime? creationTimestamp;

  UserConfiguration({
    this.id,
    this.data,
    this.staffConfigurations,
    this.patientConfigurations,
    this.updateTimestamp,
    this.creationTimestamp,
  });

  factory UserConfiguration.fromJson(Map<String, dynamic> json) => _$UserConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$UserConfigurationToJson(this);
}
