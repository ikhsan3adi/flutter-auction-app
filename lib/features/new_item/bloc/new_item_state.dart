part of 'new_item_bloc.dart';

class NewItemState extends Equatable {
  const NewItemState({
    this.formState = const NewItemFormState(
      itemName: ItemName.pure(),
      itemDesc: ItemDesc.pure(),
      itemPrice: ItemPrice.pure(),
    ),
    this.isValid = false,
  });

  final NewItemFormState formState;
  final bool isValid;

  NewItemState copyWith({
    NewItemFormState? formState,
    bool? isValid,
  }) {
    return NewItemState(
      formState: formState ?? this.formState,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [formState, isValid];
}
