// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Measurement _$MeasurementFromJson(Map<String, dynamic> json) => Measurement(
      id: json['id'] as String?,
      userIds:
          (json['userIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
      groupIds: (json['groupIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: $enumDecodeNullable(_$MeasurementStatusEnumMap, json['status']),
      data: json['data'] == null
          ? null
          : MeasurementResponseData.fromJson(
              json['data'] as Map<String, dynamic>),
      transitionLock: json['transitionLock'] == null
          ? null
          : TransitionLock.fromJson(
              json['transitionLock'] as Map<String, dynamic>),
      commentCount: json['commentCount'] as int?,
      updateTimestamp: json['updateTimestamp'] == null
          ? null
          : DateTime.parse(json['updateTimestamp'] as String),
      creationTimestamp: json['creationTimestamp'] == null
          ? null
          : DateTime.parse(json['creationTimestamp'] as String),
      statusChangedTimestamp: json['statusChangedTimestamp'] == null
          ? null
          : DateTime.parse(json['statusChangedTimestamp'] as String),
      creatorId: json['creatorId'] as String?,
    );

Map<String, dynamic> _$MeasurementToJson(Measurement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userIds': instance.userIds,
      'groupIds': instance.groupIds,
      'status': _$MeasurementStatusEnumMap[instance.status],
      'data': instance.data?.toJson(),
      'transitionLock': instance.transitionLock?.toJson(),
      'commentCount': instance.commentCount,
      'updateTimestamp': instance.updateTimestamp?.toIso8601String(),
      'creationTimestamp': instance.creationTimestamp?.toIso8601String(),
      'statusChangedTimestamp':
          instance.statusChangedTimestamp?.toIso8601String(),
      'creatorId': instance.creatorId,
    };

const _$MeasurementStatusEnumMap = {
  MeasurementStatus.measured: 'measured',
  MeasurementStatus.preprocessingSelection: 'preprocessing_selection',
  MeasurementStatus.analysisSelection: 'analysis_selection',
  MeasurementStatus.pendingAnalysis: 'pending_analysis',
  MeasurementStatus.underAnalysis: 'under_analysis',
  MeasurementStatus.analysisFailed: 'analysis_failed',
  MeasurementStatus.processingResults: 'processing_results',
  MeasurementStatus.analyzed: 'analyzed',
  MeasurementStatus.pendingReview: 'pending_review',
  MeasurementStatus.reviewed: 'reviewed',
};
