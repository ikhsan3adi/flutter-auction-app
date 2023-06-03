part of 'my_bid_bloc.dart';

abstract class MyBidEvent extends Equatable {
  const MyBidEvent();

  @override
  List<Object> get props => [];
}

class FetchMyBidAuction extends MyBidEvent {}

class FilterMyBid extends MyBidEvent {
  const FilterMyBid({required this.filter});

  final MyBidFilter filter;

  @override
  List<Object> get props => [filter];
}
