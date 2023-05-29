// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auction _$AuctionFromJson(Map<String, dynamic> json) => Auction(
      id: json['auction_id'] as String,
      itemId: json['item_id'] as String,
      author: json['author'] == null
          ? const User(id: '-', username: '', email: '', name: '')
          : User.fromJson(json['author'] as Map<String, dynamic>),
      itemName: json['item_name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      dateCompleted: json['date_completed'] == null
          ? null
          : DateTime.parse(json['date_completed'] as String),
      initialPrice: json['initial_price'] == null
          ? 0
          : int.parse(json['initial_price'] as String),
      finalPrice: json['final_price'] == null
          ? 0
          : int.parse(json['final_price'] as String),
      winner: json['winner'] == null
          ? null
          : User.fromJson(json['winner'] as Map<String, dynamic>),
      status: $enumDecode(_$AuctionStatusEnumMap, json['status']),
      bidCount: json['bid_count'] as int? ?? 0,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ItemImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AuctionToJson(Auction instance) => <String, dynamic>{
      'auction_id': instance.id,
      'item_id': instance.itemId,
      'author': instance.author,
      'item_name': instance.itemName,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'date_completed': instance.dateCompleted?.toIso8601String(),
      'initial_price': instance.initialPrice,
      'final_price': instance.finalPrice,
      'winner': instance.winner,
      'status': _$AuctionStatusEnumMap[instance.status]!,
      'bid_count': instance.bidCount,
      'images': instance.images,
    };

const _$AuctionStatusEnumMap = {
  AuctionStatus.open: 'open',
  AuctionStatus.closed: 'closed',
};
