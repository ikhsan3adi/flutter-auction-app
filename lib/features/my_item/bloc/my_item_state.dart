part of 'my_item_bloc.dart';

abstract class MyItemState extends Equatable {
  const MyItemState();

  @override
  List<Object> get props => [];
}

class MyItemInitial extends MyItemState {}

class MyItemLoading extends MyItemState {}

class MyItemLoaded extends MyItemState {
  const MyItemLoaded({required this.items});

  final List<Item> items;

  @override
  List<Object> get props => [items];
}

class MyItemError extends MyItemState {
  const MyItemError({required this.messages});

  final List<String> messages;

  @override
  List<Object> get props => [messages];
}
