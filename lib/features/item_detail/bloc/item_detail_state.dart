part of 'item_detail_bloc.dart';

abstract class ItemDetailState extends Equatable {
  const ItemDetailState();

  @override
  List<Object> get props => [];
}

class ItemDetailLoading extends ItemDetailState {}

class ItemDetailLoaded extends ItemDetailState {
  const ItemDetailLoaded({required this.item});

  final Item item;

  @override
  List<Object> get props => [item];
}

class ItemDetailError extends ItemDetailState {
  const ItemDetailError({required this.messages});

  final List<String> messages;

  @override
  List<Object> get props => [messages];
}

class ItemDetailDeleted extends ItemDetailState {}
