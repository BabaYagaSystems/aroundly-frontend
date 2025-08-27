part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final LoginReqParams params;
  LoginRequested(this.params);
  @override
  List<Object?> get props => [params];
}

class RegisterRequested extends AuthEvent {
  final RegisterReqParams params;
  RegisterRequested(this.params);
  @override
  List<Object?> get props => [params];
}
