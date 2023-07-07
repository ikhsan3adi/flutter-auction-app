import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/src/models/models.dart';

abstract class UserApiClient extends Equatable {
  Future<List<User>> getUsers();
  Future<User> getUser(String id);
  Future<void> updateUser(User user);
  Future<void> changePassword(String oldPassword, String newPassword);
  Future<void> deleteUser(User user);
}

class UserApiClientImpl extends UserApiClient {
  UserApiClientImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  List<Object?> get props => [_dio];

  @override
  Future<List<User>> getUsers() async {
    final response = await _dio.get('/users');

    final List<dynamic> data = response.data['data'];
    final List<User> users = data.map((json) => User.fromJson(json)).toList();
    return users;
  }

  @override
  Future<User> getUser(String id) async {
    final response = await _dio.get('/users/$id');

    final User user = User.fromJson(response.data['data']);
    return user;
  }

  @override
  Future<void> updateUser(User user) async {
    await _dio.patch(
      '/users/${user.id}',
      data: user.toJson(),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    if (user.profileImageUrl == null) return;

    FormData formData = FormData();

    if (user.profileImageUrl != null && user.profileImageUrl!.isNotEmpty) {
      formData.files.add(MapEntry(
        "profile_image",
        await MultipartFile.fromFile(user.profileImageUrl!, filename: user.profileImageUrl!.split('/').last),
      ));
    }

    formData.fields.add(MapEntry('username', user.username));

    print(await _dio.post(
      '/users/images/update',
      data: formData,
    ));
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    await _dio.post(
      '/users/password',
      data: {
        'old_password': oldPassword,
        'new_password': newPassword,
      },
    );
  }

  @override
  Future<void> deleteUser(User user) async {
    await _dio.delete('/users/${user.id}');
  }
}
