part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  const LoginSuccess({required this.token});

  final String token;
}

class LoginFailure extends LoginState {
  final List<String> errors;

  const LoginFailure({required this.errors});

  @override
  List<Object> get props => [errors];
}
