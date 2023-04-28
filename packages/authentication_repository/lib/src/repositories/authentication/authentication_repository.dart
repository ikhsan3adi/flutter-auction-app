import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'package:equatable/equatable.dart';

class AuthenticationRepository extends Equatable {
  AuthenticationRepository({required AuthenticationApiClient apiClient}) : _apiClient = apiClient;

  final AuthenticationApiClient _apiClient;

  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get authStatus async* {
    yield AuthUnknown(messages: []);
    yield* _controller.stream;
  }

  @override
  List<Object?> get props => [_apiClient, _controller, authStatus];

  void changeAuthStatus({required AuthStatus status}) {
    _controller.add(status);
  }

  Future<void> authenticationCheck() async {
    await _apiClient.authenticationCheck();
  }

  Future<void> register({required User user}) async {
    await _apiClient.register(user);
  }

  Future<String?> login({required String username, required String password}) async {
    final token = await _apiClient.login(username, password);

    return token;
  }

  /// logout requested!
  Future<void> logout() async {
    _controller.add(Unauthenticated(messages: ['Logout requested']));
    await _apiClient.logout();
  }
}
