import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:frontend/core/di/injection.dart';
import 'package:frontend/setup_env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await initDI();
  await setupEnv();
  runApp(const MainApp());
}
