// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'signal_value.g.dart';

@JsonSerializable(explicitToJson: true)
class SignalValue {
  final List<int> time;
  final List<int> data;

  SignalValue({
    required this.time,
    required this.data,
  });

  factory SignalValue.fromJson(Map<String, dynamic> json) => _$SignalValueFromJson(json);

  Map<String, dynamic> toJson() => _$SignalValueToJson(this);
}
