import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/user_repository.dart';
import 'package:auction_repository/auction_repository.dart';

part 'bid.g.dart';
part 'bid_with_auction.dart';

@JsonSerializable()
class Bid extends Equatable {
  @JsonKey(name: 'bid_id')
  final String id;
  @JsonKey(name: 'auction_id')
  final String auctionId;
  @JsonKey(name: 'bid_price', fromJson: int.parse, defaultValue: 0)
  final int bidPrice;
  @JsonKey(name: 'bidder')
  final User? bidder;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'profile_image')
  final String? profileImageUrl;
  @JsonKey(name: 'mine', defaultValue: false)
  final bool mine;

  const Bid({
    required this.id,
    required this.auctionId,
    required this.bidPrice,
    this.bidder,
    required this.createdAt,
    required this.profileImageUrl,
    this.mine = false,
  });

  factory Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);

  Map<String, dynamic> toJson() => _$BidToJson(this);

  @override
  List<Object?> get props => [
        id,
        auctionId,
        bidPrice,
        bidder,
        createdAt,
        profileImageUrl,
        mine,
      ];
}
