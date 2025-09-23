import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/presentation/pages/auth_page.dart';
import 'package:frontend/shared/widgets/my_button.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (prev, curr) => prev.authenticated && !curr.authenticated,
          listener: (context, state) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const AuthPage()),
              (route) => false,
            );
          },
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.authenticated) {
              final username = state.user?.username ?? '—';
              //final email = state.user?.email ?? '—';

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Text(
                  //   'Profile',
                  //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  // ),
                  // const SizedBox(height: 16),

                  // Username
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Username: $username',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  // const SizedBox(height: 10),

                  // // Email
                  // Row(
                  //   children: [
                  //     const Icon(Icons.email, size: 20),
                  //     const SizedBox(width: 8),
                  //     Expanded(
                  //       child: Text(
                  //         'Email: $email',
                  //         style: const TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 30),

                  MyButton(
                    btnText: "Log Out",
                    bgColor: Colors.red,
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogoutRequested());
                    },
                  ),
                ],
              );
            } else {
              return const Center(child: Text('Redirecting...'));
            }
          },
        ),
      ),
    );
  }
}
