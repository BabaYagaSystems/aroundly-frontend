class Tokens {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt; // now + expiresIn
  const Tokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });
}
