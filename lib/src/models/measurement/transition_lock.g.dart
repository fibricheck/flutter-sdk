// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transition_lock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransitionLock _$TransitionLockFromJson(Map<String, dynamic> json) =>
    TransitionLock(
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$TransitionLockToJson(TransitionLock instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
    };
