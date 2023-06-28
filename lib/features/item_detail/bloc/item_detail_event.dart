part of 'item_detail_bloc.dart';

abstract class ItemDetailEvent extends Equatable {
  const ItemDetailEvent();

  @override
  List<Object> get props => [];
}

class ItemDetailGetItemEvent extends ItemDetailEvent {
  final Item item;

  const ItemDetailGetItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

class DeleteItem extends ItemDetailEvent {
  const DeleteItem({required this.item});

  final Item item;

  @override
  List<Object> get props => [item];
}
