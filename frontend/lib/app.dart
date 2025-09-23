import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/app_view.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:frontend/features/map/presentation/bloc/map_bloc.dart';

import 'core/di/injection.dart';
import 'features/happenings/presentation/bloc/create_incident_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) =>
              sl<AuthBloc>()..add(AuthAppStarted()), // fire initial check
        ),
        BlocProvider<CreateIncidentBloc>(
          create: (_) => sl<CreateIncidentBloc>(),
        ),
        BlocProvider<MapBloc>(create: (_) => sl<MapBloc>()),
      ],
      child: const MyAppView(),
    );
  }
}
