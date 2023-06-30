part of 'auction_detail_bloc.dart';

abstract class AuctionDetailState extends Equatable {
  const AuctionDetailState();

  @override
  List<Object> get props => [];
}

class AuctionDetailLoading extends AuctionDetailState {}

class AuctionDetailLoaded extends AuctionDetailState {
  const AuctionDetailLoaded({required this.auction, required this.bidList});

  final Auction auction;
  final List<Bid> bidList;

  @override
  List<Object> get props => [auction, bidList];
}

class AuctionDetailError extends AuctionDetailState {
  const AuctionDetailError({required this.messages});

  final List<String> messages;

  @override
  List<Object> get props => [messages];
}

class AuctionDeleted extends AuctionDetailLoaded {
  const AuctionDeleted({required super.auction, required super.bidList});
}
