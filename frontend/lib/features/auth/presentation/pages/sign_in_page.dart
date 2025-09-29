import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:frontend/shared/presentation/pages/app_layout.dart';
import 'package:frontend/shared/widgets/my_button.dart';
import 'package:frontend/features/auth/presentation/widgets/auth_field.dart';
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

  void _showError(String msg) {
    if(mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const AppLayout()),
            (route) => false,
          );
        } else if (state.error != null) {
          _showError(state.error!);
        }
      },
      builder: (context, state) {
        final isLoading = state.loading;

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 82),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Log In.',
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 35),
                    
                    // NOU: Buton pentru Auth0
                    MyButton(
                      btnText: 'Continue with SSO / Google',
                      loading: isLoading,
                      onPressed: isLoading ? null : () {
                        context.read<AuthBloc>().add(Auth0LoginRequested());
                      },
                    ),

                    const SizedBox(height: 24),
                    // NOU: Separator
                    Row(
                      children: [
                        Expanded(child: Divider(thickness: 0.8, color: AppColors.surfaceDark30)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('Or', style: TextStyle(color: AppColors.surfaceDark30)),
                        ),
                        Expanded(child: Divider(thickness: 0.8, color: AppColors.surfaceDark30)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // PĂSTRAT: Câmpurile pentru email/parolă
                    AuthField(
                      controller: emailController,
                      hintText: 'Email or Username',
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 16),
                    AuthField(
                      controller: passwordController,
                      hintText: 'Password',
                      isObscureText: true,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 20),
                    
                    // PĂSTRAT: Buton pentru login cu email/parolă
                    MyButton(
                      btnText: 'Log In with Email',
                      bgColor: AppColors.surfaceDark20, // Culoare diferită pentru a distinge
                      loading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () {
                              if (formKey.currentState?.validate() ?? false) {
                                context.read<AuthBloc>().add(
                                      AuthLoginSubmitted(
                                        emailController.text.trim(),
                                        passwordController.text,
                                      ),
                                    );
                              }
                            },
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account? '),
                        GestureDetector(
                          onTap: widget.togglePages,
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
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