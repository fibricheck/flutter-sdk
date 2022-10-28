// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

import 'measurement.dart';

part 'signal.g.dart';

@JsonSerializable(explicitToJson: true)
class Signal {
  final String key;
  final SignalValue value;

  Signal({
    required this.key,
    required this.value,
  });

  factory Signal.fromJson(Map<String, dynamic> json) => _$SignalFromJson(json);

  Map<String, dynamic> toJson() => _$SignalToJson(this);
}
