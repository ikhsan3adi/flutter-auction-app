part of 'my_item_bloc.dart';

abstract class MyItemEvent extends Equatable {
  const MyItemEvent();

  @override
  List<Object> get props => [];
}

class FetchMyItem extends MyItemEvent {}

class DeleteItem extends MyItemEvent {
  const DeleteItem({required this.item});

  final Item item;

  @override
  List<Object> get props => [item];
}

class FilterMyItem extends MyItemEvent {
  const FilterMyItem({required this.filter});

  final ItemFilter filter;

  @override
  List<Object> get props => [filter];
}
