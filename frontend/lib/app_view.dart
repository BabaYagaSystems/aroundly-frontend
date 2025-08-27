import 'package:flutter/material.dart';
import 'package:frontend/features/auth/presentation/pages/auth_page.dart';
//import 'package:frontend/features/auth/presentation/pages/sign_up_page.dart';
//import 'package:frontend/features/auth/presentation/pages/sign_in_page.dart';
import 'package:frontend/features/happenings/presentation/pages/create_incident_page.dart';
import 'package:frontend/shared/themes/theme.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aroundly',
      theme: AppThemeDark.appDarkTheme,
      home: CreateIncidentPage(),
    );
  }
}
