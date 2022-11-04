// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

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
