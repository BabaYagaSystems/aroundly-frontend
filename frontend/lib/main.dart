import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:frontend/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  setupServiceLocator();
  runApp(const MainApp());
}
