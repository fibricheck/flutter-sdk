// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

enum ReportTrigger {
  @JsonValue("PERIOD_DAYS_PASSED_7")
  periodDaysPassed7,
  @JsonValue("PERIOD_DAYS_PASSED_30")
  periodDaysPassed30,
  @JsonValue("PRESCRIPTION_ENDED")
  prescriptionEnded,
}
