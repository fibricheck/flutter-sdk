// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Signal _$SignalFromJson(Map<String, dynamic> json) => Signal(
      key: json['key'] as String,
      value: SignalValue.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignalToJson(Signal instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value.toJson(),
    };
