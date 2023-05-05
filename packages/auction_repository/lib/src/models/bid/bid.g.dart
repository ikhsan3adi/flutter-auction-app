// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bid _$BidFromJson(Map<String, dynamic> json) => Bid(
      id: json['id'] as int,
      auctionId: json['auctionId'] as int,
      bidPrice: json['bidPrice'] as int,
      bidder: json['bidder'] == null
          ? null
          : User.fromJson(json['bidder'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      profileImageUrl: json['profileImageUrl'] as String?,
      mine: json['mine'] as bool? ?? false,
    );

Map<String, dynamic> _$BidToJson(Bid instance) => <String, dynamic>{
      'id': instance.id,
      'auctionId': instance.auctionId,
      'bidPrice': instance.bidPrice,
      'bidder': instance.bidder,
      'createdAt': instance.createdAt.toIso8601String(),
      'profileImageUrl': instance.profileImageUrl,
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
