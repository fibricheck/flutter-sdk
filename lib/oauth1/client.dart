import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'signature_method.dart';
import 'client_credentials.dart';
import 'credentials.dart';
import 'authorization_header_builder.dart';

class Client extends http.BaseClient {
  final SignatureMethod _signatureMethod;
  final ClientCredentials _clientCredentials;
  final Credentials? _credentials;
  final http.Client _httpClient;

  Client(this._signatureMethod, this._clientCredentials, this._credentials,
      [http.BaseClient? httpClient])
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    var ahb = AuthorizationHeaderBuilder();
    ahb.signatureMethod = _signatureMethod;
    ahb.clientCredentials = _clientCredentials;
    if (_credentials != null) ahb.credentials = _credentials!;
    ahb.method = request.method;
    ahb.url = request.url.toString();
    var headers = request.headers;
    Map<String, String> additionalParameters = <String, String>{};
    if (headers.containsKey('Authorization')) {
      String toParse = headers['Authorization'] ?? "";
      additionalParameters = parseUrlEncoded(toParse) as Map<String, String>;
    }

    ahb.additionalParameters = additionalParameters;

    request.headers['Authorization'] = ahb.build().toString();

    return _httpClient.send(request);
  }

  static Map parseUrlEncoded(String content, [bool printErrors = true]) {
    if (content.length <= 0) {
      return {};
    }
    List<String> segments = content.split("&");
    Map parsed = {};

    for (String segment in segments) {
      if (segment.length <= 0) {
        continue;
      }
      List<String> pair = segment.split('=');
      if (pair[0].length <= 0) {
        continue;
      }
      parsed[pair[0]] = (pair.toList().length == 2) ? _urlDecode(pair[1]) : '';
    }
    return parsed;
  }

  static String _urlDecode(String encoded) =>
      Uri.decodeComponent(encoded.replaceAll("+", " "));
}
