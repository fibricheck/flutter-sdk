import 'authorization_header.dart';
import 'signature_method.dart';
import 'client_credentials.dart';
import 'credentials.dart';

class AuthorizationHeaderBuilder {
  late SignatureMethod _signatureMethod;
  late ClientCredentials _clientCredentials;
  Credentials? _credentials;
  late String _method;
  late String _url;
  late Map<String, String> _additionalParameters;

  AuthorizationHeaderBuilder();
  AuthorizationHeaderBuilder.from(AuthorizationHeaderBuilder other)
      : _signatureMethod = other._signatureMethod,
        _clientCredentials = other._clientCredentials,
        _credentials = other._credentials,
        _method = other._method,
        _url = other._url,
        _additionalParameters = other._additionalParameters;

  set signatureMethod(SignatureMethod value) => _signatureMethod = value;
  set clientCredentials(ClientCredentials value) => _clientCredentials = value;
  set credentials(Credentials value) => _credentials = value;
  set method(String value) => _method = value;
  set url(String value) => _url = value;
  set additionalParameters(Map<String, String> value) => _additionalParameters = value;

  AuthorizationHeader build() {
    return AuthorizationHeader(
        _signatureMethod, _clientCredentials, _credentials, _method, _url, _additionalParameters);
  }
}
