part of 'my_item_bloc.dart';

abstract class MyItemState extends Equatable {
  const MyItemState();

  @override
  List<Object> get props => [];
}

class MyItemInitial extends MyItemState {}

class MyItemLoading extends MyItemState {}

class MyItemLoaded extends MyItemState {
  const MyItemLoaded({
    required this.items,
    required this.filteredItems,
    this.filter = ItemFilter.all,
  });

  final List<Item> items;
  final List<Item> filteredItems;
  final ItemFilter filter;

  @override
  List<Object> get props => [items, filteredItems, filter];

  MyItemLoaded copyWith({
    List<Item>? items,
    List<Item>? filteredItems,
    ItemFilter? filter,
  }) {
    return MyItemLoaded(
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      filter: filter ?? this.filter,
    );
  }
}

class MyItemError extends MyItemState {
  const MyItemError({required this.messages});

  final List<String> messages;

  @override
  List<Object> get props => [messages];
}
