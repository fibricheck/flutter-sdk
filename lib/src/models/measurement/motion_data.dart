// ignore_for_file: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'motion_data.g.dart';

@JsonSerializable()
class MotionData {
  final List<num> x;
  final List<num> y;
  final List<num> z;

  MotionData({
    required this.x,
    required this.y,
    required this.z,
  });

  factory MotionData.fromJson(Map<String, dynamic> json) => _$MotionDataFromJson(json);

  Map<String, dynamic> toJson() => _$MotionDataToJson(this);
}
