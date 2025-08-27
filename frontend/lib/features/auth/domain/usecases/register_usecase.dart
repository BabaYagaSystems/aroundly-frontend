import 'package:dartz/dartz.dart';
import 'package:frontend/core/errors/errors.dart';
import 'package:frontend/core/usecase/usecase.dart';
import 'package:frontend/features/auth/data/models/register_req_params.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend/service_locator.dart';

class RegisterUsecase implements Usecase<UserEntity, RegisterReqParams> {
  @override
  Future<Either<Errors, UserEntity>> call({RegisterReqParams? param}) async {
    return sl<AuthRepository>().register(param!);
  }
}
