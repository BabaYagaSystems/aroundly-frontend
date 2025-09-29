import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  final Auth0 _auth0; // NOU

  AuthBloc(this._login, this._register, this._repo, this._auth0)
      : super(const AuthState.unknown()) {
    on<AuthAppStarted>(_onAppStarted);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthRegisterSubmitted>(_onRegisterSubmitted);
    on<Auth0LoginRequested>(_onAuth0LoginRequested); // NOU
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onAppStarted(AuthAppStarted event, Emitter<AuthState> emit) async {
    final hasSession = await _repo.hasSession();
    emit(hasSession ? const AuthState.authenticated() : const AuthState.unauthenticated());
  }

  // PĂSTRAT: Handler pentru login cu email/parolă
  Future<void> _onLoginSubmitted(AuthLoginSubmitted event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final (user, _) = await _login(event.usernameOrEmail, event.password);
      if (user != null) {
        emit(AuthState.authSuccess(user));
      } else {
        emit(const AuthState.authenticated());
      }
    } catch (err) {
      emit(AuthState.failure(err.toString()));
    }
  }

  // PĂSTRAT: Handler pentru register
  Future<void> _onRegisterSubmitted(
    AuthRegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _register(event.username, event.email, event.password);
      emit(const AuthState.registered());
    } catch (err) {
      emit(AuthState.failure(err.toString()));
    }
  }

  // NOU: Handler pentru login cu Auth0
  Future<void> _onAuth0LoginRequested(Auth0LoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final credentials = await _auth0
          .webAuthentication(scheme: dotenv.env['AUTH0_SCHEME']!)
          .login(audience: dotenv.env['AUTH0_API_IDENTIFIER']!);

      await _repo.loginWithCredentials(credentials);

      final user = User(
        username: credentials.user.name ?? 'Unknown Name',
        email: credentials.user.email ?? 'No Email',
      );

      emit(AuthState.authSuccess(user));
    } on WebAuthenticationException {
      emit(const AuthState.unauthenticated());
    } catch (err) {
      emit(AuthState.failure(err.toString()));
    }
  }

  Future<void> _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    // Logout din ambele sisteme
    try {
      await _auth0.webAuthentication(scheme: dotenv.env['AUTH0_SCHEME']!).logout();
    } catch (_) {
      // Ignorăm erorile aici, s-ar putea ca sesiunea Auth0 să nu existe
    }
    await _repo.logout();
    emit(const AuthState.unauthenticated());
  }
}