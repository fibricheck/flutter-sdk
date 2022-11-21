// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable(explicitToJson: true)
class Group {
  final String? groupId;
  final String? reason;
  @JsonKey(name: 'patient_id')
  final String? patientId;
  @JsonKey(name: 'custom_fields')
  final Map<String, String>? customFields;

  Group({
    this.groupId,
    this.reason,
    this.patientId,
    this.customFields,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
