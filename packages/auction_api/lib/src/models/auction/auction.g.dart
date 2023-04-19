// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auction _$AuctionFromJson(Map<String, dynamic> json) => Auction(
      id: json['id'] as int,
      itemId: json['itemId'] as int,
      ownerUserId: json['ownerUserId'] as int,
      ownerUsername: json['ownerUsername'] as String,
      ownerName: json['ownerName'] as String,
      itemName: json['itemName'] as String,
      description: json['description'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      dateCompleted: DateTime.parse(json['dateCompleted'] as String),
      initialPrice: json['initialPrice'] as int,
      finalPrice: json['finalPrice'] as int?,
      winnerUserId: json['winnerUserId'] as int?,
      winnerName: json['winnerName'] as String?,
      winnerUsername: json['winnerUsername'] as String?,
      status: $enumDecode(_$AuctionStatusEnumMap, json['status']),
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AuctionToJson(Auction instance) => <String, dynamic>{
      'id': instance.id,
      'ownerUserId': instance.ownerUserId,
      'ownerUsername': instance.ownerUsername,
      'ownerName': instance.ownerName,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'description': instance.description,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'dateCompleted': instance.dateCompleted.toIso8601String(),
      'initialPrice': instance.initialPrice,
      'finalPrice': instance.finalPrice,
      'winnerUserId': instance.winnerUserId,
      'winnerUsername': instance.winnerUsername,
      'winnerName': instance.winnerName,
      'status': _$AuctionStatusEnumMap[instance.status]!,
      'imageUrls': instance.imageUrls,
    };

const _$AuctionStatusEnumMap = {
  AuctionStatus.open: 'open',
  AuctionStatus.closed: 'closed',
};
