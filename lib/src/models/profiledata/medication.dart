// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

import 'profiledata.dart';

part 'medication.g.dart';

@JsonSerializable(explicitToJson: true)
class Medication {
  final String name;
  final Dosis dosis;
  @JsonKey(name: 'medication_frequency')
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
