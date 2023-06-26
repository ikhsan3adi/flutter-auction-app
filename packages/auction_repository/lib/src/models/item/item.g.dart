// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['item_id'] as String,
      userId: json['user_id'] as String,
      itemName: json['item_name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      initialPrice: json['initial_price'] == null
          ? 0
          : int.parse(json['initial_price'] as String),
      auctioned: json['auctioned'] as bool? ?? false,
      images: (json['images'] as List<dynamic>)
          .map((e) => ItemImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'item_id': instance.id,
      'user_id': instance.userId,
      'item_name': instance.itemName,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'initial_price': Item.valueToString(instance.initialPrice),
      'auctioned': Item.valueToString(instance.auctioned),
      'images': Item.valueToString(instance.images),
    };
