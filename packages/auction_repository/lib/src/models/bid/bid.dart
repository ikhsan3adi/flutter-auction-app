import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'bid.g.dart';

@JsonSerializable()
class Bid extends Equatable {
  final int id;
  final int auctionId;
  final int bidPrice;
  final User? bidder;
  final DateTime createdAt;
  final String profileImageUrl;
  final bool mine;

  const Bid({
    required this.id,
    required this.auctionId,
    required this.bidPrice,
    this.bidder,
    required this.createdAt,
    required this.profileImageUrl,
    required this.mine,
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
