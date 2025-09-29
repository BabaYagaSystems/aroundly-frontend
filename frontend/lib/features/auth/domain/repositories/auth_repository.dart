import 'package:auth0_flutter/auth0_flutter.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  // PĂSTRAT: Metoda pentru login cu email/parolă
  Future<(User? user, String accessToken)> login({
    required String usernameOrEmail,
    required String password,
  });

  // PĂSTRAT: Metoda pentru înregistrare cu email/parolă
  Future<String> register({
    required String username,
    required String email,
    required String password,
  });

  // NOU: Metodă pentru a salva datele primite de la Auth0
  Future<void> loginWithCredentials(Credentials credentials);

  // PĂSTRAT: Metoda pentru logout
  Future<void> logout();

  // PĂSTRAT: Metoda pentru a verifica sesiunea
  Future<bool> hasSession();
}