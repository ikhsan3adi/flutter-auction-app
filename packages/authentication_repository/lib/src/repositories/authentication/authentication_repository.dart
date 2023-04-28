import 'dart:async';

import 'package:dio/dio.dart';
import 'package:user_repository/user_repository.dart';

import 'authentication_api.dart';
import 'package:equatable/equatable.dart';

enum AuthStatus { unknown, unauthenticated, authenticated }

class AuthenticationRepository extends Equatable {
  AuthenticationRepository({required AuthenticationApiClient apiClient}) : _apiClient = apiClient;

  final AuthenticationApiClient _apiClient;

  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get authStatus async* {
    await Future.delayed(const Duration(seconds: 1));
    yield AuthStatus.unknown;
    yield* _controller.stream;
  }

  @override
  List<Object?> get props => [_apiClient, _controller, authStatus];

  Future<void> register({required User user}) async {
    await _apiClient.register(user);
  }

  Future<String?> login({required String username, required String password}) async {
    try {
      final token = await _apiClient.login(username, password);

      _controller.add(AuthStatus.authenticated);

      return token;
    } on DioError catch (_) {
      _controller.add(AuthStatus.unauthenticated);
      rethrow;
    } catch (e) {
      _controller.add(AuthStatus.unauthenticated);
      rethrow;
    }
  }

  /// logout or token expired
  Future<void> logout() async {
    _controller.add(AuthStatus.unauthenticated);
    await _apiClient.logout();
  }
}
