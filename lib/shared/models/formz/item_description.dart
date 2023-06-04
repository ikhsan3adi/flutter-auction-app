import 'package:formz/formz.dart';

enum ItemDescValidationError { tooLong }

class ItemDesc extends FormzInput<String, ItemDescValidationError> {
  const ItemDesc.pure() : super.pure('');
  const ItemDesc.dirty([super.value = '']) : super.dirty();

  @override
  ItemDescValidationError? validator(String value) {
    if (value.length >= 2000) {
      return ItemDescValidationError.tooLong;
    }
    return null;
  }
}

extension ItemDescValidationErrorX on ItemDescValidationError {
  String get text {
    switch (this) {
      case ItemDescValidationError.tooLong:
        return 'Maximum length is 2000 characters';
    }
  }
}
