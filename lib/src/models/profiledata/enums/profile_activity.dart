// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

enum ProfileActivity {
  @JsonValue('NOT_ACTIVE')
  notActive,
  @JsonValue('SLIGHTLY_ACTIVE')
  slightlyActive,
  @JsonValue('MODERATELY_ACTIVE')
  moderatelyActive,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('VERY_ACTIVE')
  veryActive,
}
