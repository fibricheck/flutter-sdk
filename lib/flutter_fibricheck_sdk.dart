library flutter_fibricheck_sdk;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fibricheck_sdk/api/httpclient.dart';
import 'package:http/http.dart';

enum Env {
  dev,
  production,
}

List<String> requiredDocuments = ["privacy_policy", "terms_of_use"];

class FLFibriCheckSdk {
  late OAuth1Client _client;

  FLFibriCheckSdk(OAuth1Client oAuth1Client) {
    _client = oAuth1Client;
  }

  /// Takes in a consumerKey, consumerSecret and optionally an env specification
  ///  and returns a FLFibriCheckSdk object that can access the various sdk methods
  static FLFibriCheckSdk client(String consumerKey, String consumerSecret,
      {Env? env = Env.production}) {
    return FLFibriCheckSdk(
      OAuth1Client(
        host: env == Env.dev
            ? "https://api.dev.fibricheck.com"
            : "https://api.fibricheck.com",
        consumerKey: consumerKey,
        consumerSecret: consumerSecret,
      ),
    );
  }

  /// Use password authentication.
  /// As second parameter you need to pass in callback function that is fired when the user needs to sign updated legal documents
  /// see https://docs.fibricheck.com/examples#legal-documents-updated
  Future<Response> register(UserRegisterData data) {
    return _client.register(data);
  }

  Future<Response> authenticate(ParamsOauth1WithEmail credentials,
      void Function(List<Consent> consents) onConsentNeeded) async {
    var res = await _client.createOAuth1Token(credentials);

    // get general config
    var resGeneralConfig = await _client.getGeneralConfiguration();
    var resGeneralConfigObj = jsonDecode(resGeneralConfig.body);
    var liveDocuments = resGeneralConfigObj["data"]?["documents"];

    // get user config
    var resUserConfig = await _client.getUserConfiguration();
    var resUserConfigObj = jsonDecode(resUserConfig.body);
    var userDocuments = resUserConfigObj["data"]?["documents"];

    // required documents: privacyPolicy, termsOfUse
    List<Consent> consents = <Consent>[];
    // check for each required document if there is a live document.
    for (var doc in requiredDocuments) {
      if (liveDocuments[doc] != null) {
        var liveVersion = liveDocuments[doc]["version"];

        if (userDocuments == null ||
            userDocuments[doc] == null ||
            userDocuments[doc]["version"] != liveVersion) {
          consents.add(Consent(
              legalDocumentKey: doc,
              version: liveVersion,
              url: liveDocuments[doc]["url"]));
        }
      }
    }

    if (consents.isNotEmpty) {
      onConsentNeeded(consents);
    }

    return res;
  }

  bool logout() {
    return _client.logout();
  }

  /// Check if the user is entitled to perform a measurement
  Future<bool> canPerformMeasurement() async {
    var res = await _client.getDocuments();

    Map<String, dynamic> resultObj = jsonDecode(res.body);

    bool? canPerformMeasurement =
        resultObj["data"]?[0]?["data"]?["canPerformMeasurement"];

    return canPerformMeasurement == true;
  }

  Future<Response> giveConsent(Consent consent) async {
    var b =
        '{"data": { "documents": { "${consent.legalDocumentKey}": { "version": "${consent.version}", "timestamp": "${DateTime.now().toIso8601String()}" } } } }';

    var res = await _client.updateUser(b);

    return res;
  }
}

//TODO move
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
  final String timeZone;
  final String email;
  final String phoneNumber;
  final bool activation;
  final List<PatientEnlistment> patientEnlistments;
  final List<Role> roles;
  final List<StaffEnlistment> staffEnlistments;
  final DateTime lastFailedTimestamp;
  final int failedCount;
  final String profileImage;
  final DateTime creationTimestamp;
  final DateTime updateTimestamp;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.languageCode,
    required this.timeZone,
    required this.email,
    required this.phoneNumber,
    required this.activation,
    required this.patientEnlistments,
    required this.roles,
    required this.staffEnlistments,
    required this.lastFailedTimestamp,
    required this.failedCount,
    required this.profileImage,
    required this.creationTimestamp,
    required this.updateTimestamp,
  });
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
  String legalDocumentKey; // -> LegalDocumentKey type?
  String version;
  String url;

  Consent({
    required this.legalDocumentKey,
    required this.version,
    required this.url,
  });
}
