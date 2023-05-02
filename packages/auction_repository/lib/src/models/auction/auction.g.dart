// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auction _$AuctionFromJson(Map<String, dynamic> json) => Auction(
      id: json['id'] as String,
      itemId: json['itemId'] as String,
      author: json['author'] == null
          ? const User(id: '-', username: '', email: '', name: '')
          : User.fromJson(json['author'] as Map<String, dynamic>),
      itemName: json['itemName'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      dateCompleted: json['dateCompleted'] == null
          ? null
          : DateTime.parse(json['dateCompleted'] as String),
      initialPrice: json['initialPrice'] as int,
      finalPrice: json['finalPrice'] as int?,
      winner: json['winner'] == null
          ? null
          : User.fromJson(json['winner'] as Map<String, dynamic>),
      status: $enumDecode(_$AuctionStatusEnumMap, json['status']),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ItemImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AuctionToJson(Auction instance) => <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'author': instance.author,
      'itemName': instance.itemName,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'dateCompleted': instance.dateCompleted?.toIso8601String(),
      'initialPrice': instance.initialPrice,
      'finalPrice': instance.finalPrice,
      'winner': instance.winner,
      'status': _$AuctionStatusEnumMap[instance.status]!,
      'images': instance.images,
    };

const _$AuctionStatusEnumMap = {
  AuctionStatus.open: 'open',
  AuctionStatus.closed: 'closed',
};
