// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bid _$BidFromJson(Map<String, dynamic> json) => Bid(
      id: json['bid_id'] as String,
      auctionId: json['auction_id'] as String,
      bidPrice: json['bid_price'] == null
          ? 0
          : int.parse(json['bid_price'] as String),
      bidder: json['bidder'] == null
          ? null
          : User.fromJson(json['bidder'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      profileImageUrl: json['profile_image'] as String?,
      mine: json['mine'] as bool? ?? false,
    );

Map<String, dynamic> _$BidToJson(Bid instance) => <String, dynamic>{
      'bid_id': instance.id,
      'auction_id': instance.auctionId,
      'bid_price': instance.bidPrice,
      'bidder': instance.bidder,
      'created_at': instance.createdAt.toIso8601String(),
      'profile_image': instance.profileImageUrl,
      'mine': instance.mine,
    };

BidWithAuction _$BidWithAuctionFromJson(Map<String, dynamic> json) =>
    BidWithAuction(
      auction: Auction.fromJson(json['auction'] as Map<String, dynamic>),
      bids: (json['bids'] as List<dynamic>)
          .map((e) => Bid.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BidWithAuctionToJson(BidWithAuction instance) =>
    <String, dynamic>{
      'auction': instance.auction,
      'bids': instance.bids,
    };
