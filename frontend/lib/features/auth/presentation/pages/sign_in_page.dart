import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/data/models/login_req_params.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_bloc.dart';
//import 'package:frontend/features/map/presentation/pages/map_page.dart';
import 'package:frontend/shared/presentation/pages/app_layout.dart';
import 'package:frontend/shared/widgets/my_button.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_field.dart';
import 'package:frontend/features/auth/presentation/widgets/oauth_button.dart';
import 'package:frontend/shared/themes/theme.dart';

class SignInPage extends StatefulWidget {
  final void Function()? togglePages;

  const SignInPage({super.key, required this.togglePages});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AppLayout()),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
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
                      'Log In.',
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
                    const SizedBox(height: 16),
                    AuthField(controller: emailController, hintText: 'Email'),
                    const SizedBox(height: 16),
                    AuthField(
                      controller: passwordController,
                      hintText: 'Password',
                      isObscureText: true,
                    ),
                    const SizedBox(height: 20),
                    MyButton(
                      btnText: state is AuthLoading ? "Loading..." : "Log In",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            LoginRequested(
                              LoginReqParams(
                                usernameOrEmail: emailController.text,
                                password: passwordController.text,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        GestureDetector(
                          onTap: widget.togglePages,
                          child: Text(
                            'Sign Up',
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
