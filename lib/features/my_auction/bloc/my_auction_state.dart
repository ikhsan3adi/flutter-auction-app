part of 'my_auction_bloc.dart';

abstract class MyAuctionState extends Equatable {
  const MyAuctionState();

  @override
  List<Object> get props => [];
}

class MyAuctionInitial extends MyAuctionState {}

class MyAuctionLoading extends MyAuctionState {}

class MyAuctionLoaded extends MyAuctionState {
  const MyAuctionLoaded({required this.auctions});

  final List<Auction> auctions;

  @override
  List<Object> get props => [auctions];
}

class MyAuctionError extends MyAuctionState {
  const MyAuctionError({required this.messages});

  final List<String> messages;

  @override
  List<Object> get props => [messages];
}
