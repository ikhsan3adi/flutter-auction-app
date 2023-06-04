import 'package:formz/formz.dart';

enum ItemPriceValidationError { empty, toolittle }

class ItemPrice extends FormzInput<int, ItemPriceValidationError> {
  const ItemPrice.pure() : super.pure(0);
  const ItemPrice.dirty([super.value = 0]) : super.dirty();

  @override
  ItemPriceValidationError? validator(int value) {
    if (value <= 0) return ItemPriceValidationError.empty;
    if (value < 1000) return ItemPriceValidationError.toolittle;
    return null;
  }
}

extension ItemPriceValidationErrorX on ItemPriceValidationError {
  String get text {
    switch (this) {
      case ItemPriceValidationError.empty:
        return 'Price cannot be empty';
      case ItemPriceValidationError.toolittle:
        return 'At least 1000';
    }
  }
}
