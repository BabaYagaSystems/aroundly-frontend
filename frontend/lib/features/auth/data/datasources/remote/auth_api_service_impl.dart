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

      final user = UserEntity(
        username: response.data['username'],
        email: response.data['email'],
        token: response.data['token'],
      );

      return Right(user);
    } on DioException catch (e) {
      return Left(ServerError(e.response?.data['message'] ?? 'Unknown error'));
    } catch (e) {
      return Left(UnexpectedError(e.toString()));
    }
  }

  @override
  Future<Either<Errors, UserEntity>> register(RegisterReqParams regReq) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.register,
        data: regReq.toMap(),
      );

      final user = UserEntity(
        username: response.data['username'],
        email: response.data['email'],
        token: response.data['token'],
      );

      return Right(user);
    } on DioException catch (e) {
      return Left(ServerError(e.response?.data['message'] ?? 'Unknown error'));
    } catch (e) {
      return Left(UnexpectedError(e.toString()));
    }
  }
}
