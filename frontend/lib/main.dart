import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:frontend/core/di/injection.dart';
import 'package:frontend/setup_env.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await dotenv.load(fileName: ".env"); 
  await initDI();
  await setupEnv();
  runApp(const MainApp());
}
