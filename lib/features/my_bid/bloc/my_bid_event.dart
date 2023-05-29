part of 'my_bid_bloc.dart';

abstract class MyBidEvent extends Equatable {
  const MyBidEvent();

  @override
  List<Object> get props => [];
}

class FetchMyBidAuction extends MyBidEvent {}
