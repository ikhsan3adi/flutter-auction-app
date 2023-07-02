part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class ProfileImageChanged extends RegisterEvent {
  const ProfileImageChanged({required this.imagePath});

  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}

class UsernameChanged extends RegisterEvent {
  const UsernameChanged({required this.username});

  final String username;

  @override
  List<Object> get props => [username];
}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class NameChanged extends RegisterEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class EmailChanged extends RegisterEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PhoneChanged extends RegisterEvent {
  const PhoneChanged({required this.phone});

  final String phone;

  @override
  List<Object> get props => [phone];
}

class AttemptRegister extends RegisterEvent {}
