// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

enum ReportTrigger {
  @JsonValue('PERIOD_DAYS_PASSED_7')
  periodDaysPassed7,
  @JsonValue('PERIOD_DAYS_PASSED_30')
  periodDaysPassed30,
  @JsonValue('PRESCRIPTION_ENDED')
  prescriptionEnded,
}

@JsonSerializable(explicitToJson: true)
class PeriodicReport {
  final String id;
  final String status;
  final ReportTrigger trigger;
  @JsonKey(name: 'creation_timestamp')
  final num creationTimestamp;

  PeriodicReport(
    this.id,
    this.status,
    this.trigger,
    this.creationTimestamp,
  );

  factory PeriodicReport.fromJson(Map<String, dynamic> json) => _$PeriodicReportFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodicReportToJson(this);
}
