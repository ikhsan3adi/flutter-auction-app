part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends LoginEvent {
  const UsernameChanged({required this.username});

  final String username;

  @override
  List<Object> get props => [username];
}

class PasswordChanged extends LoginEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginRequested extends LoginEvent {}
