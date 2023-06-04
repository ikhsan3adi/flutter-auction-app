import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_online_auction_app/features/new_item/new_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:formz/formz.dart';

part 'new_item_event.dart';
part 'new_item_state.dart';

class NewItemBloc extends Bloc<NewItemEvent, NewItemState> {
  NewItemBloc() : super(const NewItemState()) {
    on<ItemNameChanged>(_onItemNameChanged);
    on<ItemDescChanged>(_onItemDescChanged);
    on<ItemPriceChanged>(_onItemPriceChanged);
  }

  void _onItemNameChanged(ItemNameChanged event, Emitter<NewItemState> emit) {
    final itemName = ItemName.dirty(event.itemName);
    emit(state.copyWith(
      formState: state.formState.copyWith(itemName: itemName),
      isValid: Formz.validate([itemName, state.formState.itemDesc, state.formState.itemPrice]),
    ));
  }

  void _onItemDescChanged(ItemDescChanged event, Emitter<NewItemState> emit) {
    final itemDesc = ItemDesc.dirty(event.itemDesc);
    emit(state.copyWith(
      formState: state.formState.copyWith(itemDesc: itemDesc),
      isValid: Formz.validate([state.formState.itemName, itemDesc, state.formState.itemPrice]),
    ));
  }

  void _onItemPriceChanged(ItemPriceChanged event, Emitter<NewItemState> emit) {
    final itemPrice = ItemPrice.dirty(event.itemPrice);
    emit(state.copyWith(
      formState: state.formState.copyWith(itemPrice: itemPrice),
      isValid: Formz.validate([state.formState.itemName, state.formState.itemDesc, itemPrice]),
    ));
  }
}
