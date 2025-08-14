import 'package:frontend/core/network/dio_client.dart';
import 'package:frontend/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:frontend/features/auth/data/datasources/remote/auth_api_service_impl.dart';
import 'package:frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/register_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  // Usecases
  sl.registerSingleton<RegisterUsecase>(RegisterUsecase());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());
}
