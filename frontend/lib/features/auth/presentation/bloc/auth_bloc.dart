import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _login;
  final RegisterUseCase _register;
  final AuthRepository _repo;

  AuthBloc(this._login, this._register, this._repo)
    : super(const AuthState.unknown()) {
    on<AuthAppStarted>(_onAppStarted);
    on<AuthLoginSubmitted>(_onLogin);
    on<AuthRegisterSubmitted>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onAppStarted(AuthAppStarted e, Emitter<AuthState> emit) async {
    final has = await _repo.hasSession();
    emit(
      has ? const AuthState.authenticated() : const AuthState.unauthenticated(),
    );
  }

  Future<void> _onLogin(AuthLoginSubmitted e, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final (user, _) = await _login(e.usernameOrEmail, e.password);
      if (user != null) {
        emit(AuthState.authSuccess(user));
      } else {
        // we only have token; mark authenticated without user details
        emit(const AuthState.authenticated());
      }
    } catch (err) {
      emit(AuthState.failure(err.toString()));
    }
  }

  Future<void> _onRegister(
    AuthRegisterSubmitted e,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _register(e.username, e.email, e.password);
      emit(const AuthState.registered());
    } catch (err) {
      emit(AuthState.failure(err.toString()));
    }
  }

  Future<void> _onLogout(AuthLogoutRequested e, Emitter<AuthState> emit) async {
    await _repo.logout();
    emit(const AuthState.unauthenticated());
  }
}
