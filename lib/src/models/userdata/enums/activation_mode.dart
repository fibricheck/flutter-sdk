// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

enum ActivationMode {
  @JsonValue('hash')
  hash,
  @JsonValue('pin_code')
  pinCode,
  @JsonValue('manual')
  manual,
}
