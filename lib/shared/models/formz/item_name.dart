import 'package:formz/formz.dart';

enum ItemNameValidationError { empty, tooShort }

class ItemName extends FormzInput<String, ItemNameValidationError> {
  const ItemName.pure() : super.pure('');
  const ItemName.dirty([super.value = '']) : super.dirty();

  @override
  ItemNameValidationError? validator(String value) {
    if (value.isEmpty) {
      return ItemNameValidationError.empty;
    } else if (value.length < 3) {
      return ItemNameValidationError.tooShort;
    }
    return null;
  }
}

extension ItemNameValidationErrorX on ItemNameValidationError {
  String get text {
    switch (this) {
      case ItemNameValidationError.empty:
        return 'Item name cannot be empty';
      case ItemNameValidationError.tooShort:
        return 'At least 3 characters';
    }
  }
}
