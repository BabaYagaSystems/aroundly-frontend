import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Importuri Auth (toate sunt necesare acum)
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/token_storage.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

// Importuri Happenings (Incidents)
import '../../features/happenings/data/datasources/incident_remote_data_source.dart';
import '../../features/happenings/data/repositories/incident_repository_impl.dart';
import '../../features/happenings/domain/repositories/incident_repository.dart';
import '../../features/happenings/domain/usecases/create_incident_usecase.dart';
import '../../features/happenings/presentation/bloc/create_incident_bloc.dart';

// Importuri Map
import '../../features/map/data/datasources/map_remote_data_source.dart';
import '../../features/map/data/repositories/map_repository_impl.dart';
import '../../features/map/domain/repositories/map_repository.dart';
import '../../features/map/domain/usecases/get_incident_preview_usecase.dart';
import '../../features/map/domain/usecases/get_nearby_incidents_usecase.dart';
import '../../features/map/presentation/bloc/map_bloc.dart';

// Importuri Core
import '../network/dio_client.dart';
import '../network/interceptors.dart';
import '../constants/api_constants.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // BAZĂ: Auth0, Storage, Dio
  sl.registerLazySingleton(() => Auth0(
        dotenv.env['AUTH0_DOMAIN']!,
        dotenv.env['AUTH0_CLIENT_ID']!,
      ));

  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage(sl()));
  
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
  
  sl.registerLazySingleton(() => DioClient(
        options: BaseOptions(baseUrl: ApiConstants.baseUrl),
        interceptors: interceptors,
      ));

  // --- FEATURE: Auth ---
  // DataSources (pentru login/parolă)
  sl.registerLazySingleton<IAuthRemoteDataSource>(() => AuthRemoteDataSource(sl()));
  
  // Repository (acum are nevoie de remoteDataSource ȘI storage)
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  
  // UseCases (pentru login/parolă)
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  
  // BLoC (va primi toate dependențele necesare)
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()));

  // --- FEATURE: Happenings (Incidents) ---
  sl.registerLazySingleton<IIncidentRemoteDataSource>(() => IncidentRemoteDataSource(sl()));
  sl.registerLazySingleton<IncidentRepository>(() => IncidentRepositoryImpl(sl()));
  sl.registerLazySingleton(() => CreateIncidentUseCase(sl()));
  sl.registerFactory(() => CreateIncidentBloc(sl()));
  
  // --- FEATURE: Map ---
  sl.registerLazySingleton<IMapRemoteDataSource>(() => MapRemoteDataSource(sl()));
  sl.registerLazySingleton<MapRepository>(() => MapRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetNearbyIncidentsUseCase(sl()));
  sl.registerLazySingleton(() => GetIncidentPreviewUseCase(sl()));
  sl.registerFactory(() => MapBloc(getNearby: sl(), getPreview: sl()));
}