// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yuv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Yuv _$YuvFromJson(Map<String, dynamic> json) => Yuv(
      u: (json['u'] as List<dynamic>?)?.map((e) => e as num).toList(),
      v: (json['v'] as List<dynamic>?)?.map((e) => e as num).toList(),
      y: (json['y'] as List<dynamic>?)?.map((e) => e as num).toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$YuvToJson(Yuv instance) => <String, dynamic>{
      'id': instance.id,
      'u': instance.u,
      'v': instance.v,
      'y': instance.y,
    };
