import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:frontend/service_locator.dart';
import 'package:frontend/setup_env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  setupServiceLocator();
  await setupEnv();
  runApp(const MainApp());
}
