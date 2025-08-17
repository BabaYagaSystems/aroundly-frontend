import 'package:flutter/material.dart';
import 'package:frontend/features/auth/data/models/register_req_params.dart';
import 'package:frontend/features/auth/domain/usecases/register_usecase.dart';
import 'package:frontend/service_locator.dart';
import 'package:frontend/shared/widgets/my_button.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_field.dart';
import 'package:frontend/features/auth/presentation/widgets/oauth_button.dart';

import 'package:frontend/shared/themes/theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 24, left: 24, top: 82),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up.',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OauthButton(
                      assetPath: 'assets/images/google.png',
                      backgroundColor: Colors.white,
                      size: 56,
                    ),
                    const SizedBox(width: 16),
                    OauthButton(
                      assetPath: 'assets/images/meta.png',
                      backgroundColor: Colors.blueAccent,
                      size: 56,
                    ),
                    const SizedBox(width: 16),
                    OauthButton(
                      assetPath: 'assets/images/apple.png',
                      backgroundColor: Colors.black,
                      size: 56,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.8,
                        color: AppColors.surfaceDark30,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                      child: Text(
                        'Or',
                        style: TextStyle(color: AppColors.surfaceDark30),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.8,
                        color: AppColors.surfaceDark30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AuthField(controller: nameController, hintText: 'Name'),
                const SizedBox(height: 16),
                // AuthField(controller: surnameController, hintText: 'Surname'),
                const SizedBox(height: 16),
                AuthField(controller: emailController, hintText: 'Email'),
                const SizedBox(height: 16),
                AuthField(
                  controller: passwordController,
                  hintText: 'Password',
                  isObscureText: true,
                ),
                const SizedBox(height: 16),
                // AuthField(
                //   controller: confirmPasswordController,
                //   hintText: 'Confirm Password',
                //   isObscureText: true,
                // ),
                const SizedBox(height: 20),
                MyButton(
                  btnText: 'Sign Up',
                  onPressed: () {
                    sl<RegisterUsecase>().call(
                      param: RegisterReqParams(
                        username: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Log In',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
