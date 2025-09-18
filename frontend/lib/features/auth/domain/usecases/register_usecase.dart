import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repo;
  RegisterUseCase(this._repo);

  Future<String> call(String username, String email, String password) {
    return _repo.register(username: username, email: email, password: password);
  }
}
