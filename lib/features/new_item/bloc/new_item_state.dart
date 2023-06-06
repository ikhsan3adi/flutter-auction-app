part of 'new_item_bloc.dart';

class NewItemState extends Equatable {
  const NewItemState({
    this.imagesPath = const [],
    this.formState = const ItemFormState(
      itemName: ItemName.pure(),
      itemDesc: ItemDesc.pure(),
      itemPrice: ItemPrice.pure(),
    ),
    this.isValid = false,
    this.errorMessage,
  });

  final List<String> imagesPath;
  final ItemFormState formState;
  final bool isValid;
  final String? errorMessage;

  NewItemState copyWith({
    List<String>? imagesPath,
    ItemFormState? formState,
    bool? isValid,
    String? errorMessage,
  }) {
    return NewItemState(
      imagesPath: imagesPath ?? this.imagesPath,
      formState: formState ?? this.formState,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [imagesPath, formState, isValid, errorMessage ?? ''];
}
