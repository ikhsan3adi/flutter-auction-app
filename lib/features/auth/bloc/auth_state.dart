part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

abstract class AuthStateError extends AuthState {
  const AuthStateError({required this.messages});

  final List<String> messages;

  @override
  List<Object> get props => [messages];
}

class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateAuthorized extends AuthState {}

class AuthStateUnknown extends AuthStateError {
  const AuthStateUnknown({required super.messages});
}

class AuthStateUnauthorized extends AuthStateError {
  const AuthStateUnauthorized({required this.forced, required super.messages});

  final bool forced;
}
