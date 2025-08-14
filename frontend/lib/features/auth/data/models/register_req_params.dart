class RegisterReqParams {
  final String username;
  final String email;
  final String password;

  RegisterReqParams({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
