import 'package:formz/formz.dart';
import 'package:regexpattern/regexpattern.dart';

enum PhoneValidationError { empty, wrongLength, invalid }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');
  const Phone.dirty([super.value = '']) : super.dirty();

  @override
  PhoneValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneValidationError.empty;
    } else if (value.length < 4 || value.length > 36) {
      return PhoneValidationError.wrongLength;
    } else if (!value.isPhone()) {
      return PhoneValidationError.invalid;
    }
    return null;
  }
}

extension PhoneValidationErrorX on PhoneValidationError {
  String get text {
    switch (this) {
      case PhoneValidationError.empty:
        return 'Phone cannot be empty';
      case PhoneValidationError.wrongLength:
        return 'Phone length must between 4 and 36 characters';
      case PhoneValidationError.invalid:
        return 'Invalid phone number';
    }
  }
}
