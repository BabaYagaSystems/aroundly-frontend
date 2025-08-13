import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:frontend/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:frontend/features/auth/data/models/login_req_params.dart';
import 'package:frontend/features/auth/data/models/register_req_params.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> login(LoginReqParams loginReq) async {
    Either result = await sl<AuthApiService>().login(loginReq);
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        Response response = data;
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('token', response.data['token']);
        return Right(response);
      },
    );
  }

  @override
  Future<Either> register(RegisterReqParams regReq) async {
    Either result = await sl<AuthApiService>().register(regReq);
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        Response response = data;
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('token', response.data['token']);
        return Right(response);
      },
    );
  }
}
