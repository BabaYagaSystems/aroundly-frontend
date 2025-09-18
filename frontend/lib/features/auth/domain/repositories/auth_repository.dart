import '../entities/user.dart';

abstract class AuthRepository {
  Future<(User? user, String accessToken)> login({
    required String usernameOrEmail,
    required String password,
  });
  Future<String> register({
    required String username,
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<bool> hasSession();
}
