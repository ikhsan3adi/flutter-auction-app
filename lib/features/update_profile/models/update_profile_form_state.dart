import 'package:formz/formz.dart';

import 'package:flutter_online_auction_app/shared/shared.dart';

class UpdateProfileFormState with FormzMixin {
  const UpdateProfileFormState({
    this.status = FormzSubmissionStatus.initial,
    required this.name,
    required this.email,
    required this.phone,
  });

  final FormzSubmissionStatus status;
  final Name name;
  final Email email;
  final Phone phone;

  UpdateProfileFormState copyWith({
    FormzSubmissionStatus? status,
    Name? name,
    Email? email,
    Phone? phone,
  }) {
    return UpdateProfileFormState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [name, email, phone];
}
