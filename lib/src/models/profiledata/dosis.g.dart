// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dosis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dosis _$DosisFromJson(Map<String, dynamic> json) => Dosis(
      number: json['number'] as int?,
      unit: $enumDecodeNullable(_$MedicationUnitEnumMap, json['unit']),
    );

Map<String, dynamic> _$DosisToJson(Dosis instance) => <String, dynamic>{
      'number': instance.number,
      'unit': _$MedicationUnitEnumMap[instance.unit],
    };

const _$MedicationUnitEnumMap = {
  MedicationUnit.mg: 'mg',
  MedicationUnit.ml: 'ml',
  MedicationUnit.pill: 'pill',
};
