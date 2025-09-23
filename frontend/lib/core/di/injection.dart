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
import '../../features/happenings/data/datasources/incident_remote_data_source.dart';
import '../../features/happenings/data/repositories/incident_repository_impl.dart';
import '../../features/happenings/domain/repositories/incident_repository.dart';
import '../../features/happenings/domain/usecases/create_incident_usecase.dart';
import '../../features/happenings/presentation/bloc/create_incident_bloc.dart';
import '../../features/map/data/datasources/map_remote_data_source.dart';
import '../../features/map/data/repositories/map_repository_impl.dart';
import '../../features/map/domain/repositories/map_repository.dart';
import '../../features/map/domain/usecases/get_incident_preview_usecase.dart';
import '../../features/map/domain/usecases/get_nearby_incidents_usecase.dart';
import '../../features/map/presentation/bloc/map_bloc.dart';
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

  sl.registerLazySingleton<IIncidentRemoteDataSource>(
    () => IncidentRemoteDataSource(sl()),
  );

  sl.registerLazySingleton<IncidentRepository>(
    () => IncidentRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => CreateIncidentUseCase(sl()));
  sl.registerFactory(() => CreateIncidentBloc(sl()));

  sl.registerLazySingleton<IMapRemoteDataSource>(
    () => MapRemoteDataSource(sl<DioClient>()),
  );

  // repo
  sl.registerLazySingleton<MapRepository>(() => MapRepositoryImpl(sl()));

  // use cases
  sl.registerLazySingleton(() => GetNearbyIncidentsUseCase(sl()));
  sl.registerLazySingleton(() => GetIncidentPreviewUseCase(sl()));

  // bloc
  sl.registerFactory(() => MapBloc(getNearby: sl(), getPreview: sl()));
}
