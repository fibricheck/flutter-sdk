// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

enum MeasurementStatus {
  measured,
  @JsonValue('preprocessing_selection')
  preprocessingSelection,
  @JsonValue('analysis_selection')
  analysisSelection,
  @JsonValue('pending_analysis')
  pendingAnalysis,
  @JsonValue('under_analysis')
  underAnalysis,
  @JsonValue('analysis_failed')
  analysisFailed,
  @JsonValue('processing_results')
  processingResults,
  analyzed,
  @JsonValue('pending_review')
  pendingReview,
  reviewed,
}
