part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.formState = const LoginFormState(
      username: Username.pure(),
      password: Password.pure(),
    ),
    this.isValid = false,
    this.errorMessage,
  });

  final LoginFormState formState;
  final bool isValid;
  final String? errorMessage;

  LoginState copyWith({
    LoginFormState? formState,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      formState: formState ?? this.formState,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [formState, isValid, errorMessage ?? ''];
}
