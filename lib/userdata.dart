// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'userdata.g.dart';

enum Gender {
  @JsonValue('0')
  notKnown,
  @JsonValue('1')
  male,
  @JsonValue('2')
  female,
  @JsonValue('9')
  notApplicable,
}

@JsonSerializable(explicitToJson: true)
class UserRegisterData {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String email;
  final String password;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  String? birthday;
  final Gender? gender;
  final String? country;
  final String? region;
  final String language;
  @JsonKey(name: 'time_zone')
  final String? timeZone;

  UserRegisterData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.language,
    this.timeZone,
    this.birthday,
    this.country,
    this.gender,
    this.region,
  });

  factory UserRegisterData.fromJson(Map<String, dynamic> json) => _$UserRegisterDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterDataToJson(this);
}
