// feature/auth/data/models/auth_response_model.dart
import '../../domain/entities/user.dart';

class AuthResponseModel {
  final String accessToken; // required
  final String? refreshToken; // optional
  final int? expiresIn; // optional
  final User? user; // optional

  AuthResponseModel({
    required this.accessToken,
    this.refreshToken,
    this.expiresIn,
    this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    // accept several shapes: {accessToken}, {token}, {access_token}, even nested {accessToken: {token: ...}}
    dynamic raw = json['accessToken'] ?? json['token'] ?? json['access_token'];
    if (raw is Map<String, dynamic>) {
      raw = raw['token'] ?? raw['accessToken'] ?? raw['access_token'];
    }
    final token = (raw ?? '').toString();
    if (token.isEmpty) {
      throw FormatException('Missing access token');
    }

    final refresh = json['refreshToken'] ?? json['refresh_token'];
    final exp = json['expiresIn'] ?? json['expires_in'];

    // try to build user if present in flat or nested form
    final username = json['username'] ?? json['user']?['username'];
    final email = json['email'] ?? json['user']?['email'];
    final u = (username != null || email != null)
        ? User(
            username: (username ?? '').toString(),
            email: (email ?? '').toString(),
          )
        : null;

    return AuthResponseModel(
      accessToken: token,
      refreshToken: refresh?.toString(),
      expiresIn: exp == null ? null : int.tryParse(exp.toString()),
      user: u,
    );
  }
}
