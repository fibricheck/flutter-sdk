// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignalValue _$SignalValueFromJson(Map<String, dynamic> json) => SignalValue(
      time: (json['time'] as List<dynamic>).map((e) => e as int).toList(),
      data: (json['data'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$SignalValueToJson(SignalValue instance) =>
    <String, dynamic>{
      'time': instance.time,
      'data': instance.data,
    };
