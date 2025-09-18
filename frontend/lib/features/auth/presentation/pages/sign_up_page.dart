import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:frontend/shared/presentation/pages/app_layout.dart';
import 'package:frontend/shared/widgets/my_button.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_field.dart';
import 'package:frontend/features/auth/presentation/widgets/oauth_button.dart';

import 'package:frontend/shared/themes/theme.dart';

class SignUpPage extends StatefulWidget {
  final void Function()? togglePages;

  const SignUpPage({super.key, required this.togglePages});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.justRegistered) {
          _showSnack('Account created! Please log in.');
          // Go back to Sign In (since register doesn’t return tokens)
          widget.togglePages?.call();
        } else if (state.error != null) {
          _showSnack(state.error!);
        }
      },
      builder: (context, state) {
        final isLoading = state.loading;

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
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
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
                    // const SizedBox(height: 16),
                    // AuthField(controller: nameController, hintText: 'Name'),
                    const SizedBox(height: 16),
                    AuthField(
                      controller: usernameController,
                      hintText: 'Username',
                      enabled: !isLoading,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.username],
                    ),
                    const SizedBox(height: 16),
                    AuthField(
                      controller: emailController,
                      hintText: 'Email',
                      enabled: !isLoading,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    AuthField(
                      controller: passwordController,
                      hintText: 'Password',
                      isObscureText: true,
                      enabled: !isLoading,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.newPassword],
                    ),
                    // const SizedBox(height: 16),
                    // AuthField(
                    //   controller: confirmPasswordController,
                    //   hintText: 'Confirm Password',
                    //   isObscureText: true,
                    // ),
                    const SizedBox(height: 20),
                    MyButton(
                      btnText: isLoading ? 'Loading...' : 'Sign Up',
                      loading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () {
                              if (formKey.currentState?.validate() ?? false) {
                                context.read<AuthBloc>().add(
                                  AuthRegisterSubmitted(
                                    usernameController.text.trim(),
                                    emailController.text.trim(),
                                    passwordController.text,
                                  ),
                                );
                              }
                            },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        GestureDetector(
                          onTap: widget.togglePages,
                          child: Text(
                            'Log In',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
