import 'credentials.dart';

class AuthorizationResponse {
  final Credentials credentials;
  final Map<String, String> optionalParameters;

  AuthorizationResponse(this.credentials, this.optionalParameters);

  factory AuthorizationResponse.fromMap(Map<String, String> parameters) {
    final paramsCopy = Map<String, String>.from(parameters);
    final cred = Credentials.fromMap(paramsCopy);

    paramsCopy.remove('oauth_token');
    paramsCopy.remove('oauth_token_secret');

    return AuthorizationResponse(cred, paramsCopy);
  }
}
