import 'package:formz/formz.dart';

enum NameValidationError { empty, wrongLength, invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.empty;
    } else if (value.length > 64) {
      return NameValidationError.wrongLength;
    }
    return null;
  }
}

extension NameValidationErrorX on NameValidationError {
  String get text {
    switch (this) {
      case NameValidationError.empty:
        return 'Name cannot be empty';
      case NameValidationError.wrongLength:
        return 'Name length must between 1 and 64 characters';
      case NameValidationError.invalid:
        return 'Name should only contains alphanumeric character';
    }
  }
}
