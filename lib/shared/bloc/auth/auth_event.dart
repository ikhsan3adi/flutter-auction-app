// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthAppStartedEvent extends AuthEvent {}

class _AuthStatusChangedEvent extends AuthEvent {
  const _AuthStatusChangedEvent({required this.status});

  final AuthStatus status;

  @override
  List<Object> get props => [status];
}

class AuthLogoutRequestedEvent extends AuthEvent {}
