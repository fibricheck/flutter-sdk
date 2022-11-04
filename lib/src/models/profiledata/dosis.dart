// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

import 'profiledata.dart';

part 'dosis.g.dart';

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
