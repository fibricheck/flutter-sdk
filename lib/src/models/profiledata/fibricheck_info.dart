// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

import '../measurement/measurement.dart';

part 'fibricheck_info.g.dart';

@JsonSerializable(explicitToJson: true)
class FibricheckInfo {
  final App? app;
  final Device? device;

  FibricheckInfo({
    this.app,
    this.device,
  });

  factory FibricheckInfo.fromJson(Map<String, dynamic> json) => _$FibricheckInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FibricheckInfoToJson(this);
}
