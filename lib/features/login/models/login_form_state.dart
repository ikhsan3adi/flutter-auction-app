import 'package:formz/formz.dart';

import 'package:flutter_online_auction_app/shared/shared.dart';

class LoginFormState with FormzMixin {
  const LoginFormState({
    this.status = FormzSubmissionStatus.initial,
    required this.username,
    required this.password,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Password password;

  LoginFormState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
  }) {
    return LoginFormState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [username, password];
}
