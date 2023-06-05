part of 'new_item_bloc.dart';

class NewItemState extends Equatable {
  const NewItemState({
    this.imagesPath = const [],
    this.formState = const NewItemFormState(
      itemName: ItemName.pure(),
      itemDesc: ItemDesc.pure(),
      itemPrice: ItemPrice.pure(),
    ),
    this.isValid = false,
  });

  final List<String> imagesPath;
  final NewItemFormState formState;
  final bool isValid;

  NewItemState copyWith({
    List<String>? imagesPath,
    NewItemFormState? formState,
    bool? isValid,
  }) {
    return NewItemState(
      imagesPath: imagesPath ?? this.imagesPath,
      formState: formState ?? this.formState,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [imagesPath, formState, isValid];
}
