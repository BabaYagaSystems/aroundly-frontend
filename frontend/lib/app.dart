import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/app_view.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_bloc.dart';

import 'core/di/injection.dart';

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
      ],
      child: const MyAppView(),
    );
  }
}
