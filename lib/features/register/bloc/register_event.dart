// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class AttemptRegister extends RegisterEvent {
  const AttemptRegister({required this.newUser});

  final User newUser;

  @override
  List<Object> get props => [newUser];
}
