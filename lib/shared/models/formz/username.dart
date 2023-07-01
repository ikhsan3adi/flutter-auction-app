import 'package:formz/formz.dart';
import 'package:regexpattern/regexpattern.dart';

enum UsernameValidationError { empty, wrongLength, invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) {
      return UsernameValidationError.empty;
    } else if (value.length < 4 || value.length > 16) {
      return UsernameValidationError.wrongLength;
    } else if (!value.isUsername()) {
      return UsernameValidationError.invalid;
    }
    return null;
  }
}

extension UsernameValidationErrorX on UsernameValidationError {
  String get text {
    switch (this) {
      case UsernameValidationError.empty:
        return 'Username cannot be empty';
      case UsernameValidationError.wrongLength:
        return 'Username length must between 4 and 16 characters';
      case UsernameValidationError.invalid:
        return 'Username should only contains alphanumeric character';
    }
  }
}
