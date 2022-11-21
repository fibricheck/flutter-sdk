class ParamsOauth1WithEmail {
  final String email;
  final String password;

  ParamsOauth1WithEmail({
    required this.email,
    required this.password,
  });

  Map toJson() => {
    "email": email,
    "password": password,
  };
}
