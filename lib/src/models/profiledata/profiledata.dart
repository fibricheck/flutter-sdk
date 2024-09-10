// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

import 'profiledata.dart';

export 'enums/comorbidities.dart';
export 'enums/impediments.dart';
export 'enums/medication_frequency.dart';
export 'enums/medication_unit.dart';
export 'enums/profile_activity.dart';

export 'dosis.dart';
export 'fibricheck_info.dart';
export 'group.dart';
export 'medication.dart';

part 'profiledata.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileData {
  final String? country;
  final String? region;
  @JsonKey(name: 'address_line1')
  final String? addressLine1;
  @JsonKey(name: 'address_line2')
  final String? addressLine2;
  final String? city;
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  final num? weight;
  final int? length;
  final String? birthday;
  final int? gender;
  final List<Comorbidities>? comorbidities;
  final String? physician;
  final bool? smoker;
  final ProfileActivity? activity;
  @JsonKey(name: 'fibricheck_info')
  final FibricheckInfo? fibricheckInfo;
  final List<Impediments>? impediments;
  @JsonKey(name: 'custom_fields')
  final Map<String, String>? customFields;
  final bool? afHistory;
  final List<Medication>? medication;
  final List<Group>? groups;
  @JsonKey(name: 'creation_timestamp')
  final DateTime? creationTimestamp;
  @JsonKey(name: 'update_timestamp')
  final DateTime? updateTimestamp;

  ProfileData({
    this.country,
    this.region,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.postalCode,
    this.weight,
    this.length,
    this.birthday,
    this.gender,
    this.comorbidities,
    this.physician,
    this.smoker,
    this.activity,
    this.fibricheckInfo,
    this.impediments,
    this.customFields,
    this.afHistory,
    this.medication,
    this.groups,
    this.creationTimestamp,
    this.updateTimestamp,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}
