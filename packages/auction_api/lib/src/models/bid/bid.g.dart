// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bid _$BidFromJson(Map<String, dynamic> json) => Bid(
      id: json['id'] as int,
      userId: json['userId'] as int,
      auctionId: json['auctionId'] as int,
      username: json['username'] as String,
      name: json['name'] as String,
      bidPrice: json['bidPrice'] as int,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      profileImageUrl: json['profileImageUrl'] as String,
      mine: json['mine'] as bool,
    );

Map<String, dynamic> _$BidToJson(Bid instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'auctionId': instance.auctionId,
      'username': instance.username,
      'name': instance.name,
      'bidPrice': instance.bidPrice,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'profileImageUrl': instance.profileImageUrl,
      'mine': instance.mine,
    };
