import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_fibricheck_sdk/oauth1/client_credentials.dart';
import 'package:http/http.dart' as http;
import '../oauth1/authorization_header.dart';
import '../oauth1/client_credentials.dart';
import '../oauth1/credentials.dart';
import '../oauth1/signature_method.dart';
import '../userdata.dart';
import '../paged_results.dart' as paged_result;

enum HttpMethod {
  get,
  post,
  put,
}

class OAuth1Client {
  final String host;
  final String consumerKey;
  final String consumerSecret;

  late String userId;
  late String? oAuthToken;
  late String? oAuthTokenSecret;

  OAuth1Client({
    required this.host,
    required this.consumerKey,
    required this.consumerSecret,
  });

  Future<http.Response> _executeCall(Uri uri, HttpMethod method, Object? body, Map<String, String>? headers) async {
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
    }

    debugPrint("Result code: ${res.statusCode}");
    debugPrint("Result body: ${res.body}");
    debugPrint("----- Finished webcall -----");

    return res;
  }

  Future<http.Response> register(UserRegisterData body) async {
    var uri = Uri.parse('$host/users/v1/register');
    var jsonBody = jsonEncode(body);
    var headers = <String, String>{
      "consumerKey": consumerKey,
      "consumerSecret": consumerSecret,
      "Content-Type": "application/json",
    };

    var res = await _executeCall(uri, HttpMethod.post, jsonBody, headers);
    return res;
  }

  Future<http.Response> createOAuth1TokenWithEmail(ParamsOauth1WithEmail body) async {
    var uri = Uri.parse('$host/auth/v2/oauth1/tokens');
    var jsonBody = jsonEncode(body);
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        null, "POST", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.post, jsonBody, header);

    Map<String, dynamic> resultObj = jsonDecode(res.body);
    oAuthToken = resultObj['token'];
    oAuthTokenSecret = resultObj['tokenSecret'];
    userId = resultObj['userId'];

    return res;
  }

  Future<http.Response> createOAuth1TokenWithToken(ParamsOauth1WithToken body) async {
    var res = await getMe(body.token, body.tokenSecret);

    Map<String, dynamic> resultObj = jsonDecode(res.body);
    oAuthToken = body.token;
    oAuthTokenSecret = body.tokenSecret;
    userId = resultObj['id'];
    return res;
  }

  Future<http.Response> getMe(String token, String tokenSecret) async {
    var uri = Uri.parse('$host/users/v1/me');

    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(token, tokenSecret), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    return await _executeCall(uri, HttpMethod.get, null, header);
  }

  bool logout() {
    oAuthToken = null;
    oAuthTokenSecret = null;
    return true;
  }

  Future<http.Response> getGeneralConfiguration() async {
    var uri = Uri.parse('$host/configurations/v2/general');

    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getUserConfiguration() async {
    var uri = Uri.parse('$host/configurations/v2/users/$userId');

    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> updateUserConfig(String body) async {
    var uri = Uri.parse('$host/configurations/v2/users/$userId');

    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "PUT", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.put, body, header);
    return res;
  }

  Future<http.Response> getPrescription(String hash) async {
    var uri = Uri.parse('$host/prescriptions/v1/$hash');

    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getDocuments() async {
    var uri = Uri.parse('$host/data/v1/feature-algo/documents');

    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> updateUserProfile(String userId, String updateData) async {
    var uri = Uri.parse('$host/profiles/v1/?id=$userId');
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "PUT", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };
    var res = await _executeCall(uri, HttpMethod.put, updateData, header);
    return res;
  }

  Future<http.Response> getMeasurements(bool newestFirst) async {
    var uriString = '$host/data/v1/fibricheck-measurements/documents?eq(creatorId,$userId)&limit(20,0)';
    if (newestFirst) uriString += '&sort(-id)';
    var uri = Uri.parse(uriString);
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };
    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getNextMeasurements(paged_result.Page page, bool newestFirst) async {
    var uriString =
        '$host/data/v1/fibricheck-measurements/documents/?eq(creatorId,$userId)&limit(20,${page.offset + 20})';
    if (newestFirst) uriString += '&sort(-id)';
    var uri = Uri.parse(uriString);
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };
    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getPreviousMeasurements(paged_result.Page page, bool newestFirst) async {
    var uriString =
        '$host/data/v1/fibricheck-measurements/documents/?eq(creatorId,$userId)&limit(20,${page.offset - 20})';
    if (newestFirst) uriString += '&sort(-id)';
    var uri = Uri.parse(uriString);
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };
    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getMeasurement(String id) async {
    var uri = Uri.parse('$host/data/v1/fibricheck-measurements/documents/?id=$id');
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };
    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> postMeasurement(String body) async {
    var uri = Uri.parse('$host/data/v1/fibricheck-measurements/documents');
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "POST", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };
    var res = await _executeCall(uri, HttpMethod.post, body, header);
    return res;
  }

  Future<http.Response> upateMeasurementContext(String measurementId, String body) async {
    var tries = 5;
    http.Response res = http.Response(body, 200);
    while (tries > 0) {
      var uri = Uri.parse('$host/data/v1/fibricheck-measurements/documents/$measurementId');
      var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
          Credentials(oAuthToken!, oAuthTokenSecret!), "PUT", uri.toString(), <String, String>{});
      var header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": authHeader.toString(),
      };
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

  Future<http.Response> getPeriodicReportPdf(String reportId) async {
    var uri = Uri.parse('$host/reports/v1/$reportId/pdf/nl'); // -> lang
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "get", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
      "responseType": "arraybuffer",
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getPeriodicReports(bool newestFirst) async {
    var uriString = '$host/reports/v1/?eq(user_id,$userId)&out(trigger,MANUAL)&eq(status,COMPLETE)&limit(20,0)';
    if (newestFirst) uriString += '&sort(-id)';
    var uri = Uri.parse(uriString);
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getNextPeriodicReports(paged_result.Page page, bool newestFirst) async {
    var uriString =
        '$host/reports/v1/?eq(user_id,$userId)&out(trigger,MANUAL)&eq(status,COMPLETE)&limit(20,${page.offset + 20})';
    if (newestFirst) uriString += '&sort(-id)';
    var uri = Uri.parse(uriString);
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getPreviousPeriodicReports(paged_result.Page page, bool newestFirst) async {
    var uriString =
        '$host/reports/v1/?eq(user_id,$userId)&out(trigger,MANUAL)&eq(status,COMPLETE)&limit(20,${page.offset - 20})';
    if (newestFirst) uriString += '&sort(-id)';
    var uri = Uri.parse(uriString);
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getMeasurementReportUrl(String measurementId) async {
    var uri = Uri.parse('$host/data/v1/measurement-reports/documents/?data.measurementId=$measurementId');
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);

    return res;
  }

  Future<http.Response> createMeasurementReportUrl(String measurementId) async {
    var me = await getMe(oAuthToken!, oAuthTokenSecret!);
    Map<String, dynamic> meObj = jsonDecode(me.body);

    var creationUri = Uri.parse('$host/data/v1/measurement-reports/documents/?data.measurementId=$measurementId');
    var creationAuthHeader = AuthorizationHeader(
        SignatureMethods.hmacSha1,
        ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!),
        "POST",
        creationUri.toString(), <String, String>{});
    var creationHeader = <String, String>{
      "Content-Type": "application/json",
      "Authorization": creationAuthHeader.toString(),
    };
    var body = '{ "measurementId": "$measurementId", "language":"${meObj['language']}"}';

    var creationResult = await _executeCall(creationUri, HttpMethod.post, body, creationHeader);
    Map<String, dynamic> creationResultObj = jsonDecode(creationResult.body);

    var tries = 15;
    while (tries > 0) {
      var uri = Uri.parse('$host/data/v1/measurement-reports/documents/?id=${creationResultObj['id']}');
      var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
          Credentials(oAuthToken!, oAuthTokenSecret!), "GET", uri.toString(), <String, String>{});
      var header = <String, String>{
        "Content-Type": "application/json",
        "Authorization": authHeader.toString(),
      };

      var report = await _executeCall(uri, HttpMethod.get, null, header);
      Map<String, dynamic> reportObj = jsonDecode(report.body);
      if (reportObj['data'][0]['status'] == 'rendered') {
        return report;
      } else {
        await Future.delayed(const Duration(milliseconds: 2000));
        tries--;
      }
    }

    return creationResult;
  }

  Future<http.Response> activatePrescription(String hash) async {
    var uri = Uri.parse('$host/prescriptions/v1/$hash/activate');
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "get", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> linkPrescription(String hash) async {
    var uri = Uri.parse('$host/prescriptions/v1/$hash/scan');
    var authHeader = AuthorizationHeader(SignatureMethods.hmacSha1, ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!), "get", uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }
}
