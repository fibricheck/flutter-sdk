// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

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
