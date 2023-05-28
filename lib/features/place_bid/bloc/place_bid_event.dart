part of 'place_bid_bloc.dart';

abstract class PlaceBidEvent extends Equatable {
  const PlaceBidEvent();

  @override
  List<Object> get props => [];
}

class AttemptPlaceBid extends PlaceBidEvent {
  const AttemptPlaceBid({
    required this.auctionId,
    required this.bidPrice,
  });

  final String auctionId;
  final int bidPrice;

  @override
  List<Object> get props => [auctionId, bidPrice];
}
