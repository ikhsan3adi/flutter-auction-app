import 'authentication_api.dart';
import 'package:equatable/equatable.dart';

class AuthenticationRepository extends Equatable {
  const AuthenticationRepository({required AuthenticationApiClient apiClient}) : _apiClient = apiClient;

  final AuthenticationApiClient _apiClient;

  @override
  List<Object?> get props => [_apiClient];
}
