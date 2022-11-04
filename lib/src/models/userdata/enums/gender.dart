// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

enum Gender {
  @JsonValue('0')
  notKnown,
  @JsonValue('1')
  male,
  @JsonValue('2')
  female,
  @JsonValue('9')
  notApplicable,
}
