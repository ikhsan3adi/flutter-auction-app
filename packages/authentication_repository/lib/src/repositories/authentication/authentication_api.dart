import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

abstract class AuthenticationApiClient extends Equatable {}

class AuthenticationApiClientImpl extends AuthenticationApiClient {
  AuthenticationApiClientImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  List<Object?> get props => [_dio];

  Future<User> register(User user) async {
    final response = await _dio.post(
      '',
      options: Options(
        headers: {'Authorization': ''},
      ),
      data: user.toJson(),
    );
    if (response.statusCode == 201) {
      final json = response.data;
      final createdUser = User.fromJson(json);
      return createdUser;
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<String> login(String username, String password) async {
    final response = await _dio.post(
      '',
      data: {
        'username': username,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      final json = response.data;
      final token = json['token'] as String;
      return token;
    } else {
      throw Exception('Failed to login user');
    }
  }

  Future<void> logout() async {
    final response = await _dio.post(
      '',
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to logout user');
    }
  }
}
