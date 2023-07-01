import 'package:formz/formz.dart';
import 'package:regexpattern/regexpattern.dart';

enum EmailValidationError { empty, wrongLength, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    } else if (value.length > 64) {
      return EmailValidationError.wrongLength;
    } else if (!value.isEmail()) {
      return EmailValidationError.invalid;
    }
    return null;
  }
}

extension EmailValidationErrorX on EmailValidationError {
  String get text {
    switch (this) {
      case EmailValidationError.empty:
        return 'Email cannot be empty';
      case EmailValidationError.wrongLength:
        return 'Maximum length is 64 characters';
      case EmailValidationError.invalid:
        return 'Invalid email';
    }
  }
}
