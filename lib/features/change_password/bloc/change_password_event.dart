part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class OldPasswordChanged extends ChangePasswordEvent {
  const OldPasswordChanged({required this.oldPassword});

  final String oldPassword;

  @override
  List<Object> get props => [oldPassword];
}

class NewPasswordChanged extends ChangePasswordEvent {
  const NewPasswordChanged({required this.newPassword});

  final String newPassword;

  @override
  List<Object> get props => [newPassword];
}

class ConfirmPasswordChanged extends ChangePasswordEvent {
  const ConfirmPasswordChanged({required this.confirmPassword});

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class SubmitChanges extends ChangePasswordEvent {}
