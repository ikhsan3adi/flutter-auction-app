import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

abstract class AuthenticationApiClient extends Equatable {
  Future<void> authenticationCheck();
  Future<void> register(User user, String password);
  Future<String> login(String username, String password);
  Future<void> logout();
}

class AuthenticationApiClientImpl extends AuthenticationApiClient {
  AuthenticationApiClientImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  List<Object?> get props => [_dio];

  @override
  Future<void> authenticationCheck() async {
    await _dio.get(
      '/items',
      data: {},
    );
  }

  @override
  Future<void> register(User user, String password) async {
    FormData formData = FormData();

    if (user.profileImageUrl != null) {
      formData.files.add(MapEntry(
        "profile_image",
        await MultipartFile.fromFile(user.profileImageUrl!, filename: user.profileImageUrl!.split('/').last),
      ));
    }

    Map<String, dynamic> newUser = user.toJson().map((key, value) => MapEntry(key, value ?? 'null'));

    formData.fields.addAll(newUser.cast<String, String>().entries);
    formData.fields.add(MapEntry('password', password));

    await _dio.post(
      '/users',
      data: formData,
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
