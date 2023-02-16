part of 'auction_detail_bloc.dart';

abstract class AuctionDetailEvent extends Equatable {
  const AuctionDetailEvent();

  @override
  List<Object> get props => [];
}

class AuctionDetailGetAuctionEvent extends AuctionDetailEvent {
  final Lelang lelang;

  const AuctionDetailGetAuctionEvent(this.lelang);

  @override
  List<Object> get props => [lelang];
}
