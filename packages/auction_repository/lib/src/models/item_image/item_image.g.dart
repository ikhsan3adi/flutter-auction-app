// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemImage _$ItemImageFromJson(Map<String, dynamic> json) => ItemImage(
      id: json['image_id'] as String?,
      url: json['image'] as String,
    );

Map<String, dynamic> _$ItemImageToJson(ItemImage instance) => <String, dynamic>{
      'image_id': instance.id,
      'image': instance.url,
    };
