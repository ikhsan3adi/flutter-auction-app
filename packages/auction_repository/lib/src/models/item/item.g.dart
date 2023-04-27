// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as int,
      itemId: json['itemId'] as int,
      ownerUserId: json['ownerUserId'] as int,
      ownerUsername: json['ownerUsername'] as String,
      ownerName: json['ownerName'] as String,
      itemName: json['itemName'] as String,
      description: json['description'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      initialPrice: json['initialPrice'] as int,
      images: (json['images'] as List<dynamic>)
          .map((e) => ItemImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'ownerUserId': instance.ownerUserId,
      'ownerUsername': instance.ownerUsername,
      'ownerName': instance.ownerName,
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'description': instance.description,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'initialPrice': instance.initialPrice,
      'images': instance.images,
    };

ItemImage _$ItemImageFromJson(Map<String, dynamic> json) => ItemImage(
      id: json['id'] as int,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ItemImageToJson(ItemImage instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };
