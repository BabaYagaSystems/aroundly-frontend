import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:frontend/core/constants/api_urls.dart';
import 'package:frontend/core/network/dio_client.dart';
import 'package:frontend/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:frontend/features/auth/data/models/login_req_params.dart';
import 'package:frontend/features/auth/data/models/register_req_params.dart';
import 'package:frontend/service_locator.dart';

class AuthApiServiceImpl implements AuthApiService {
  @override
  Future<Either> login(LoginReqParams loginReq) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.login,
        data: loginReq.toMap(),
      );

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> register(RegisterReqParams regReq) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.register,
        data: regReq.toMap(),
      );

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
