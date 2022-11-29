import 'signature_method.dart';
import 'client_credentials.dart';
import 'credentials.dart';
import 'dart:math';

class AuthorizationHeader {
  static const String keyOAuthNonce = 'oauth_nonce';
  static const String keyOAuthSignatureMethod = 'oauth_signature_method';
  static const String keyOAuthConsumerKey = 'oauth_consumer_key';
  static const String keyOAuthVersion = 'oauth_version';
  static const String oAuthVersion = '1.0';
  static const String keyOAuthToken = 'oauth_token';
  static const String keyOAuthSignature = 'oauth_signature';
  static const String keyOAuthTimestamp = 'oauth_timestamp';

  final SignatureMethod _signatureMethod;
  final ClientCredentials _clientCredentials;
  final Credentials? _credentials;
  final String _method;
  final String _url;
  final Map<String, String> _additionalParameters;

  AuthorizationHeader(
    this._signatureMethod,
    this._clientCredentials,
    this._credentials,
    this._method,
    this._url,
    this._additionalParameters,
  );

  @override
  String toString() {
    Map<String, String> params = {};

    params[keyOAuthNonce] = DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(1000000).toString();
    params[keyOAuthSignatureMethod] = _signatureMethod.name;
    params[keyOAuthTimestamp] = (DateTime.now().millisecondsSinceEpoch / 1000).floor().toString();
    params[keyOAuthConsumerKey] = _clientCredentials.token;
    params[keyOAuthVersion] = oAuthVersion;

    if (_credentials != null) {
      params[keyOAuthToken] = _credentials!.token;
    }
    params.addAll(_additionalParameters);
    if (!params.containsKey(keyOAuthSignature)) {
      params[keyOAuthSignature] = _createSignature(_method, _url, params);
    }

    String authHeader = 'OAuth ${params.keys.map((k) {
      return '$k="${Uri.encodeComponent(params[k] ?? "")}"';
    }).join(', ')}';
    return authHeader;
  }

  /// Create signature in ways referred from
  ///   https://dev.twitter.com/docs/auth/creating-signature.
  String _createSignature(String method, String url, Map<String, String> params) {
    // Referred from https://dev.twitter.com/docs/auth/creating-signature
    if (params.isEmpty) {
      throw ArgumentError("params is empty.");
    }
    Uri uri = Uri.parse(url);

    //
    // Collecting parameters
    //

    // 1. Percent encode every key and value
    //    that will be signed.
    Map<String, String> encodedParams = <String, String>{};
    params.forEach((k, v) {
      encodedParams[Uri.encodeComponent(k)] = Uri.encodeComponent(v);
    });
    uri.queryParameters.forEach((k, v) {
      encodedParams[Uri.encodeComponent(k)] = Uri.encodeComponent(v);
    });
    params.remove("realm");

    // 2. Sort the list of parameters alphabetically[1]
    //    by encoded key[2].
    List<String> sortedEncodedKeys = encodedParams.keys.toList()..sort();

    // 3. For each key/value pair:
    // 4. Append the encoded key to the output string.
    // 5. Append the '=' character to the output string.
    // 6. Append the encoded value to the output string.
    // 7. If there are more key/value pairs remaining,
    //    append a '&' character to the output string.
    String baseParams = sortedEncodedKeys
        .map((k) {
          return '$k=${encodedParams[k]}';
        })
        .join('&')
        .replaceAll(r'(', "%28")
        .replaceAll(r')', "%29");

    //
    // Creating the signature base string
    //

    StringBuffer base = StringBuffer();
    // 1. Convert the HTTP Method to uppercase and set the
    //    output string equal to this value.
    base.write(method.toUpperCase());

    // 2. Append the '&' character to the output string.
    base.write('&');

    // 3. Percent encode the URL origin and path, and append it to the
    //    output string.
    base.write(Uri.encodeComponent(uri.origin + uri.path));

    // 4. Append the '&' character to the output string.
    base.write('&');

    // 5. Percent encode the parameter string and append it
    //    to the output string.
    base.write(Uri.encodeComponent(baseParams.toString()));

    //
    // Getting a signing key
    //

    // The signing key is simply the percent encoded consumer
    // secret, followed by an ampersand character '&',
    // followed by the percent encoded token secret:
    String consumerSecret = Uri.encodeComponent(_clientCredentials.tokenSecret);
    String tokenSecret = _credentials != null ? Uri.encodeComponent(_credentials?.tokenSecret ?? "") : "";
    String signingKey = "$consumerSecret&$tokenSecret";

    //
    // Calculating the signature
    //
    var signString = base.toString();
    var signature = _signatureMethod.sign(signingKey, signString);
    return signature;
  }
}
