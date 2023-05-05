import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/src/models/models.dart';

abstract class UserApiClient extends Equatable {
  Future<List<User>> getUsers();
  Future<User> getUser(String id);
  Future<void> updateUser(User user);
  Future<void> deleteUser(User user);
}

class UserApiClientImpl extends UserApiClient {
  UserApiClientImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  List<Object?> get props => [_dio];

  @override
  Future<List<User>> getUsers() async {
    final response = await _dio.get('/user');

    final List<dynamic> data = response.data['data'];
    final List<User> users = data.map((json) => User.fromJson(json)).toList();
    return users;
  }

  @override
  Future<User> getUser(String id) async {
    final response = await _dio.get('/user/$id');

    final User user = User.fromJson(response.data['data']);
    return user;
  }

  @override
  Future<void> updateUser(User user) async {
    // TODO image upload
    await _dio.patch('/user/${user.id}');
  }

  @override
  Future<void> deleteUser(User user) async {
    await _dio.delete('/user/${user.id}');
  }
}
