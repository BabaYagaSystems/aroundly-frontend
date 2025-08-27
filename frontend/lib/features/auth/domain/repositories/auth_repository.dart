import 'package:dartz/dartz.dart';
import 'package:frontend/core/errors/errors.dart';
import 'package:frontend/features/auth/data/models/login_req_params.dart';
import 'package:frontend/features/auth/data/models/register_req_params.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Errors, UserEntity>> register(RegisterReqParams regReq);
  Future<Either<Errors, UserEntity>> login(LoginReqParams loginReq);
}
