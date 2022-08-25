// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

import 'measurement.dart';

part 'profiledata.g.dart';

enum Comorbidities {
  @JsonValue('HEART_FAILURE')
  heartFailure,
  @JsonValue('DIABETES')
  diabetes,
  @JsonValue('COPD')
  copd,
  @JsonValue('HYPERTENSION')
  hypertension,
  @JsonValue('VASCULAR_DISEASE')
  vascularDisease,
  @JsonValue('HISTORY_OF_TIA_STROKE')
  historyOfTiaStroke,
}

enum ProfileActivity {
  @JsonValue('NOT_ACTIVE')
  notActive,
  @JsonValue('SLIGHTLY_ACTIVE')
  slightlyActive,
  @JsonValue('MODERATELY_ACTIVE')
  moderatelyActive,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('VERY_ACTIVE')
  veryActive,
}

enum Impediments {
  @JsonValue('TREMOR')
  tremor,
  @JsonValue('PERNIOSIS')
  perniosis,
  @JsonValue('CALLUS')
  callus,
}

enum MedicationUnit {
  mg,
  ml,
  pill,
}

enum MedicationFrequency {
  @JsonValue('AS_NEEDED')
  asNeeded,
  @JsonValue('EVERY_DAY')
  everyDay,
  @JsonValue('EVERY_WEEK')
  everyWeek,
  @JsonValue('EVERY_MONTH')
  everyMonth,
  @JsonValue('BIRTH_CONTROL')
  birthControl,
}

@JsonSerializable(explicitToJson: true)
class Dosis {
  final int? number;
  final MedicationUnit? unit;

  Dosis({
    this.number,
    this.unit,
  });

  factory Dosis.fromJson(Map<String, dynamic> json) => _$DosisFromJson(json);

  Map<String, dynamic> toJson() => _$DosisToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Medication {
  final String name;
  final Dosis dosis;
  @JsonValue('medication_frequency')
  final MedicationFrequency? medicationFrequency;
  final int count;

  Medication({
    required this.name,
    required this.dosis,
    this.medicationFrequency,
    required this.count,
  });

  factory Medication.fromJson(Map<String, dynamic> json) => _$MedicationFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Group {
  final String? groupId;
  final String? reason;
  @JsonValue('patient_id')
  final String? patientId;
  @JsonValue('custom_fields')
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

@JsonSerializable(explicitToJson: true)
class FibricheckInfo {
  final App? app;
  final Device? device;

  FibricheckInfo({
    this.app,
    this.device,
  });

  factory FibricheckInfo.fromJson(Map<String, dynamic> json) => _$FibricheckInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FibricheckInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfileData {
  final String? country;
  final String? region;
  @JsonValue('address_line1')
  final String? addressLine1;
  @JsonValue('address_line2')
  final String? addressLine2;
  final String? city;
  @JsonValue('postal_code')
  final String? postalCode;
  final int? weight;
  final int? length;
  final String? birthday;
  final int? gender;
  final List<Comorbidities>? comorbidities;
  final String? physician;
  final bool? smoker;
  final ProfileActivity? activity;
  @JsonValue('fibricheck_info')
  final FibricheckInfo? fibricheckInfo;
  final List<Impediments>? impediments;
  @JsonValue('custom_fields')
  final Map<String, String>? customFields;
  final bool? afHistory;
  final List<Medication>? medication;
  final List<Group>? groups;
  @JsonValue('creation_timestamp')
  final DateTime? creationTimestamp;
  @JsonValue('update_timestamp')
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
