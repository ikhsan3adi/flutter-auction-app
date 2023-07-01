import 'package:formz/formz.dart';
import 'package:regexpattern/regexpattern.dart';

enum PasswordValidationError { empty, wrongLength, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.length < 8 || value.length > 16) {
      return PasswordValidationError.wrongLength;
    } else if (!value.isPasswordHard()) {
      return PasswordValidationError.invalid;
    }
    return null;
  }
}

extension PasswordValidationErrorX on PasswordValidationError {
  String get text {
    switch (this) {
      case PasswordValidationError.empty:
        return 'Password cannot be empty';
      case PasswordValidationError.wrongLength:
        return 'Password length must between 8 and 16 characters';
      case PasswordValidationError.invalid:
        return 'At least one uppercase letter, one lowercase letter, one number and one special character';
    }
  }
}
