// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_fibricheck_sdk/src/models/userdata/enums/activation_mode.dart';
import 'package:json_annotation/json_annotation.dart';

import 'userdata.dart';

part 'user_register_data.g.dart';

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
  @JsonKey(name: 'activation_mode')
  ActivationMode? activationMode;

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
    this.activationMode,
  });

  factory UserRegisterData.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterDataToJson(this);
}
