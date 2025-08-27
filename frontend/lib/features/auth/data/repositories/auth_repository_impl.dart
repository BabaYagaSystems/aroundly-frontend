import 'package:dartz/dartz.dart';
import 'package:frontend/core/errors/errors.dart';
import 'package:frontend/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:frontend/features/auth/data/models/login_req_params.dart';
import 'package:frontend/features/auth/data/models/register_req_params.dart';
import 'package:frontend/features/auth/domain/entities/user_entity.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Errors, UserEntity>> login(LoginReqParams loginReq) async {
    final result = await sl<AuthApiService>().login(loginReq);

    return result.fold((error) => Left(error), (user) async {
      try {
        // Save token locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', user.accessToken);

        return Right(user);
      } catch (e) {
        return Left(UnexpectedError('Error saving token: $e'));
      }
    });
  }

  @override
  Future<Either<Errors, UserEntity>> register(RegisterReqParams regReq) async {
    final result = await sl<AuthApiService>().register(regReq);

    return result.fold((error) => Left(error), (user) async {
      try {
        // Save token locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', user.accessToken);

        return Right(user);
      } catch (e) {
        return Left(UnexpectedError('Error saving token: $e'));
      }
    });
  }
}
