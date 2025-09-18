import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/token_storage.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../network/dio_client.dart';
import '../network/interceptors.dart';
import '../constants/api_constants.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // storage
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage(sl()));

  // dio
  final options = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    responseType: ResponseType.json,
    sendTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );

  final interceptors = <Interceptor>[
    LoggerInterceptor(),
    InterceptorsWrapper(
      onRequest: (opts, handler) async {
        final token = await sl<TokenStorage>().readAccessToken();
        if (token != null && token.isNotEmpty) {
          opts.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(opts);
      },
    ),
  ];

  sl.registerLazySingleton(
    () => DioClient(options: options, interceptors: interceptors),
  );

  // data sources
  sl.registerLazySingleton<IAuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),
  );

  // repos
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  // use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  // BLoC
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));
}
