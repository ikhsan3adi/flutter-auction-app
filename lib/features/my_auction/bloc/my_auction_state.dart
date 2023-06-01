part of 'my_auction_bloc.dart';

abstract class MyAuctionState extends Equatable {
  const MyAuctionState();

  @override
  List<Object> get props => [];
}

class MyAuctionInitial extends MyAuctionState {}

class MyAuctionLoading extends MyAuctionState {}

class MyAuctionLoaded extends MyAuctionState {
  const MyAuctionLoaded({
    required this.auctions,
    required this.filteredAuctions,
    this.filter = AuctionFilter.all,
  });

  final List<Auction> auctions;
  final List<Auction> filteredAuctions;
  final AuctionFilter filter;

  MyAuctionLoaded copyWith({
    List<Auction>? auctions,
    List<Auction>? filteredAuctions,
    AuctionFilter? filter,
  }) {
    return MyAuctionLoaded(
      auctions: auctions ?? this.auctions,
      filteredAuctions: filteredAuctions ?? this.filteredAuctions,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [auctions, filteredAuctions, filter];
}

class MyAuctionError extends MyAuctionState {
  const MyAuctionError({required this.messages});

  final List<String> messages;

  @override
  List<Object> get props => [messages];
}
