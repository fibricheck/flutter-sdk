class TokenDataOauth1 {
  final String? userId;
  final String key;
  final String secret;
  final String? applicationId;
  final String? token;
  final String? tokenSecret;
  final num? updateTimestamp;
  final num? creationTimestamp;
  final String? id;

  TokenDataOauth1({
    required this.key,
    required this.secret,
    this.userId,
    this.applicationId,
    this.token,
    this.tokenSecret,
    this.updateTimestamp,
    this.creationTimestamp,
    this.id,
  });
}
