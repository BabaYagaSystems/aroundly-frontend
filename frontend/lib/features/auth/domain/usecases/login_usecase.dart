import 'package:dartz/dartz.dart';
import 'package:frontend/core/usecase/usecase.dart';
import 'package:frontend/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:frontend/features/auth/data/models/login_req_params.dart';
import 'package:frontend/service_locator.dart';

class LoginUsecase implements Usecase<Either, LoginReqParams> {
  @override
  Future<Either> call({LoginReqParams? param}) async {
    return sl<AuthApiService>().login(param!);
  }
}
