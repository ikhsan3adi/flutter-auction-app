// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final User newUser;

  const RegisterUser({required this.newUser});

  @override
  List<Object> get props => [newUser];
}
