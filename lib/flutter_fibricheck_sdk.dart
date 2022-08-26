library flutter_fibricheck_sdk;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_fibricheck_sdk/api/httpclient.dart';
import 'package:flutter_fibricheck_sdk/measurement.dart';
import 'package:flutter_fibricheck_sdk/paged_results.dart';
import 'package:flutter_fibricheck_sdk/profiledata.dart';
import 'package:flutter_fibricheck_sdk/report.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'sdk_errors.dart';
import 'userdata.dart';

enum Env {
  dev,
  production,
}

List<String> _requiredDocuments = ["privacy_policy", "terms_of_use"];

class FLFibriCheckSdk {
  final String dataKey = "data";

  late OAuth1Client _client;

  FLFibriCheckSdk(OAuth1Client oAuth1Client) {
    _client = oAuth1Client;
  }

  /// Create an instance of the FibriCheck SDK based on a [consumerKey],
  /// [consumerSecret] and optionally an environment specification
  static FLFibriCheckSdk client(String consumerKey, String consumerSecret, {Env? env = Env.production}) {
    return FLFibriCheckSdk(
      OAuth1Client(
        host: env == Env.dev ? "https://api.dev.fibricheck.com" : "https://api.fibricheck.com",
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
    var res = await _client.register(data);
    _throwErrorsFromResponseIfNeeded(res);

    var userData = UserData.fromJson(jsonDecode(res.body));

    return userData;
  }

  /// Authenticate with an [ParamsOauth1WithEmail] object and returns a
  /// [TokenDataOauth1] object
  ///
  /// can throw [ApplicationNotAuthenticatedError], [AuthenticationError],
  ///  [LoginTimeoutError], [LoginFreezeError], [TooManyFailedAttemptsError], [MfaRequiredError]
  Future<TokenDataOauth1> authenticateWithEmail(
      ParamsOauth1WithEmail credentials, void Function(List<Consent> consents) onConsentNeeded) async {
    var res = await _client.createOAuth1TokenWithEmail(credentials);
    _throwErrorsFromResponseIfNeeded(res);

    var resGeneralConfig = await _client.getGeneralConfiguration();
    _throwErrorsFromResponseIfNeeded(resGeneralConfig);
    var resGeneralConfigObj = jsonDecode(resGeneralConfig.body);
    var liveDocuments = resGeneralConfigObj[dataKey]?["documents"];

    var resUserConfig = await _client.getUserConfiguration();
    _throwErrorsFromResponseIfNeeded(resUserConfig);
    var resUserConfigObj = jsonDecode(resUserConfig.body);
    var userDocuments = resUserConfigObj[dataKey]?["documents"];

    List<Consent> consents = <Consent>[];
    for (var doc in _requiredDocuments) {
      if (liveDocuments[doc] != null) {
        var liveVersion = liveDocuments[doc]["version"];

        if (userDocuments == null || userDocuments[doc] == null || userDocuments[doc]["version"] != liveVersion) {
          consents.add(Consent(legalDocumentKey: doc, version: liveVersion, url: liveDocuments[doc]["url"]));
        }
      }
    }

    if (consents.isNotEmpty) {
      onConsentNeeded(consents);
    }

    var resJson = jsonDecode(res.body);

    var tokenData = TokenDataOauth1(
      userId: resJson["userId"],
      applicationId: resJson["applicationId"],
      token: resJson["token"],
      tokenSecret: resJson["tokenSecret"],
      updateTimestamp: DateTime.parse(resJson["updateTimestamp"]).millisecondsSinceEpoch,
      creationTimestamp: DateTime.parse(resJson["creationTimestamp"]).millisecondsSinceEpoch,
      key: _client.consumerKey,
      secret: _client.consumerSecret,
      id: resJson["id"],
    );

    return tokenData;
  }

  /// Authenticate with an [ParamsOauth1WithToken] object and returns a
  /// [TokenDataOauth1] object
  ///
  /// can throw [ApplicationNotAuthenticatedError], [AuthenticationError],
  ///  [LoginTimeoutError], [LoginFreezeError], [TooManyFailedAttemptsError], [MfaRequiredError]
  Future<TokenDataOauth1> authenticateWithToken(
      ParamsOauth1WithToken credentials, void Function(List<Consent> consents) onConsentNeeded) async {
    var res = await _client.createOAuth1TokenWithToken(credentials);
    _throwErrorsFromResponseIfNeeded(res);

    // get general config
    var resGeneralConfig = await _client.getGeneralConfiguration();
    _throwErrorsFromResponseIfNeeded(resGeneralConfig);
    var resGeneralConfigObj = jsonDecode(resGeneralConfig.body);
    var liveDocuments = resGeneralConfigObj[dataKey]?["documents"];

    // get user config
    var resUserConfig = await _client.getUserConfiguration();
    _throwErrorsFromResponseIfNeeded(resUserConfig);
    var resUserConfigObj = jsonDecode(resUserConfig.body);
    var userDocuments = resUserConfigObj[dataKey]?["documents"];

    // required documents: privacyPolicy, termsOfUse
    List<Consent> consents = <Consent>[];
    // check for each required document if there is a live document.
    for (var doc in _requiredDocuments) {
      if (liveDocuments[doc] != null) {
        var liveVersion = liveDocuments[doc]["version"];

        if (userDocuments == null || userDocuments[doc] == null || userDocuments[doc]["version"] != liveVersion) {
          consents.add(Consent(legalDocumentKey: doc, version: liveVersion, url: liveDocuments[doc]["url"]));
        }
      }
    }

    if (consents.isNotEmpty) {
      onConsentNeeded(consents);
    }
    var resJson = jsonDecode(res.body);

    var tokenData = TokenDataOauth1(
        userId: resJson["id"],
        applicationId: null,
        token: credentials.token,
        tokenSecret: credentials.tokenSecret,
        updateTimestamp: resJson["update_timestamp"],
        creationTimestamp: resJson["creation_timestamp"],
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
  /// Returns the number of affectedd records
  Future<int> giveConsent(Consent consent) async {
    var b =
        '{"data": { "documents": { "${consent.legalDocumentKey}": { "version": "${consent.version}", "timestamp": "${DateTime.now().toIso8601String()}" } } } }';

    var res = await _client.updateUserConfig(b);
    _throwErrorsFromResponseIfNeeded(res);

    Map<String, dynamic> resultObj = jsonDecode(res.body);

    int affectedRecords = resultObj["affectedRecords"];

    return affectedRecords;
  }

  /// Send a measurement to the cloud
  Future<Measurement> postMeasurement(MeasurementCreationData measurementCreationData, String cameraSdkVersion) async {
    var isMeasurementAllowed = await canPerformMeasurement();
    if (!isMeasurementAllowed) {
      throw NoActivePrescriptionError();
    }

    var packageInfo = await PackageInfo.fromPlatform();
    measurementCreationData.app = App(
      build: num.parse(packageInfo.buildNumber),
      name: "mobile-spot-check",
      version: packageInfo.version,
      fibricheckSdkVersion: "1.0.0",
      cameraSdkVersion: cameraSdkVersion,
    );

    var deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo;
    IosDeviceInfo iosInfo;

    String? os;
    String? model;
    String? manufacturer;

    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
      os = androidInfo.version.release;
      model = androidInfo.model;
      manufacturer = androidInfo.manufacturer;
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
      os = iosInfo.systemVersion;
      model = iosInfo.localizedModel; // => check input
      manufacturer = 'Apple';
    } else {
      throw SdkError(errorBody: "Platform not supported");
    }

    measurementCreationData.device = Device(
      os: os,
      model: model,
      manufacturer: manufacturer,
      type: Platform.isAndroid ? DeviceType.android : DeviceType.ios,
    );
    measurementCreationData.tags = ['FibriCheck-flutter-sdk'];

    var res = await _client.postMeasurement(jsonEncode(measurementCreationData));
    _throwErrorsFromResponseIfNeeded(res);

    Map<String, dynamic> resultObj = jsonDecode(res.body);
    Measurement m = Measurement.fromJson(resultObj);

    return m;
  }

  /// Check if the user is entitled to perform a measurement
  Future<bool> canPerformMeasurement() async {
    var res = await _client.getDocuments();
    _throwErrorsFromResponseIfNeeded(res);

    Map<String, dynamic> resultObj = jsonDecode(res.body);

    bool? canPerformMeasurement = resultObj[dataKey]?[0]?[dataKey]?["canPerformMeasurement"];

    return canPerformMeasurement == true;
  }

  /// Updates the measurement context for a given measurement id
  Future<int> updateMeasurementContext(String measurementId, MeasurementContext measurementContext) async {
    var res = await _client.upateMeasurementContext(measurementId, '{"context": ${jsonEncode(measurementContext)} }');
    _throwErrorsFromResponseIfNeeded(res);

    Map<String, dynamic> resultObj = jsonDecode(res.body);
    int affectedRecords = resultObj["affectedRecords"];
    return affectedRecords;
  }

  /// Get all measurements of the current user
  Future<PagedMeasurementResult> getMeasurements(bool newestFirst) async {
    var res = await _client.getMeasurements(newestFirst);
    _throwErrorsFromResponseIfNeeded(res);

    Map<String, dynamic> resultObj = jsonDecode(res.body);
    var measurements = resultObj[dataKey];

    var page = Page();
    page.limit = resultObj["page"]["limit"];
    page.offset = resultObj["page"]["offset"];
    page.total = resultObj["page"]["total"];

    List<Measurement> measurementList = <Measurement>[];
    for (var m in measurements) {
      measurementList.add(Measurement.fromJson(m));
    }

    var pagedResult = PagedMeasurementResult(
      result: measurementList,
      page: page,
      client: _client,
      newestFirst: newestFirst,
    );

    return pagedResult;
  }

  /// Get a measurement based on a [measurementId]
  Future<Measurement> getMeasurement(String measurementId) async {
    var res = await _client.getMeasurement(measurementId);
    _throwErrorsFromResponseIfNeeded(res);

    Map<String, dynamic> resultObj = jsonDecode(res.body);
    var data = resultObj[dataKey][0];
    Measurement m = Measurement.fromJson(data);

    return m;
  }

  Future activatePrescription(String hash) async {
    var resPresc = await _client.getPrescription(hash);
    Map<String, dynamic> resultObj = jsonDecode(resPresc.body);

    var status = resultObj[dataKey]?[0]?["status"];
    String? presUserId;
    switch (status) {
      case 'ACTIVATED':
        throw AlreadyActivatedError();
      case 'NOT_PAID':
        throw NotPaidError();
      case 'PAID_BY_USER':
      case 'PAID_BY_GROUP':
      case 'FREE':
      default:
        presUserId = resultObj[dataKey]?[0]?["userId"];
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
    var jsonUpdateData = jsonEncode(updateData);

    var res = await _client.updateUserProfile(userId, jsonUpdateData);
    _throwErrorsFromResponseIfNeeded(res);

    Map<String, dynamic> resultObj = jsonDecode(res.body);

    int affectedRecords = resultObj["records_affected"];

    return affectedRecords;
  }

  Future<String> getPeriodicReportPdf(String reportId) async {
    var res = await _client.getPeriodicReportPdf(reportId);

    var pdf = res.body;

    return pdf;
  }

  Future<PagedPeriodicReportsResult> getPeriodicReports(bool newestFirst) async {
    var res = await _client.getPeriodicReports(newestFirst);
    _throwErrorsFromResponseIfNeeded(res);

    Map<String, dynamic> resultObj = jsonDecode(res.body);
    var reports = resultObj[dataKey];
    List<PeriodicReport> reportsList = <PeriodicReport>[];
    for (var r in reports) {
      reportsList.add(PeriodicReport.fromJson(r));
    }

    var page = Page();
    page.limit = resultObj["page"]["limit"];
    page.offset = resultObj["page"]["offset"];
    page.total = resultObj["page"]["total"];

    var pagedResult = PagedPeriodicReportsResult(
      result: reportsList,
      page: page,
      client: _client,
      newestFirst: newestFirst,
    );

    return pagedResult;
  }

  /// Returns a measurement report url for the given measurement id
  /// or creates one if it not yet exists.
  Future<String> getMeasurementReportUrl(String measurementId) async {
    var res = await _client.getMeasurementReportUrl(measurementId);
    _throwErrorsFromResponseIfNeeded(res);

    Map<String, dynamic> resultObj = jsonDecode(res.body);
    var data = resultObj[dataKey];

    if (!data.isEmpty && data[0]['status'] == 'rendered') {
      var url = "${_client.host}/files/v1/${data[0]?['data']['readFileToken']}/file";
      return url;
    } else {
      var creationRes = await _client.createMeasurementReportUrl(measurementId);
      _throwErrorsFromResponseIfNeeded(creationRes);
      Map<String, dynamic> creationObj = jsonDecode(creationRes.body);
      var creationData = creationObj[dataKey];
      var creationUrl = "${_client.host}/files/v1/${creationData[0]?[dataKey]['readFileToken']}/file";
      return creationUrl;
    }
  }

  void _throwErrorsFromResponseIfNeeded(Response res) {
    if (res.statusCode != 200) {
      if (jsonDecode(res.body)["code"] == 101) throw ApplicationNotAuthenticatedError(errorBody: res.body);
      if (jsonDecode(res.body)["code"] == 106) throw AuthenticationError(errorBody: res.body);
      if (jsonDecode(res.body)["code"] == 129) throw MfaRequiredError(errorBody: res.body);

      if (jsonDecode(res.body)["code"] == 203) throw EmailUsedError(errorBody: res.body);
      if (jsonDecode(res.body)["code"] == 211) throw LoginTimeoutError(errorBody: res.body);
      if (jsonDecode(res.body)["code"] == 212) throw LoginFreezeError(errorBody: res.body);
      if (jsonDecode(res.body)["code"] == 213) throw TooManyFailedAttemptsError(errorBody: res.body);

      if (jsonDecode(res.body)["code"] == 415) throw LockedDocumentError(errorBody: res.body);
    }
  }
}
