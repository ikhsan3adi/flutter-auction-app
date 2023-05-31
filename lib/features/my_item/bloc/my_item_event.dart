part of 'my_item_bloc.dart';

abstract class MyItemEvent extends Equatable {
  const MyItemEvent();

  @override
  List<Object> get props => [];
}

class FetchMyItem extends MyItemEvent {}
