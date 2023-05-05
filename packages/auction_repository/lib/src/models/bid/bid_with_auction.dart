part of 'bid.dart';

@JsonSerializable()
class BidWithAuction extends Equatable {
  const BidWithAuction({
    required this.auction,
    required this.bids,
  });

  final Auction auction;
  final List<Bid> bids;

  @override
  List<Object?> get props => [auction, bids];

  factory BidWithAuction.fromJson(Map<String, dynamic> json) => _$BidWithAuctionFromJson(json);

  Map<String, dynamic> toJson() => _$BidWithAuctionToJson(this);
}
