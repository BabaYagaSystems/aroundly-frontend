import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:frontend/core/constants/api_urls.dart';
import 'package:frontend/core/errors/errors.dart';
import 'package:frontend/core/network/dio_client.dart';
import 'package:frontend/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:frontend/features/auth/data/models/login_req_params.dart';
import 'package:frontend/features/auth/data/models/register_req_params.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart';
import 'package:frontend/service_locator.dart';

class AuthApiServiceImpl implements AuthApiService {
  @override
  Future<Either<Errors, UserEntity>> login(LoginReqParams loginReq) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.login,
        data: loginReq.toMap(),
      );

      // Log the response for debugging
      print('Login API Response: ${response.data}');

      // Validate response.data
      if (response.data == null || response.data is! Map<String, dynamic>) {
        return Left(ServerError('Invalid response: data is null or not a map'));
      }

      // Check for required fields
      final data = response.data as Map<String, dynamic>;
      if (!data.containsKey('username') ||
          !data.containsKey('email') ||
          !data.containsKey('token')) {
        return Left(ServerError('Invalid response: missing required fields'));
      }

      // Ensure fields are non-null strings
      final username = data['username'] as String?;
      final email = data['email'] as String?;
      final token = data['token'] as String?;

      if (username == null || email == null || token == null) {
        return Left(
          ServerError('Invalid response: one or more fields are null'),
        );
      }

      final user = UserEntity(username: username, email: email, token: token);

      return Right(user);
    } on DioException catch (e) {
      return Left(
        ServerError(
          e.response?.data['message'] ?? 'Login failed: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(UnexpectedError('Unexpected error during login: $e'));
    }
  }

  @override
  Future<Either<Errors, UserEntity>> register(RegisterReqParams regReq) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.register,
        data: regReq.toMap(),
      );

      // Log the response for debugging
      print('Register API Response: ${response.data}');

      // Validate response.data
      if (response.data == null || response.data is! Map<String, dynamic>) {
        return Left(ServerError('Invalid response: data is null or not a map'));
      }

      // Check for required fields
      final data = response.data as Map<String, dynamic>;
      if (!data.containsKey('username') ||
          !data.containsKey('email') ||
          !data.containsKey('token')) {
        return Left(ServerError('Invalid response: missing required fields'));
      }

      // Ensure fields are non-null strings
      final username = data['username'] as String?;
      final email = data['email'] as String?;
      final token = data['token'] as String?;

      if (username == null || email == null || token == null) {
        return Left(
          ServerError('Invalid response: one or more fields are null'),
        );
      }

      final user = UserEntity(username: username, email: email, token: token);

      return Right(user);
    } on DioException catch (e) {
      return Left(
        ServerError(
          e.response?.data['message'] ?? 'Registration failed: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(UnexpectedError('Unexpected error during registration: $e'));
    }
  }
}
