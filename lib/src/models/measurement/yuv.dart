// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'yuv.g.dart';

@JsonSerializable(explicitToJson: true)
class Yuv {
  final String? id;
  final List<num>? u;
  final List<num>? v;
  final List<num>? y;

  Yuv({
    this.u,
    this.v,
    this.y,
    this.id,
  });

  factory Yuv.fromJson(Map<String, dynamic> json) => _$YuvFromJson(json);

  Map<String, dynamic> toJson() => _$YuvToJson(this);
}
