import 'package:uuid/uuid.dart';

import 'signature_method.dart';
import 'client_credentials.dart';
import 'credentials.dart';

class AuthorizationHeader {
  final SignatureMethod _signatureMethod;
  final ClientCredentials _clientCredentials;
  final Credentials? _credentials;
  final String _method;
  final String _url;
  final Map<String, String> _additionalParameters;

  static final _uuid = Uuid();

  AuthorizationHeader(this._signatureMethod, this._clientCredentials,
      this._credentials, this._method, this._url, this._additionalParameters);

  @override
  String toString() {
    Map<String, String> params = Map();

    params['oauth_nonce'] = DateTime.now().millisecondsSinceEpoch.toString();
    params['oauth_signature_method'] = _signatureMethod.name;
    params['oauth_timestamp'] =
        (DateTime.now().millisecondsSinceEpoch / 1000).floor().toString();
    params['oauth_consumer_key'] = _clientCredentials.token;
    params['oauth_version'] = '1.0';
    if (_credentials != null) {
      params['oauth_token'] = _credentials?.token ?? "";
    }
    params.addAll(_additionalParameters);
    if (!params.containsKey('oauth_signature')) {
      params['oauth_signature'] = _createSignature(_method, _url, params);
    }

    String authHeader = 'OAuth ${params.keys.map((k) {
      return '$k="${Uri.encodeComponent(params[k] ?? "")}"';
    }).join(', ')}';
    return authHeader;
  }

  /**
   * Create signature in ways referred from
   *   https://dev.twitter.com/docs/auth/creating-signature.
   */
  String _createSignature(
      String method, String url, Map<String, String> params) {
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
    Map<String, String> encodedParams = Map<String, String>();
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
    String baseParams = sortedEncodedKeys.map((k) {
      return '$k=${encodedParams[k]}';
    }).join('&');

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
    String tokenSecret = _credentials != null
        ? Uri.encodeComponent(_credentials?.tokenSecret ?? "")
        : "";
    String signingKey = "$consumerSecret&$tokenSecret";

    //
    // Calculating the signature
    //
    return _signatureMethod.sign(signingKey, base.toString());
  }
}
