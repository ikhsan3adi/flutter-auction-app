import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthenticationRepository authenticationRepository,
    required TokenRepository tokenRepository,
  })  : _authenticationRepository = authenticationRepository,
        _tokenRepository = tokenRepository,
        super(AuthStateInitial()) {
    _authStatusSubscription = _authenticationRepository.authStatus.listen(
      (event) => add(_AuthStatusChangedEvent(status: event)),
    );

    on<AuthAppStartedEvent>(_appStarted);
    on<_AuthStatusChangedEvent>(_onAuthStatusChanged);
    on<AuthLogoutRequestedEvent>(_onLogoutRequested);
  }

  final AuthenticationRepository _authenticationRepository;
  final TokenRepository _tokenRepository;

  late final StreamSubscription<AuthStatus> _authStatusSubscription;

  Future<void> _appStarted(AuthAppStartedEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthStateLoading());
      await _authenticationRepository.authenticationCheck();
      _authenticationRepository.changeAuthStatus(
        status: Authenticated(accessToken: _tokenRepository.token!.accessToken),
      );
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
      _tokenRepository.removeToken();
    } on DioError catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: AuthUnknown(messages: e.errorsMessages),
      );
    } catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: AuthUnknown(messages: [e.toString()]),
      );
    }
  }

  void _onAuthStatusChanged(_AuthStatusChangedEvent event, Emitter<AuthState> emit) {
    switch (event.status.runtimeType) {
      case Authenticated:
        _tokenRepository.setToken(accessToken: (event.status as Authenticated).accessToken);
        return emit(AuthStateAuthorized());
      case Unauthenticated:
        _tokenRepository.removeToken();
        return emit(AuthStateUnauthorized(
          messages: (event.status as Unauthenticated).messages,
          forced: (event.status as Unauthenticated).forced,
        ));
      case AuthUnknown:
        return emit(AuthStateUnknown(messages: (event.status as AuthUnknown).messages));
    }
  }

  Future<void> _onLogoutRequested(AuthLogoutRequestedEvent event, Emitter<AuthState> emit) async {
    await _authenticationRepository.logout();
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}
