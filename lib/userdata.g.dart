// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegisterData _$UserRegisterDataFromJson(Map<String, dynamic> json) =>
    UserRegisterData(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phoneNumber: json['phone_number'] as String,
      language: json['language'] as String,
      timeZone: json['time_zone'] as String?,
      birthday: json['birthday'] as String?,
      country: json['country'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      region: json['region'] as String?,
    );

Map<String, dynamic> _$UserRegisterDataToJson(UserRegisterData instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'phone_number': instance.phoneNumber,
      'birthday': instance.birthday,
      'gender': _$GenderEnumMap[instance.gender],
      'country': instance.country,
      'region': instance.region,
      'language': instance.language,
      'time_zone': instance.timeZone,
    };

const _$GenderEnumMap = {
  Gender.notKnown: '0',
  Gender.male: '1',
  Gender.female: '2',
  Gender.notApplicable: '9',
};
