

import 'patient_enlistment.dart';
import 'role.dart';
import 'staff_enlistment.dart';

class UserData {
  final String id;
  final String firstName;
  final String lastName;
  final String languageCode;
  final String? timeZone;
  final String email;
  final String phoneNumber;
  final bool activation;
  final List<PatientEnlistment>? patientEnlistments;
  final List<Role>? roles;
  final List<StaffEnlistment>? staffEnlistments;
  final int? lastFailedTimestamp;
  final int? failedCount;
  final String? profileImage;
  final int creationTimestamp;
  final int updateTimestamp;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.languageCode,
    required this.email,
    required this.phoneNumber,
    required this.activation,
    required this.roles,
    required this.creationTimestamp,
    required this.updateTimestamp,
    this.timeZone,
    this.patientEnlistments,
    this.staffEnlistments,
    this.lastFailedTimestamp,
    this.failedCount,
    this.profileImage,
  });

  static UserData fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      languageCode: json["language"],
      timeZone: json["time_zone"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      activation: json["activation"],
      patientEnlistments: json["patient_enlistments"],
      roles: json["roles"],
      staffEnlistments: json["staff_enlistment"],
      lastFailedTimestamp: json["last_failed_timestamp"],
      failedCount: json["failed_count"],
      profileImage: json["profile_image"],
      creationTimestamp: json["creation_timestamp"],
      updateTimestamp: json["update_timestamp"],
    );
  }
}







