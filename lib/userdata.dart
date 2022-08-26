class UserRegisterData {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String language;
  final String? timeZone;

  UserRegisterData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.language,
    this.timeZone,
  });

  Map toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "phone_number": phoneNumber,
        "language": language,
        "time_zone": timeZone,
      };
}

class ParamsOauth1WithEmail {
  final String email;
  final String password;

  ParamsOauth1WithEmail({
    required this.email,
    required this.password,
  });

  Map toJson() => {
        "email": email,
        "password": password,
      };
}

class ParamsOauth1WithToken {
  final String token;
  final String tokenSecret;

  ParamsOauth1WithToken({
    required this.token,
    required this.tokenSecret,
  });

  Map toJson() => {
        "token": token,
        "token_secret": tokenSecret,
      };
}

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

class PatientEnlistment {
  final String groupId;
  final DateTime expiryTimestamp;
  final bool expired;
  final DateTime creationTimestamp;

  PatientEnlistment({
    required this.groupId,
    required this.expiryTimestamp,
    required this.expired,
    required this.creationTimestamp,
  });
}

class Role {
  final String id;
  final String name;
  final String description;
  final List<Permission> permissions;
  final DateTime creationTimestamp;
  final DateTime updateTimestamp;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.permissions,
    required this.creationTimestamp,
    required this.updateTimestamp,
  });
}

class Permission {
  final String name;
  final String description;

  Permission({
    required this.name,
    required this.description,
  });
}

class StaffEnlistment {
  final String groupId;
  final List<GroupRole> roles;
  final DateTime creationTimestamp;
  final DateTime updateTimestamp;

  StaffEnlistment({
    required this.groupId,
    required this.roles,
    required this.creationTimestamp,
    required this.updateTimestamp,
  });
}

class GroupRole {
  final String id;
  final String groupId;
  final String name;
  final String description;
  final List<String> permissions;
  final DateTime creationTimestamp;
  final DateTime updateTimestamp;

  GroupRole({
    required this.id,
    required this.groupId,
    required this.name,
    required this.description,
    required this.permissions,
    required this.creationTimestamp,
    required this.updateTimestamp,
  });
}

class Consent {
  String legalDocumentKey;
  String version;
  String url;

  Consent({
    required this.legalDocumentKey,
    required this.version,
    required this.url,
  });
}

class TokenDataOauth1 {
  final String? userId;
  final String key;
  final String secret;
  final String? applicationId;
  final String? token;
  final String? tokenSecret;
  final num? updateTimestamp;
  final num? creationTimestamp;
  final String? id;

  TokenDataOauth1({
    required this.key,
    required this.secret,
    this.userId,
    this.applicationId,
    this.token,
    this.tokenSecret,
    this.updateTimestamp,
    this.creationTimestamp,
    this.id,
  });
}
