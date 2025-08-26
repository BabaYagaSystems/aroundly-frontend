class LoginReqParams {
  final String usernameOrEmail;
  final String password;

  LoginReqParams({required this.usernameOrEmail, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usernameOrEmail': usernameOrEmail,
      'password': password,
    };
  }
}
