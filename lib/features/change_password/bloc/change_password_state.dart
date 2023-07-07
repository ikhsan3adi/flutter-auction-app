part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = FormzSubmissionStatus.initial,
    this.oldPassword = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.isValid = false,
    this.isPasswordMatch = false,
    this.errorMessage,
  });

  final FormzSubmissionStatus status;
  final Password oldPassword;
  final Password newPassword;
  final Password confirmPassword;
  final bool isValid;
  final bool isPasswordMatch;
  final String? errorMessage;

  @override
  List<Object> get props => [
        status,
        oldPassword,
        newPassword,
        confirmPassword,
        isValid,
        isPasswordMatch,
        errorMessage ?? String,
      ];

  ChangePasswordState copyWith({
    FormzSubmissionStatus? status,
    Password? oldPassword,
    Password? newPassword,
    Password? confirmPassword,
    bool? isValid,
    bool? isPasswordMatch,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValid: isValid ?? this.isValid,
      isPasswordMatch: isPasswordMatch ?? this.isPasswordMatch,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
