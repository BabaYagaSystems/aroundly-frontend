part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthAppStarted extends AuthEvent {}

// PENTRU EMAIL/PAROLĂ
class AuthLoginSubmitted extends AuthEvent {
  final String usernameOrEmail;
  final String password;
  const AuthLoginSubmitted(this.usernameOrEmail, this.password);
}

// PENTRU EMAIL/PAROLĂ
class AuthRegisterSubmitted extends AuthEvent {
  final String username, email, password;
  const AuthRegisterSubmitted(this.username, this.email, this.password);
}

// PENTRU AUTH0
class Auth0LoginRequested extends AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}