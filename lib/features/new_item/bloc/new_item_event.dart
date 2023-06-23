part of 'new_item_bloc.dart';

abstract class NewItemEvent extends Equatable {
  const NewItemEvent();

  @override
  List<Object> get props => [];
}

class ItemImagesChanged extends NewItemEvent {
  const ItemImagesChanged({required this.imagesPath});

  final List<String> imagesPath;

  @override
  List<Object> get props => [imagesPath];
}

class ItemImageDelete extends NewItemEvent {
  const ItemImageDelete({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
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

  final dynamic itemPrice;

  @override
  List<Object> get props => [itemPrice];
}

class CreateNewItem extends NewItemEvent {}
