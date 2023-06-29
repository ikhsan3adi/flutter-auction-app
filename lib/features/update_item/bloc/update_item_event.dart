part of 'update_item_bloc.dart';

abstract class UpdateItemEvent extends Equatable {
  const UpdateItemEvent();

  @override
  List<Object> get props => [];
}

class FetchItemData extends UpdateItemEvent {
  const FetchItemData({required this.item});

  final Item item;

  @override
  List<Object> get props => [item];
}

class ItemImagesChanged extends UpdateItemEvent {
  const ItemImagesChanged({required this.imagesPath});

  final List<String> imagesPath;

  @override
  List<Object> get props => [imagesPath];
}

class ItemImageDelete extends UpdateItemEvent {
  const ItemImageDelete({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}

class FormerItemImageDelete extends UpdateItemEvent {
  const FormerItemImageDelete({required this.itemImage});

  final ItemImage itemImage;

  @override
  List<Object> get props => [itemImage];
}

class ItemNameChanged extends UpdateItemEvent {
  const ItemNameChanged({required this.itemName});

  final String itemName;

  @override
  List<Object> get props => [itemName];
}

class ItemDescChanged extends UpdateItemEvent {
  const ItemDescChanged({required this.itemDesc});

  final String itemDesc;

  @override
  List<Object> get props => [itemDesc];
}

class ItemPriceChanged extends UpdateItemEvent {
  const ItemPriceChanged({required this.itemPrice});

  final int itemPrice;

  @override
  List<Object> get props => [itemPrice];
}

class UpdateItem extends UpdateItemEvent {}
