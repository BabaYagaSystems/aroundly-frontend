import 'package:dartz/dartz.dart';
import 'package:frontend/features/auth/data/models/login_req_params.dart';
import 'package:frontend/features/auth/data/models/register_req_params.dart';

abstract class AuthRepository {
  Future<Either> register(RegisterReqParams regReq);
  Future<Either> login(LoginReqParams loginReq);
}
