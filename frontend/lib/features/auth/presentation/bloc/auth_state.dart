// auth_state.dart
part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool loading;
  final bool authenticated;
  final bool justRegistered;
  final User? user;
  final String? error;

  const AuthState({
    required this.loading,
    required this.authenticated,
    required this.justRegistered,
    this.user,
    this.error,
  });

  const AuthState.unknown()
    : this(loading: false, authenticated: false, justRegistered: false);

  const AuthState.loading()
    : this(loading: true, authenticated: false, justRegistered: false);

  const AuthState.unauthenticated()
    : this(loading: false, authenticated: false, justRegistered: false);

  const AuthState.registered()
    : this(loading: false, authenticated: false, justRegistered: true);

  // ➜ NEW: authenticated fără user (ex. avem token salvat)
  const AuthState.authenticated()
    : this(loading: false, authenticated: true, justRegistered: false);

  AuthState.authSuccess(User u)
    : this(loading: false, authenticated: true, justRegistered: false, user: u);

  AuthState.failure(String msg)
    : this(
        loading: false,
        authenticated: false,
        justRegistered: false,
        error: msg,
      );

  @override
  List<Object?> get props => [
    loading,
    authenticated,
    justRegistered,
    user,
    error,
  ];
}
