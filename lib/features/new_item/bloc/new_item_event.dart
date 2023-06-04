part of 'new_item_bloc.dart';

abstract class NewItemEvent extends Equatable {
  const NewItemEvent();

  @override
  List<Object> get props => [];
}

class ItemNameChanged extends NewItemEvent {
  const ItemNameChanged({required this.itemName});

  final String itemName;

  @override
  List<Object> get props => [itemName];
}

class ItemDescChanged extends NewItemEvent {
  const ItemDescChanged({required this.itemDesc});

  final String itemDesc;

  @override
  List<Object> get props => [itemDesc];
}

class ItemPriceChanged extends NewItemEvent {
  const ItemPriceChanged({required this.itemPrice});

  final int itemPrice;

  @override
  List<Object> get props => [itemPrice];
}
