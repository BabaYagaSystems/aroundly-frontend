import 'package:get_it/get_it.dart';

// Core
import 'package:frontend/core/network/dio_client.dart';

// Auth Feature
import 'package:frontend/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:frontend/features/auth/data/datasources/remote/auth_api_service_impl.dart';
import 'package:frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend/features/auth/domain/usecases/login_usecase.dart';
import 'package:frontend/features/auth/domain/usecases/register_usecase.dart';

// Happenings Feature (Incidents)
import 'package:frontend/features/happenings/data/datasources/remote/incident_api_service.dart';
import 'package:frontend/features/happenings/data/datasources/remote/incident_api_service_impl.dart';
import 'package:frontend/features/happenings/data/repositories/incident_repository_impl.dart';
import 'package:frontend/features/happenings/domain/repositories/incident_repository.dart';
import 'package:frontend/features/happenings/domain/usecases/create_incident_usecase.dart';
//import 'package:frontend/features/happenings/presentation/bloc/incident_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  /// Core
  sl.registerSingleton<DioClient>(DioClient());

  /// ---------------- AUTH FEATURE ----------------
  // Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  // Repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  // Usecases
  sl.registerSingleton<RegisterUsecase>(RegisterUsecase());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());

  /// ---------------- INCIDENT FEATURE ----------------
  // Services
  sl.registerSingleton<IncidentApiService>(IncidentApiServiceImpl());
  // Repository
  sl.registerSingleton<IncidentRepository>(IncidentRepositoryImpl());
  // Usecase
  sl.registerSingleton<CreateIncidentUsecase>(CreateIncidentUsecase());
  // Bloc
  // sl.registerFactory<IncidentBloc>(
  //   () => IncidentBloc(createIncident: sl<CreateIncidentUsecase>()),
  // );
}
