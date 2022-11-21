// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'periodic_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodicReport _$PeriodicReportFromJson(Map<String, dynamic> json) =>
    PeriodicReport(
      json['id'] as String,
      json['status'] as String,
      $enumDecode(_$ReportTriggerEnumMap, json['trigger']),
      json['creation_timestamp'] as num,
    );

Map<String, dynamic> _$PeriodicReportToJson(PeriodicReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'trigger': _$ReportTriggerEnumMap[instance.trigger]!,
      'creation_timestamp': instance.creationTimestamp,
    };

const _$ReportTriggerEnumMap = {
  ReportTrigger.periodDaysPassed7: 'PERIOD_DAYS_PASSED_7',
  ReportTrigger.periodDaysPassed30: 'PERIOD_DAYS_PASSED_30',
  ReportTrigger.prescriptionEnded: 'PRESCRIPTION_ENDED',
};
