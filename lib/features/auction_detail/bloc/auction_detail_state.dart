part of 'auction_detail_bloc.dart';

abstract class AuctionDetailState extends Equatable {
  const AuctionDetailState();

  @override
  List<Object> get props => [];
}

class AuctionDetailLoading extends AuctionDetailState {}

class AuctionDetailLoaded extends AuctionDetailState {
  final Auction auction;
  final List<Bid> bidList;

  const AuctionDetailLoaded({required this.auction, required this.bidList});

  @override
  List<Object> get props => [auction, bidList];
}
