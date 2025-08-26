import 'package:flutter/material.dart';
import 'package:frontend/features/auth/presentation/pages/sign_in_page.dart';
import 'package:frontend/features/auth/presentation/pages/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return SignInPage(togglePages: togglePages);
    } else {
      return SignUpPage(togglePages: togglePages);
    }
  }
}
