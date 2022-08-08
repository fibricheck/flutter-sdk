import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_fibricheck_sdk/oauth1/client_credentials.dart';
import 'package:http/http.dart' as http;
import '../flutter_fibricheck_sdk.dart';
import '../oauth1/authorization_header.dart';
import '../oauth1/client_credentials.dart';
import '../oauth1/credentials.dart';
import '../oauth1/signature_method.dart';

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

  Future<http.Response> _executeCall(Uri uri, HttpMethod method, Object? body,
      Map<String, String>? headers) async {
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

    if (method == HttpMethod.get) {
      res = await http.get(uri, headers: headers);
    } else if (method == HttpMethod.put) {
      res = await http.put(uri, headers: headers, body: body);
    } else {
      res = await http.post(uri, headers: headers, body: body);
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

  // Delete?
  Future<http.Response> authenticate(ParamsOauth1WithEmail body) async {
    var uri = Uri.parse('$host/users/v1/authenticate');
    var jsonBody = jsonEncode(body);
    var headers = <String, String>{
      "consumerKey": consumerKey,
      "consumerSecret": consumerSecret,
      "Content-Type": "application/json",
    };

    var res = await _executeCall(uri, HttpMethod.post, jsonBody, headers);
    return res;
  }

  Future<http.Response> createOAuth1Token(ParamsOauth1WithEmail body) async {
    var uri = Uri.parse('$host/auth/v2/oauth1/tokens');
    var jsonBody = jsonEncode(body);
    var authHeader = AuthorizationHeader(
        SignatureMethods.HMAC_SHA1,
        ClientCredentials(consumerKey, consumerSecret),
        null,
        "POST",
        uri.toString(), <String, String>{});
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

  bool logout() {
    oAuthToken = null;
    return true;
  }

  Future<http.Response> getGeneralConfiguration() async {
    var uri = Uri.parse('$host/configurations/v2/general');

    var authHeader = AuthorizationHeader(
        SignatureMethods.HMAC_SHA1,
        ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!),
        "GET",
        uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> getUserConfiguration() async {
    var uri = Uri.parse('$host/configurations/v2/users/$userId');

    var authHeader = AuthorizationHeader(
        SignatureMethods.HMAC_SHA1,
        ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!),
        "GET",
        uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }

  Future<http.Response> updateUser(Object body) async {
    var uri = Uri.parse('$host/configurations/v2/users/$userId');

    var authHeader = AuthorizationHeader(
        SignatureMethods.HMAC_SHA1,
        ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!),
        "PUT",
        uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };
    var jsonBody = jsonEncode(body);

    var res = await _executeCall(uri, HttpMethod.put, body, header);
    return res;
  }

  Future<http.Response> getDocuments() async {
    var uri = Uri.parse('$host/data/v1/feature-algo/documents');

    var authHeader = AuthorizationHeader(
        SignatureMethods.HMAC_SHA1,
        ClientCredentials(consumerKey, consumerSecret),
        Credentials(oAuthToken!, oAuthTokenSecret!),
        "GET",
        uri.toString(), <String, String>{});
    var header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": authHeader.toString(),
    };

    var res = await _executeCall(uri, HttpMethod.get, null, header);
    return res;
  }
}
