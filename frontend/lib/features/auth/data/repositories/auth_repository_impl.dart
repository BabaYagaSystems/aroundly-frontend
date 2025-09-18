import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/token_storage.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final IAuthRemoteDataSource _remote;
  final TokenStorage _storage;

  AuthRepositoryImpl(this._remote, this._storage);

  @override
  Future<(User?, String)> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    final res = await _remote.login(
      LoginRequest(usernameOrEmail: usernameOrEmail, password: password),
    );
    await _storage.saveTokens(
      access: res.accessToken,
      refresh: res.refreshToken ?? '',
    );
    return (res.user, res.accessToken);
  }

  @override
  Future<String> register({
    required String username,
    required String email,
    required String password,
  }) {
    return _remote.register(
      RegisterRequest(username: username, email: email, password: password),
    );
  }

  @override
  Future<void> logout() => _storage.clear();

  @override
  Future<bool> hasSession() async =>
      (await _storage.readAccessToken())?.isNotEmpty == true;
}
