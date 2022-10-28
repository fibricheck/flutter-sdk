import 'dart:convert';

class Credentials {
  final String token;
  final String tokenSecret;

  Credentials(this.token, this.tokenSecret);

  factory Credentials.fromMap(Map<String, String> parameters) {
    if (!parameters.containsKey('oauth_token')) {
      throw ArgumentError("params doesn't have a key 'oauth_token'");
    }
    if (!parameters.containsKey('oauth_token_secret')) {
      throw ArgumentError("params doesn't have a key 'oauth_token_secret'");
    }

    return Credentials(parameters['oauth_token'] ?? "", parameters['oauth_token_secret'] ?? "");
  }
  factory Credentials.fromJSON(String json) {
    return Credentials.fromMap(jsonDecode(json));
  }

  @override
  String toString() {
    return 'oauth_token=$token&oauth_token_secret=$tokenSecret';
  }

  Map toJSON() {
    return {"oauth_token": token, "oauth_token_secret": tokenSecret};
  }
}
