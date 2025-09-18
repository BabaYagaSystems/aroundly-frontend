import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repo;
  LoginUseCase(this._repo);

  Future<(User? user, String token)> call(
    String usernameOrEmail,
    String password,
  ) {
    return _repo.login(usernameOrEmail: usernameOrEmail, password: password);
  }
}
