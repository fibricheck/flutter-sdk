class ParamsOauth1WithToken {
  final String token;
  final String tokenSecret;

  ParamsOauth1WithToken({
    required this.token,
    required this.tokenSecret,
  });

  Map toJson() => {
        "token": token,
        "token_secret": tokenSecret,
      };
}
