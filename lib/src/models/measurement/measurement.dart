// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

import 'enums/measurement_diagnosis.dart';
import 'enums/measurement_status.dart';
import 'measurement_response_data.dart';
import 'transition_lock.dart';

export 'enums/measurement_status.dart';
export 'enums/abnormalities.dart';
export 'enums/activity.dart';
export 'enums/algo_analysis.dart';
export 'enums/measurement_diagnosis.dart';
export 'enums/measurement_diagnosis.dart';
export 'enums/review_type.dart';
export 'enums/symptoms.dart';
export 'enums/symptom_severity.dart';
export 'enums/indicator.dart';

export 'app.dart';
export 'camera_data.dart';
export 'device.dart';
export 'diagnosis.dart';
export 'location.dart';
export 'measurement_context.dart';
export 'measurement_creation_data.dart';
export 'measurement_response_data.dart';
export 'motion_data.dart';
export 'signal.dart';
export 'signal_value.dart';
export 'technical_details.dart';
export 'transition_lock.dart';
export 'yuv.dart';

part 'measurement.g.dart';

@JsonSerializable(explicitToJson: true)
class Measurement {
  final String? id;
  final List<String>? userIds;
  final List<String>? groupIds;
  final MeasurementStatus? status;
  final MeasurementResponseData? data;
  final TransitionLock? transitionLock;
  final int? commentCount;
  final DateTime? updateTimestamp;
  final DateTime? creationTimestamp;
  final DateTime? statusChangedTimestamp;
  final String? creatorId;

  Measurement({
    this.id,
    this.userIds,
    this.groupIds,
    this.status,
    this.data,
    this.transitionLock,
    this.commentCount,
    this.updateTimestamp,
    this.creationTimestamp,
    this.statusChangedTimestamp,
    this.creatorId,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) => _$MeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementToJson(this);

  MeasurementDiagnosis getMostSevereLabel() {
    final labels = data?.diagnosis?.label;

    if (labels == null || labels.isEmpty) {
      return MeasurementDiagnosis.noDiagnosis;
    }

    final copiedLabels = List<MeasurementDiagnosis>.from(labels);
    copiedLabels.sort((label1, label2) => label1.compareTo(label2));
    
    return copiedLabels[0];
  }
}
