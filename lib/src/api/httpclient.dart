import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../sdk_errors.dart';
import '../constants/constants_api.dart';
import '../constants/keys_fibricheck_sdk.dart';
import '../models/measurement/measurement.dart';
import '../models/authentication_data/authentication_data.dart';
import '../oauth1/authorization_header.dart';
import '../oauth1/client_credentials.dart';
import '../oauth1/credentials.dart';
import '../oauth1/signature_method.dart';
import '../models/userdata/userdata.dart';
import '../models/paged_results/paged_results.dart' as paged_result;
import '../api/uri_util.dart';

enum HttpMethod {
  get,
  post,
  put,
  delete,
}

class OAuth1Client {
  final String host;
  final String consumerKey;
  final String consumerSecret;

  late final UriUtil _uriUtil;

  String? oAuthToken;
  String? oAuthTokenSecret;

  OAuth1Client({
    required this.host,
    required this.consumerKey,
    required this.consumerSecret,
  }) {
    _uriUtil = UriUtil(host: host);
  }

  Future<http.Response> register(UserRegisterData body) async {
    var uri = _uriUtil.getRegisterUri();

    body.birthday = body.birthday?.replaceAll(r"/", "-");

    var jsonBody = jsonEncode(body);
    var headers = <String, String>{
      KeysFibricheckSDK.consumerKey: consumerKey,
      KeysFibricheckSDK.consumerSecret: consumerSecret,
      KeysFibricheckSDK.contentType: KeysFibricheckSDK.valueContentTypeApplicationJson,
    };

    var res = await _executeCall(uri, HttpMethod.post, jsonBody, headers);
    return res;
  }

  Future<http.Response> createOAuth1TokenWithEmail(ParamsOauth1WithEmail body) async {
    var uri = _uriUtil.getOAuth1TokenWithEmailUri();
    var jsonBody = jsonEncode(body);

    var header = _getDefaultHeaders(uri, HttpMethod.post, null);

    return await _executeCall(uri, HttpMethod.post, jsonBody, header);
  }

  Future<http.Response> createOAuth1TokenWithToken(ParamsOauth1WithToken body) {
    return _getMe(body.token, body.tokenSecret);
  }

  bool logout() {
    oAuthToken = null;
    oAuthTokenSecret = null;
    return true;
  }

  Future<http.Response> getGeneralConfiguration() async {
    var uri = _uriUtil.getGeneralConfigurationUri();

    var header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getUserConfiguration(String userId) async {
    var uri = _uriUtil.getUserConfigurationUri(userId);

    var header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> updateUserConfig(String userId, String body) async {
    var uri = _uriUtil.getUserConfigurationUri(userId);

    var header = _getDefaultHeadersPut(uri);

    var res = await _executeCall(uri, HttpMethod.put, body, header);
    return res;
  }

  Future<http.Response> getPrescription(String hash) async {
    var uri = _uriUtil.getPrescriptionUri(hash);

    var header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getDocuments(String userId) async {
    var uri = _uriUtil.getDocumentsUri(userId);

    var header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> updateUserProfile(String userId, String updateData) async {
    var uri = _uriUtil.updateUserProfileUri(userId);

    var header = _getDefaultHeadersPut(uri);

    var res = await _executeCall(uri, HttpMethod.put, updateData, header);
    return res;
  }

  Future<http.Response> getMeasurements(String userId, bool newestFirst) async {
    Uri uri = _uriUtil.getMeasurementsUri(userId, newestFirst);
    var header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getNextMeasurements(String userId, paged_result.Page page, bool newestFirst) async {
    Uri uri = _uriUtil.getNextMeasurementsUri(userId, page, newestFirst);
    Map<String, String> header = _getDefaultHeadersGet(uri);
    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getPreviousMeasurements(String userId, paged_result.Page page, bool newestFirst) async {
    Uri uri = _uriUtil.getPreviousMeasurementsUri(userId, page, newestFirst);
    Map<String, String> header = _getDefaultHeadersGet(uri);
    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getMeasurement(String id) async {
    var uri = _uriUtil.getGetMeasurementUri(id);

    Map<String, String> header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> postMeasurement(MeasurementCreationData measurementCreationData) async {
    var uri = _uriUtil.postMeasurementsUri();

    var header = _getDefaultHeadersPost(uri);
    var body = jsonEncode(measurementCreationData);

    var res = await _executeCall(uri, HttpMethod.post, body, header);
    return res;
  }

  Future<http.Response> updateMeasurementContext(String measurementId, MeasurementContext measurementContext) async {
    var map = <String, dynamic>{
      KeysFibricheckSDK.context: measurementContext.toJson(),
    };
    var body = jsonEncode(map);

    var tries = ConstantsApi.maxRetriesUpdateMeasurementContext;
    http.Response res = http.Response(body, 200);
    while (tries > 0) {
      var uri = _uriUtil.updateMeasurementContextUri(measurementId);
      var header = _getDefaultHeadersPut(uri);

      res = await _executeCall(uri, HttpMethod.put, body, header);
      if (res.statusCode != 415) {
        return res;
      } else {
        await Future.delayed(const Duration(milliseconds: 2000));
        tries--;
      }
    }
    return res;
  }

  Future<Uri> getPeriodicReportPdfUri(String reportId) async {
    final language = await _getLanguage();
    final uri = _uriUtil.getPeriodicReportPdfUri(reportId, language);

    return uri;
  }

  Future<http.Response> getPeriodicReportPdf(String reportId) async {
    final language = await _getLanguage();
    var uri = _uriUtil.getPeriodicReportPdfUri(reportId, language);

    var header = _getDefaultHeadersGet(uri);
    header.addAll(<String, String>{
      KeysFibricheckSDK.responseType: KeysFibricheckSDK.valueResponseTypePeriodicReportPdf,
    });

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getPeriodicReports(String userId, bool newestFirst) async {
    Uri uri = _uriUtil.getPeriodicReportsUri(userId, newestFirst);
    var header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getNextPeriodicReports(String userId, paged_result.Page page, bool newestFirst) async {
    Uri uri = _uriUtil.getNextPeriodicReportsUri(userId, page, newestFirst);
    var header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getPreviousPeriodicReports(String userId, paged_result.Page page, bool newestFirst) async {
    Uri uri = _uriUtil.getPreviousPeriodicReportsUri(userId, page, newestFirst);
    var header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getMeasurementReportUrl(String measurementId) async {
    var uri = _uriUtil.getMeasurementReportUrlUri(measurementId);
    Map<String, String> header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);

    return res;
  }

  Future<http.Response> deleteMeasurementReport(String measurementReportId) async {
    final uri = _uriUtil.deleteMeasurementReport(measurementReportId);
    final Map<String, String> headers = _getDefaultHeadersDelete(uri);

    final response = await _executeCall(uri, HttpMethod.delete, null, headers);

    return response;
  }

  Future<http.Response> createMeasurementReportUrl(String measurementId) async {
    Future<http.Response> createMeasurementReport(measurementId) async {
      var uri = _uriUtil.createMeasurementReportUri(measurementId);
      var header = _getDefaultHeadersPost(uri);

      var language = await _getLanguage();

      var body = <String, dynamic>{
        KeysFibricheckSDK.measurementId: measurementId,
        KeysFibricheckSDK.language: language,
      };

      var result = await _executeCall(uri, HttpMethod.post, jsonEncode(body), header);

      return result;
    }

    final creationResult = await createMeasurementReport(measurementId);
    final Map<String, dynamic> creationResultObj = jsonDecode(creationResult.body);
    final String id = creationResultObj[KeysFibricheckSDK.id];

    var tries = ConstantsApi.maxRetriesToFetchMeasurementReport;
    while (tries > 0) {
      final uri = _uriUtil.getFetchMeasurementReportUri(id);
      final header = _getDefaultHeadersGet(uri);

      final response = await _executeCall(uri, HttpMethod.get, null, header);
      final Map<String, dynamic> responseObj = jsonDecode(response.body);

      if (responseObj[KeysFibricheckSDK.page][KeysFibricheckSDK.total] > 0) {
          final report = responseObj[KeysFibricheckSDK.data][0];

          if (report[KeysFibricheckSDK.status] == KeysFibricheckSDK.valueRenderedReport) {
            return response;
          }
      }
      await Future.delayed(const Duration(milliseconds: 2000));
      tries--;
    }

    throw MeasurementReportRenderingTimeout();
  }

  Future<http.Response> activatePrescription(String hash) async {
    var uri = _uriUtil.activatePrescriptionUri(hash);
    var header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> linkPrescription(String hash) async {
    var uri = _uriUtil.linkPrescriptionUri(hash);
    var header = _getDefaultHeadersGet(uri);

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> _executeCall(Uri uri, HttpMethod method, Object? body, Map<String, String>? headers) async {
    void debugPrintRequest(HttpMethod method, Uri uri, Object? body, Map<String, String>? headers) {
      debugPrint("----- Executing webcall -----");
      debugPrint("Executing $method with url $uri");
      if (headers != null) {
        debugPrint("With headers:");
        headers.forEach((key, value) {
          debugPrint("$key: $value");
        });
      }

      if (body != null) {
        debugPrint("With body:");
        debugPrint(body.toString());
      }
    }

    void debugPrintResult(http.Response res) {
      debugPrint("Result code: ${res.statusCode}");
      debugPrint("Result body: ${res.body}");
      debugPrint("----- Finished webcall -----");
    }

    debugPrintRequest(method, uri, body, headers);

    http.Response res;

    switch (method) {
      case HttpMethod.get:
        res = await http.get(uri, headers: headers);
        break;
      case HttpMethod.put:
        res = await http.put(uri, headers: headers, body: body);
        break;
      case HttpMethod.post:
        res = await http.post(uri, headers: headers, body: body);
        break;
      case HttpMethod.delete:
        res = await http.delete(uri, headers: headers);
    }

    debugPrintResult(res);

    return res;
  }

  Future<http.Response> _getMe(String token, String tokenSecret) async {
    var uri = _uriUtil.getMeUri();

    var header = _getDefaultHeaders(uri, HttpMethod.get, Credentials(token, tokenSecret));

    return await _executeCall(uri, HttpMethod.get, null, header);
  }

  Future<String> _getLanguage() async {
    var me = await _getMe(oAuthToken!, oAuthTokenSecret!);

    var meObj = jsonDecode(me.body);
    return meObj[KeysFibricheckSDK.language];
  }

  Map<String, String> _getDefaultHeadersDelete(Uri uri) {
    return _getDefaultHeaders(uri, HttpMethod.delete, Credentials(oAuthToken!, oAuthTokenSecret!));
  }

  Map<String, String> _getDefaultHeadersGet(Uri uri) {
    return _getDefaultHeaders(uri, HttpMethod.get, Credentials(oAuthToken!, oAuthTokenSecret!));
  }

  Map<String, String> _getDefaultHeadersPost(Uri uri) {
    return _getDefaultHeaders(uri, HttpMethod.post, Credentials(oAuthToken!, oAuthTokenSecret!));
  }

  Map<String, String> _getDefaultHeadersPut(Uri uri) {
    return _getDefaultHeaders(uri, HttpMethod.put, Credentials(oAuthToken!, oAuthTokenSecret!));
  }

  Map<String, String> _getDefaultHeaders(Uri uri, HttpMethod method, Credentials? credentials) {
    var authHeader = AuthorizationHeader(
      SignatureMethods.hmacSha1,
      ClientCredentials(consumerKey, consumerSecret),
      credentials,
      method.name,
      uri.toString(),
      <String, String>{},
    );

    var header = <String, String>{
      KeysFibricheckSDK.contentType: KeysFibricheckSDK.valueContentTypeApplicationJson,
      KeysFibricheckSDK.authorization: authHeader.toString(),
    };

    return header;
  }
}
