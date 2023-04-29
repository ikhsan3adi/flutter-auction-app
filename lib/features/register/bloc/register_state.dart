part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final List<String> errors;

  const RegisterFailure({required this.errors});

  @override
  List<Object> get props => [errors];
}
