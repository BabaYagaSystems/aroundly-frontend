import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_response_model.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

abstract class IAuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequest request);
  Future<String> register(RegisterRequest request);
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final DioClient _client;
  AuthRemoteDataSource(this._client);

  @override
  Future<AuthResponseModel> login(LoginRequest request) async {
    final Response res = await _client.post(
      ApiConstants.login,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<String> register(RegisterRequest request) async {
    final Response res = await _client.post(
      ApiConstants.register,
      data: request.toJson(),
    );
    // conform Swagger, 201 => string message
    return res.data.toString();
  }
}
