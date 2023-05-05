import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

abstract class AuthenticationApiClient extends Equatable {
  Future<void> authenticationCheck();
  Future<void> register(User user);
  Future<String> login(String username, String password);
  Future<void> logout();
}

class AuthenticationApiClientImpl extends AuthenticationApiClient {
  AuthenticationApiClientImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  final String _secretKey =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImFkbWluIiwiaXNzIjoib25saW5lX2F1Y3Rpb25fYXBpIiwiaWF0IjoxNjgxODk1MzkxLCJleHAiOjE2ODE5ODE3OTEsIm5iZiI6MTY4MTg5NTM5MSwianRpIjoxNjgxODk1MzkxfQ.qTCBNs6xddi3idkHSqxc4qBWEzNf5H6rWt7K7LgpzIU';

  @override
  List<Object?> get props => [_dio];

  @override
  Future<void> authenticationCheck() async {
    await _dio.get(
      '/item',
      data: {},
    );
  }

  @override
  Future<void> register(User user) async {
    // TODO image upload
    await _dio.post(
      '/user',
      data: user.toJson(),
      options: Options(
        headers: {'Authorization': 'Bearer $_secretKey'},
      ),
    );
  }

  @override
  Future<String> login(String username, String password) async {
    final response = await _dio.post(
      '/login',
      data: {
        'username': username,
        'password': password,
      },
    );

    final token = response.data['token'] as String;
    return token;
  }

  @override
  Future<void> logout() async {
    await _dio.post(
      '/logout',
    );
  }
}
