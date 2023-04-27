// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as int,
      userId: json['userId'] as int,
      itemName: json['itemName'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      initialPrice: json['initialPrice'] as int,
      images: (json['images'] as List<dynamic>)
          .map((e) => ItemImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'itemName': instance.itemName,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'initialPrice': instance.initialPrice,
      'images': instance.images,
    };
