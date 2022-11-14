library flutter_fibricheck_sdk;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'models/authentication_data/authentication_data.dart';
import 'constants/constants_prescription_status.dart';
import 'constants/constants_api.dart';
import 'sdk_errors.dart';
import 'models/userdata/userdata.dart';
import 'constants/keys_fibricheck_sdk.dart';
import 'api/httpclient.dart';
import 'models/general_configuration/general_configuration.dart';
import 'models/measurement/measurement.dart';
import 'models/paged_results/paged_results.dart' as paged_results;
import 'models/profiledata/profiledata.dart';
import 'models/report/report.dart';
import 'models/user_configuration/user_configuration.dart';

enum Env {
  dev,
  production,
}

class FLFibriCheckSdk {
  static const List<String> _requiredDocuments = ["privacy_policy", "terms_of_use"];

  static const String tagFibricheckSdk = "FibriCheck-flutter-sdk";
  static const String measurementCreationDataName = "mobile-spot-check";
  static const String fibricheckSdkVersion = "1.0.0";

  @visibleForTesting
  bool suppressPlatformCheckError = false;

  late final OAuth1Client _client;
  late String _userId;

  FLFibriCheckSdk(OAuth1Client oAuth1Client) {
    _client = oAuth1Client;
    _userId = "";
  }

  /// Create an instance of the FibriCheck SDK based on a [consumerKey],
  /// [consumerSecret] and optionally an environment specification
  static FLFibriCheckSdk client(String consumerKey, String consumerSecret, {Env? env = Env.production}) {
    return FLFibriCheckSdk(
      OAuth1Client(
        host: env == Env.dev ? ConstantsApi.developmentUrl : ConstantsApi.productionUrl,
        consumerKey: consumerKey,
        consumerSecret: consumerSecret,
      ),
    );
  }

  /// Create an account based on a [UserRegisterData] object
  /// and returns [UserData] of the created user
  ///
  /// can throw [EmailUsedError]
  Future<UserData> register(UserRegisterData data) async {
    final response = await _client.register(data);
    response.throwSDKErrorIfNeeded();

    final userData = UserData.fromJson(jsonDecode(response.body));

    return userData;
  }

  /// Authenticate with an [ParamsOauth1WithEmail] object and returns a
  /// [TokenDataOauth1] object
  ///
  /// can throw [ApplicationNotAuthenticatedError], [AuthenticationError],
  ///  [LoginTimeoutError], [LoginFreezeError], [TooManyFailedAttemptsError], [MfaRequiredError]
  Future<TokenDataOauth1> authenticateWithEmail(ParamsOauth1WithEmail credentials, void Function(List<Consent> consents) onConsentNeeded) async {
    final response = await _client.createOAuth1TokenWithEmail(credentials);
    response.throwSDKErrorIfNeeded();

    final resultObj = jsonDecode(response.body);
    _client.oAuthToken = resultObj[KeysFibricheckSDK.token];
    _client.oAuthTokenSecret = resultObj[KeysFibricheckSDK.tokenSecret];
    _userId = resultObj[KeysFibricheckSDK.userId];

    final resGeneralConfig = await _client.getGeneralConfiguration();
    resGeneralConfig.throwSDKErrorIfNeeded();

    final resGeneralConfigObj = jsonDecode(resGeneralConfig.body);
    final liveDocuments = resGeneralConfigObj[KeysFibricheckSDK.data]?[KeysFibricheckSDK.documents];

    final resUserConfig = await _client.getUserConfiguration(_userId);
    resUserConfig.throwSDKErrorIfNeeded();

    final resUserConfigObj = jsonDecode(resUserConfig.body);
    final userDocuments = resUserConfigObj[KeysFibricheckSDK.data]?[KeysFibricheckSDK.documents];

    List<Consent> consents = <Consent>[];
    for (var doc in _requiredDocuments) {
      if (liveDocuments[doc] != null) {
        final liveVersion = liveDocuments[doc][KeysFibricheckSDK.version];

        if (userDocuments == null || userDocuments[doc] == null || userDocuments[doc][KeysFibricheckSDK.version] != liveVersion) {
          consents.add(Consent(legalDocumentKey: doc, version: liveVersion, url: liveDocuments[doc][KeysFibricheckSDK.url]));
        }
      }
    }

    if (consents.isNotEmpty) {
      onConsentNeeded(consents);
    }

    final resJson = jsonDecode(response.body);

    final tokenData = TokenDataOauth1(
      userId: resJson[KeysFibricheckSDK.userId],
      applicationId: resJson[KeysFibricheckSDK.applicationId],
      token: resJson[KeysFibricheckSDK.token],
      tokenSecret: resJson[KeysFibricheckSDK.tokenSecret],
      updateTimestamp: DateTime.parse(resJson[KeysFibricheckSDK.updateTimestampAuthenticateWithEmail]).millisecondsSinceEpoch,
      creationTimestamp: DateTime.parse(resJson[KeysFibricheckSDK.creationTimestampAuthenticateWithEmail]).millisecondsSinceEpoch,
      key: _client.consumerKey,
      secret: _client.consumerSecret,
      id: resJson[KeysFibricheckSDK.id],
    );

    return tokenData;
  }

  /// Authenticate with an [ParamsOauth1WithToken] object and returns a
  /// [TokenDataOauth1] object
  ///
  /// can throw [ApplicationNotAuthenticatedError], [AuthenticationError],
  ///  [LoginTimeoutError], [LoginFreezeError], [TooManyFailedAttemptsError], [MfaRequiredError]
  Future<TokenDataOauth1> authenticateWithToken(ParamsOauth1WithToken credentials, void Function(List<Consent> consents) onConsentNeeded) async {
    final response = await _client.createOAuth1TokenWithToken(credentials);
    response.throwSDKErrorIfNeeded();

    final resultObj = jsonDecode(response.body);
    _client.oAuthToken = resultObj[KeysFibricheckSDK.token];
    _client.oAuthTokenSecret = resultObj[KeysFibricheckSDK.tokenSecret];
    _userId = resultObj[KeysFibricheckSDK.userId];

    // get general config
    final resGeneralConfig = await _client.getGeneralConfiguration();
    resGeneralConfig.throwSDKErrorIfNeeded();

    final resGeneralConfigObj = jsonDecode(resGeneralConfig.body);
    final liveDocuments = resGeneralConfigObj[KeysFibricheckSDK.data]?[KeysFibricheckSDK.documents];

    // get user config
    final resUserConfig = await _client.getUserConfiguration(_userId);
    resUserConfig.throwSDKErrorIfNeeded();

    final resUserConfigObj = jsonDecode(resUserConfig.body);
    final userDocuments = resUserConfigObj[KeysFibricheckSDK.data]?[KeysFibricheckSDK.documents];

    // required documents: privacyPolicy, termsOfUse
    final consents = <Consent>[];
    // check for each required document if there is a live document.
    for (var doc in _requiredDocuments) {
      if (liveDocuments[doc] != null) {
        var liveVersion = liveDocuments[doc][KeysFibricheckSDK.version];

        if (userDocuments == null || userDocuments[doc] == null || userDocuments[doc][KeysFibricheckSDK.version] != liveVersion) {
          consents.add(Consent(legalDocumentKey: doc, version: liveVersion, url: liveDocuments[doc][KeysFibricheckSDK.url]));
        }
      }
    }

    if (consents.isNotEmpty) {
      onConsentNeeded(consents);
    }
    var resJson = jsonDecode(response.body);

    var tokenData = TokenDataOauth1(
        userId: resJson[KeysFibricheckSDK.id],
        applicationId: null,
        token: credentials.token,
        tokenSecret: credentials.tokenSecret,
        updateTimestamp: resJson[KeysFibricheckSDK.updateTimestampAuthenticateWithToken],
        creationTimestamp: resJson[KeysFibricheckSDK.creationTimestampAuthenticateWithToken],
        key: _client.consumerKey,
        secret: _client.consumerSecret,
        id: null);

    return tokenData;
  }

  /// Clears oauth session data
  bool logout() {
    return _client.logout();
  }

  /// Gives consent based on a [Consent] object
  /// Returns the number of affected records
  Future<int> giveConsent(Consent consent) async {
    var body = <String, dynamic>{
      KeysFibricheckSDK.data: <String, dynamic>{
        KeysFibricheckSDK.documents: <String, dynamic>{
          consent.legalDocumentKey: <String, dynamic>{
            KeysFibricheckSDK.version: consent.version,
            KeysFibricheckSDK.timestamp: DateTime.now().toIso8601String(),
          }
        },
      },
    };

    final response = await _client.updateUserConfig(_userId, jsonEncode(body));
    response.throwSDKErrorIfNeeded();

    final resultObj = jsonDecode(response.body);

    final affectedRecords = resultObj[KeysFibricheckSDK.affectedRecords];

    return affectedRecords;
  }

  /// Send a measurement to the cloud
  Future<Measurement> postMeasurement(MeasurementCreationData measurementCreationData, String cameraSdkVersion) async {
    final isMeasurementAllowed = await canPerformMeasurement();
    if (!isMeasurementAllowed) {
      throw NoActivePrescriptionError();
    }

    final packageInfo = await PackageInfo.fromPlatform();

    measurementCreationData.app = App(
      build: num.parse(packageInfo.buildNumber),
      name: measurementCreationDataName,
      version: packageInfo.version,
      fibricheckSdkVersion: fibricheckSdkVersion,
      cameraSdkVersion: cameraSdkVersion,
    );

    final device = await Device.getDeviceInfo(suppressPlatformCheckError);

    measurementCreationData.device = device;

    measurementCreationData.tags = [tagFibricheckSdk];

    final response = await _client.postMeasurement(measurementCreationData);
    response.throwSDKErrorIfNeeded();

    final resultObj = jsonDecode(response.body);
    final measurement = Measurement.fromJson(resultObj);

    return measurement;
  }

  /// Check if the user is entitled to perform a measurement
  Future<bool> canPerformMeasurement() async {
    final response = await _client.getDocuments(_userId);
    response.throwSDKErrorIfNeeded();

    final resultObj = jsonDecode(response.body);

    bool? canPerformMeasurement = resultObj[KeysFibricheckSDK.data]?[0]?[KeysFibricheckSDK.data]?[KeysFibricheckSDK.canPerformMeasurement];

    return canPerformMeasurement == true;
  }

  /// Updates the measurement context for a given measurement id
  Future<int> updateMeasurementContext(String measurementId, MeasurementContext measurementContext) async {
    final response = await _client.updateMeasurementContext(measurementId, measurementContext);
    response.throwSDKErrorIfNeeded();

    final resultObj = jsonDecode(response.body);
    final affectedRecords = resultObj[KeysFibricheckSDK.affectedRecords];

    return affectedRecords;
  }

  /// Get all measurements of the current user
  Future<paged_results.PagedMeasurementResult> getMeasurements(bool newestFirst) async {
    final response = await _client.getMeasurements(_userId, newestFirst);
    response.throwSDKErrorIfNeeded();

    final resultObj = jsonDecode(response.body);
    final measurements = resultObj[KeysFibricheckSDK.data];

    final page = paged_results.Page();
    page.limit = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.limit];
    page.offset = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.offset];
    page.total = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.total];

    final measurementList = <Measurement>[];
    for (var measurement in measurements) {
      measurementList.add(Measurement.fromJson(measurement));
    }

    final pagedResult = paged_results.PagedMeasurementResult(
      result: measurementList,
      page: page,
      client: _client,
      newestFirst: newestFirst,
      userId: _userId,
    );

    return pagedResult;
  }

  /// Get a measurement based on a [measurementId]
  Future<Measurement> getMeasurement(String measurementId) async {
    final response = await _client.getMeasurement(measurementId);
    response.throwSDKErrorIfNeeded();

    final resultObj = jsonDecode(response.body);
    final data = resultObj[KeysFibricheckSDK.data][0];
    final measurement = Measurement.fromJson(data);

    return measurement;
  }

  Future activatePrescription(String hash) async {
    final result = await _client.getPrescription(hash);
    final resultObj = jsonDecode(result.body);

    final data = resultObj[KeysFibricheckSDK.data]?[0];
    final status = data?[KeysFibricheckSDK.status];

    String? presUserId;
    switch (status) {
      case ConstantsPrescriptionStatus.activated:
        throw AlreadyActivatedError();
      case ConstantsPrescriptionStatus.notPaid:
        throw NotPaidError();
      case ConstantsPrescriptionStatus.paidByUser:
      case ConstantsPrescriptionStatus.paidByGroup:
      case ConstantsPrescriptionStatus.free:
      default:
        presUserId = data?[KeysFibricheckSDK.userId];
        break;
    }

    if (presUserId == null) {
      await _client.linkPrescription(hash);
    }

    await _client.activatePrescription(hash);
  }

  /// Update the user profile of the [userId] provided
  /// with the given [ProfileData] and returns the number of affected records
  Future<int> updateProfile(String userId, ProfileData updateData) async {
    final jsonUpdateData = jsonEncode(updateData);

    final response = await _client.updateUserProfile(userId, jsonUpdateData);
    response.throwSDKErrorIfNeeded();

    final resultObj = jsonDecode(response.body);

    final affectedRecords = resultObj[KeysFibricheckSDK.recordsAffected];

    return affectedRecords;
  }
  /// Return the periodic report pdf of the [reportId] provided
  Future<String> getPeriodicReportPdf(String reportId) async {
    final res = await _client.getPeriodicReportPdf(reportId);

    final pdf = res.body;

    return pdf;
  }

  /// Return a page of periodic reports. /!\ It's not the pdf.
  /// Use [newestFirst] to have the latest.
  Future<paged_results.PagedPeriodicReportsResult> getPeriodicReports(bool newestFirst) async {
    final response = await _client.getPeriodicReports(_userId, newestFirst);
    response.throwSDKErrorIfNeeded();

    final resultObj = jsonDecode(response.body);
    final reports = resultObj[KeysFibricheckSDK.data];

    final reportsList = <PeriodicReport>[];
    for (final report in reports) {
      reportsList.add(PeriodicReport.fromJson(report));
    }

    final page = paged_results.Page();

    page.limit = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.limit];
    page.offset = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.offset];
    page.total = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.total];

    final pagedResult = paged_results.PagedPeriodicReportsResult(
      result: reportsList,
      page: page,
      client: _client,
      newestFirst: newestFirst,
      userId: _userId,
    );

    return pagedResult;
  }

  /// Returns a measurement report url for the given measurement id
  /// or creates one if it not yet exists.
  Future<String> getMeasurementReportUrl(String measurementId) async {
    final result = await _client.getMeasurementReportUrl(measurementId);
    result.throwSDKErrorIfNeeded();

    Map<String, dynamic> resultObj = jsonDecode(result.body);
    final data = resultObj[KeysFibricheckSDK.data];

    if (!data.isEmpty && data[0][KeysFibricheckSDK.status] == KeysFibricheckSDK.valueMeasurementReportStatusRendered) {
      var readFileToken = data[0][KeysFibricheckSDK.data][KeysFibricheckSDK.readFileToken];
      final url = "${_client.host}/files/v1/$readFileToken/file";
      return url;
    } else {
      final response = await _client.createMeasurementReportUrl(measurementId);
      response.throwSDKErrorIfNeeded();

      final creationObj = jsonDecode(response.body);
      final creationData = creationObj[KeysFibricheckSDK.data];

      final readFileToken = creationData[0]?[KeysFibricheckSDK.data][KeysFibricheckSDK.readFileToken];
      final creationUrl = "${_client.host}/files/v1/$readFileToken/file";

      return creationUrl;
    }
  }

  /// Return the general configuration as a [GeneralConfiguration].
  Future<GeneralConfiguration> getGeneralConfiguration() async {
    final response = await _client.getGeneralConfiguration();
    response.throwSDKErrorIfNeeded();

    final resultObject = jsonDecode(response.body);
    final generalConfiguration = GeneralConfiguration.fromJson(resultObject);

    return generalConfiguration;
  }

  /// Return the user configuration as a [UserConfiguration].
  Future<UserConfiguration> getUserConfiguration() async {
    final response = await _client.getUserConfiguration(_userId);
    response.throwSDKErrorIfNeeded();

    final resultObject = jsonDecode(response.body);
    final userConfiguration = UserConfiguration.fromJson(resultObject);

    return userConfiguration;
  }

  /// Update the user with the id [userId] configuration.
  /// The [key] is the key where to save the value for the user.
  /// The [value] is an object that can be jsonEncoded.
  /// Return true if the update was done successfully.
  Future<bool> updateUserConfig(String key, Object value) async {
    final encapsulated = <String, dynamic>{
      KeysFibricheckSDK.data: {key: value},
    };
    final String jsonString = jsonEncode(encapsulated);

    final response = await _client.updateUserConfig(_userId, jsonString);
    response.throwSDKErrorIfNeeded();

    final resultObj = jsonDecode(response.body);
    final affectedRecords = resultObj[KeysFibricheckSDK.affectedRecords];

    return affectedRecords > 0;
  }
}
