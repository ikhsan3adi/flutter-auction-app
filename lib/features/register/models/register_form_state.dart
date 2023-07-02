import 'package:formz/formz.dart';

import 'package:flutter_online_auction_app/shared/shared.dart';

class RegisterFormState with FormzMixin {
  const RegisterFormState({
    this.status = FormzSubmissionStatus.initial,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    required this.phone,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final Name name;
  final Email email;
  final Phone phone;

  RegisterFormState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
    Name? name,
    Email? email,
    Phone? phone,
  }) {
    return RegisterFormState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [username, password, name, email, phone];
}
