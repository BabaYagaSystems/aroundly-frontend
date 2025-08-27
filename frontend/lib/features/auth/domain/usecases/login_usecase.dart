import 'package:dartz/dartz.dart';
import 'package:frontend/core/errors/errors.dart';
import 'package:frontend/core/usecase/usecase.dart';
//import 'package:frontend/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:frontend/features/auth/data/models/login_req_params.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend/service_locator.dart';

class LoginUsecase implements Usecase<UserEntity, LoginReqParams> {
  @override
  Future<Either<Errors, UserEntity>> call({LoginReqParams? param}) async {
    return sl<AuthRepository>().login(param!);
  }
}
