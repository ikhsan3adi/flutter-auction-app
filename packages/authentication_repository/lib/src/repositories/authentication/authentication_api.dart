import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

abstract class AuthenticationApiClient extends Equatable {
  Future<void> register(User user);
  Future<String> login(String username, String password);
  Future<void> logout();
}

class AuthenticationApiClientImpl extends AuthenticationApiClient {
  AuthenticationApiClientImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  final String _secretKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6IkphdmFJblVzZSIsImV4cCI6MTY1MTAyOTU5MSwiaWF0IjoxNjUxMDI5NTkxfQ.GEqEGG2K-AQwjGEwDRzChXRIQVm5GtJPbTfcXHrgX5w';

  @override
  List<Object?> get props => [_dio];

  @override
  Future<void> register(User user) async {
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
