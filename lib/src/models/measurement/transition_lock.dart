// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'transition_lock.g.dart';

@JsonSerializable(explicitToJson: true)
class TransitionLock {
  final DateTime? timestamp;

  TransitionLock({this.timestamp});

  factory TransitionLock.fromJson(Map<String, dynamic> json) => _$TransitionLockFromJson(json);

  Map<String, dynamic> toJson() => _$TransitionLockToJson(this);
}
