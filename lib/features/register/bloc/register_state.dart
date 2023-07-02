part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.profileImagePath,
    this.formState = const RegisterFormState(
      username: Username.pure(),
      password: Password.pure(),
      name: Name.pure(),
      email: Email.pure(),
      phone: Phone.pure(),
    ),
    this.isValid = false,
    this.errorMessage,
  });

  final String? profileImagePath;
  final RegisterFormState formState;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object> get props => [profileImagePath ?? String, formState, isValid, errorMessage ?? ''];

  RegisterState copyWith({
    String? profileImagePath,
    RegisterFormState? formState,
    bool? isValid,
    String? errorMessage,
  }) {
    return RegisterState(
      profileImagePath: profileImagePath ?? this.profileImagePath,
      formState: formState ?? this.formState,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
