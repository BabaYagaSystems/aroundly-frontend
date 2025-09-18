part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthAppStarted extends AuthEvent {}

class AuthLoginSubmitted extends AuthEvent {
  final String usernameOrEmail;
  final String password;
  AuthLoginSubmitted(this.usernameOrEmail, this.password);
}

class AuthRegisterSubmitted extends AuthEvent {
  final String username, email, password;
  AuthRegisterSubmitted(this.username, this.email, this.password);
}

class AuthLogoutRequested extends AuthEvent {}
